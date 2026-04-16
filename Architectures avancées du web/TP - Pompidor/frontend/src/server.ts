import {
    AngularNodeAppEngine,
    createNodeRequestHandler,
    isMainModule,
    writeResponseToNodeResponse,
} from '@angular/ssr/node';
import express from 'express';
import { join } from 'node:path';
import { Db, MongoClient } from 'mongodb';

const browserDistFolder = join(import.meta.dirname, '../browser');

const app = express();
const angularApp = new AngularNodeAppEngine();

const url: string = "mongodb://localhost:27017";
const client: MongoClient = new MongoClient(url);
await client.connect();
const db : Db = client.db("ECOMMERCE");

app.use(
    express.static(browserDistFolder, {
        maxAge: '1y',
        index: 'index.html',
        redirect: false,
    }),
);

app.get('/api/homepage', async (_, res) => {
    return res.json((await db.collection('rayons').find().toArray()));
});

app.get('/api/articles', async (_, res) => {
    return res.json(await db.collection('articles').find().toArray());
});

app.get('/api/cart', async (_, res) => {
    const items = await db.collection('cart').find().toArray();
    res.json(items);
});

app.post('/api/cart/add', express.json(), async (req, res) => {
    const nom: string | undefined = req.body?.nom;
    const quantityRaw = req.body?.quantity;
    const quantity = Number(quantityRaw) ? Number(quantityRaw) : 1;

    if (!nom || quantity < 1) {
        return res.status(400).json({ status: false, message: 'Produit ou quantite invalide' });
    }

    const article = await db.collection('articles').findOne({ nom });

    if (!article) {
        return res.status(404).json({ status: false, message: 'Produit introuvable' });
    }

    await db.collection('cart').updateOne(
        { nom: article['nom'] },
        {
            $setOnInsert: {
                nom: article['nom'],
                marque: article['marque'],
                prix: article['prix'],
            },
            $inc: { quantity },
        },
        { upsert: true },
    );

    return res.json({ status: true, message: 'Produit ajoute au panier' });
});

app.delete('/api/cart/delete', express.json(), async (req, res) => {
    const nom: string | undefined = req.body?.nom;

    if (!nom) {
        return res.status(400).json({ status: false, message: 'Produit ou quantite invalide' });
    }

    const article = await db.collection('articles').findOne({ nom });

    if (!article) {
        return res.status(404).json({ status: false, message: 'Produit introuvable' });
    }

    await db.collection('cart').deleteOne({ nom });

    return res.json({ status: true, message: 'Produit supprimer du panier' });
});

app.use((req, res, next) => {
    angularApp
        .handle(req)
        .then((response) =>
            response ? writeResponseToNodeResponse(response, res) : next(),
        )
        .catch(next);
});

if (isMainModule(import.meta.url) || process.env['pm_id']) {
    const port = process.env['PORT'] || 4000;
    app.listen(port, (error) => {
        if (error) {
            throw error;
        }

        console.log(`Node Express server listening on http://localhost:${port}`);
    });
}

export const reqHandler = createNodeRequestHandler(app);
