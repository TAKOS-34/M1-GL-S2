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
    res.json(await db.collection('rayons').distinct('rayon'));
});

app.get('/api/articles', async (_, res) => {
    res.json(await db.collection('articles').find().toArray());
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
