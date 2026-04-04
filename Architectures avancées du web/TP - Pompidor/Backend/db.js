const { MongoClient } = require('mongodb');

const DB_NAME = 'ECOMMERCE'
const client = new MongoClient('mongodb://localhost:27017');
const db = client.db(DB_NAME);

module.exports = db;