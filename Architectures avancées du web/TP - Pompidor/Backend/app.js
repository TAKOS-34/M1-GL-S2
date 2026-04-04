const express = require('express');
const db = require('./db');

const app = express();
const PORT = 3000;

app.listen(PORT, () => {
    console.log(`App listening on port ${PORT}`);
});

app.use(express.urlencoded({ extended: true }));
app.use(express.json());

app.use((err, req, res, next) => {
    console.error(err);
    res.status(500).send('Internal server error');
});



app.get('/articles', async (req, res) => {
    res.json(await db.collection('articles').find().toArray());
});

app.get("/catalogue/:rayon/:marque/:prixMax", async (req, res) => {
	let filtre = {};

	if (req.params.rayon != "*") filtre['rayon'] = req.params.rayon;
	if (req.params.marque != "*") filtre['marque'] = req.params.marque;
	if (req.params.prixMax != "*") filtre['prix'] = {$lt: parseFloat(req.params.prixMax)};

	res.json(await db.collection("articles").find(filtre).toArray());
});

app.get('/users', async (req, res) => {
    res.json(await db.collection('users').find().toArray());
});

app.get('/rayons', async (req, res) => {
    res.json(await db.collection('rayons').distinct('rayon'));
});

app.post("/user/login", async (req,res) => {
	const user = await db.collection("users").find(req.body).toArray();

	if (user.length === 1) {
        res.json({ status: true, message: "Authentification réussie" });
    } else {
        res.json({ status: false, message: "Email et/ou mot de passe incorrect" });
    }
});

app.post("/user/signUp", async (req,res) => {
    if (!req.body.email || !req.body.password) {
        res.status(400).json({ status: false, message: "Email ou mot de passe manquant" });
    }
	const user = await db.collection("users").find({ email: req.body.email }).toArray();

	if (user.length === 1) {
        res.json({ status: false, message: "Email déjà pris" });
    } else {
        await db.collection("users").insertOne(req.body);
        res.json({ status: true, message: "Compte créer" });
    }
});