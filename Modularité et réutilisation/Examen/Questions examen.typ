== 1

Simplifer les interactions avec la base de données. Il est une abstraction des opérations CRUD

== 2

POJO (Plain old Java object). Simple classe avec attributs et de getter / setter. Abstraction d'une table en base de données

== 3

Décalage qui peut exister entre le niveau d'abstraction de deux langages qui ont à travailler sur des structures de données communes (exemple : le DAO résoud ce problème)

== 4

Java Persistence API. Ensemble de conventions standardisé pour s'affranchir d'écrire du SQL. Ce n'est pas un framework, mais les ORM implémente comme la convention JPA. Standard ORM

== 5

+ Une relation père fils, soit fils le batiment et le père le campus

+ Non car Lazy loading

+ Oui car type de suppression en cascade

== 6

Unité logiciel fournis découplé avec une forte cohésion logique, étant initialisé au démarrage de l'application et pouvant être injecté

== 7

Gestion du CRUD et abstraction de la persistance

== 8

CRUD Repository contient les méthodes de base, PageAndSortingRepository ajoute des capacités de gestion de gros volumes de données

== 9

New/Transient | Entité créée \
Managed/Persistent | Entité persistée \
Detached | Entité sortie du CP \
Removed | Entité étiquetée comme étant à supprimer

== 10

Transient

== 11

Persistent

== 12

```java
@Query("SELECT s FROM Salle s ORDER BY s.batiment")
```

== 13

```java
@Query("SELECT s FROM Salle s WHERE s.etage = :et and s.batiment= :bt and s.batiement.campus.nom = :nom")
List<Salle> findByEtageAndBatiment(@Param("et") String et, @Param("bt") Batiment bt, @Param("nom") String nom);
```

== 14

Faire appel à du code extérieur non nécessairement connue à la compilation, code étendue par l'utilisateur

== 15

L’IoC est un concept architectural global, tandis que la DI est une implémentation technique spécifique de ce concept

== 16

Template Method Pattern : La classe parente définit la structure d'un algorithme et appelle des méthodes abstraites que les sous-classes implémentent
\ \
Observer Pattern : Le sujet central contrôle la diffusion des notifications. Les observateurs ne décident pas quand ils sont exécutés ; ils attendent d'être appelés par le sujet lors d'un événement

== 17

Le service locator demande à un annuaire la classe à injecté explicitement (alors que le DI explicite clairement quelle classe injecté), code boite noir (caché par l'annuaire, comparé à l'ID qui est directement dans le constructeur)

== 18

On a une interface qui est un point d'extension, puis les couches basses (classes) implémentes les couches hautes (interfaces)

== 19

Principe de conteneur, afin d'injecter des composants (`@Autowired`)

== 20

Pas d'autowired sur le repository et autowired sur campus

== 21

Role métier et transactionnel

== 22

Au niveau des services, elle permet de définir des règles lors d'opérations en bases de données en plus de protéger la table en écriture

== 23

L'accès à la base de données se fait uniquement en lecture

== 24

Programmation par aspect

== 25

La dépendance à injecter est optionnelle

== 26

Point d'entrée unique, séparation des préoccupations, orchestration et préparation des données, validation et sécurité

== 27

Facile

== 28

Model

model.addAttribute

== 29

Couple de clé valeur passé à la nouvelle vue

