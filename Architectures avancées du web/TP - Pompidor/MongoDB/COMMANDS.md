# Lancer le shell

`mongosh`

# Show tables

`show dbs`

# Sélectionner une base

`use <table>`

# Voir les collections

`show tables|collections`

# Requêtes

```
db.articles.find()
db.articles.find({ rayon: 'Telephonie' })
db.articles.find({ rayon: 'Telephonie', prix: { $gt: 50, $lt: 300 } })
db.articles.countDocuments()
db.articles.countDocuments({ rayon: 'Telephonie' })
db.articles.distinct('rayon')
```
