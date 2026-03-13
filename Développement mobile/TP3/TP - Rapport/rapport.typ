#import "@preview/modern-report-umfds:0.1.2": umfds

#show: umfds.with(
    title: [
        *M1 Génie Logiciel* \ \
        HAI811I : Développement et programmation pour supports mobiles  \
        TP3 \ \ \
    ],
    authors: ("Elliot DURAND",),
    date: "30 Mars 2026",
    lang: "fr",
)

#outline()

#pagebreak()

= Introduction

== Les différents exercices réalisés

Ce TP introduit la conception de base de données en local sur des applications Android.
\ \
L'objectif est, dans un premier temps, de créer une page d'enregistrement pour un utilisateur. Après avoir enregistré ces données de manière persistante, il faut lui montrer ces dernières sur une autre page servant de récapitulatif.
\ \
La deuxième application reprend la première, permettant maintenant de se connecter à l'aide d'un login et un mot de passe. Ensuite, si le mot de passe est le bon, ou l'utilisateur vient de s'inscrire, il sera redirigé vers son propre agenda, où chaque évènement sera relié à son login en base de données.

== Technologies utilisées

Ce TP est hébergé sur *Git*, le sujet nous demandant explicitement de séparer distinctement le code de chaque exercice, le code fourni dans le `.zip` est relié à un projet Git contenant une branche par exercice. Il suffit donc de faire par exemple : `git checkout exercice2` afin d'avoir le code correspondant à l'exercice 2.
\ \
Le TP a été réalisé en *Java* pur et *non* en *Kotlin* pour plusieurs raisons :
\
- L'objectif pour le moment étant d'apprendre et de comprendre l'architecture et le fonctionnement d'une application mobile, l'introduction d'un langage, même similaire, différent de Java (que nous connaissons maintenant assez bien), ralentit le processus d'apprentissage.
\
- De plus, il tente plus à l'utilisation de l'IA pour des problèmes de code simple, et copier coller du code fait par IA est moins instructif que d'aller regarder le cours.
\
- Je trouve la documentation Kotlin assez mal faite.
\
Pour les raisons ci-dessus, ce TP est réalisé en Java exclusivement.
\ \
Ce rapport a été écrit en #link("https://typst.app/")[*Typst*]. Les schémas ont été réalisés avec le site #link("https://excalidraw.com/")[*Excalidraw*].

#pagebreak()

= Application 1 : Enregistrement et récapitulatif

Le code de cet exercice correspond à la branche git : `exercice1`.

#figure(
    "",
    caption: "Architecture globale de l'application 1"
)

La base de ce TP étant la persistance de données, comme pour mon TP1, j'ai utilisé la bibliothèque `Room` de la suite `JetPack`. C'est actuellement un des meilleurs moyens pour gérer une base de données locale.
\ \
Nous utiliserons l'architecture standard pour la gestion de cette base de données, avec un singleton pour récupérer son instance, dans la classe `DatabaseManager`, les entités dans le package `entity` et les DAO dans le package `dao`.
\ \
La première activité est un simple formulaire, avec vérification de champs. Si le formulaire est valide, alors les informations fournies par l'utilisateur sont enregistrées en base de données et il est redirigé vers la deuxième activité. La valeur de son login est fournie par intent dans cette dernière.
\ \
Dès cette version de l'application, le login de l'utilisateur doit être unique, s'il fournit un qui est déjà utilisé, une erreur lui sera signalée.
\ \
Une fois dans la deuxième activité, on récupère les informations saisies par l'utilisateur avec une requête à la base de données avec le login de ce dernier. En effet il est moins coûteux de faire une requête que de passer par le Intent toutes les données insérées précédemment. Il nous reste ensuite à afficher les informations avec les méthodes `setText`.
\ \
À des fins de simplifications ici, les centres d'intérêts sont matérialisés par de simples attributs booléens. La bonne pratique aurait été de faire une relation many to many entre la table `interests` et la table `user` via la relation `user_interest`.

#pagebreak()
= Application 2 : Calendrier des utilisateurs

Le code de cet exercice correspond à la branche git : `exercice2`.

#figure(
    "",
    caption: "Architecture globale de l'application 2"
)

L'application 2 reprend l'application 1. Nous gardons la même page d'inscription, et rajoutons une page de connexion, avec un login et un mot de passe.
\ \
Pour la connexion, il suffit simplement de récupérer l'utilisateur correspondant au login en base de données, s'il n'existe pas alors nous renvoyons une erreur. Nous comparons ensuite le mot de passe inséré dans le champ avec le mot de passe de l'utilisateur récupéré en base de données. S'ils correspondent alors l'utilisateur est redirigé vers son calendrier, avec le passage de son login par intent, sinon une erreur signalant le mauvais mot de passe est émise.
\ \
Lorsqu'un utilisateur vient de se connecter ou bien de s'inscrire, il arrive sur son calendrier et récupère ses informations avec une requête à la base de données en donnant son login, ce qui lui permet de récupérer son ID, et de demander les évènements qui lui sont associés.
\ \
Le calendrier est la fusion entre l'application 1 et l'application 3 du TP1. Il nous était demandé de faire une sorte d'agenda journalier pour chaque utilisateur, mais car j'avais déjà à peu près la même structure pour l'application du calendrier du TP1, j'ai décidé de l'ajouter directement dans cette application.
\ \
J'ai donc copié collé le code de mon TP1, et j'ai juste ajouté dans l'entité `event` une clé étrangère vers l'id de l'utilisateur à qui appartient cet évènement, une relation many to one. J'ai dû également modifier le DAO des évènements, afin d'utiliser l'ID de l'utilisateur avant de créer, consulter ou supprimer des évènements.
\ \
La documentation Android explique comment mettre en place une relation many to one avec Room, mais j'ai trouvé la solution très verbeuse pour ce TP, ceci est la raison pour laquelle je ne l'ai pas implémentée.
\ \
La sécurité pourrait être renforcée, il est impossible depuis l'application de récupérer les évènements d'un utilisateur sans son mot de passe. Cependant, quelqu'un qui s'y connait un peu peut facilement interroger la base de données et tester avec pleins d'id différents et récupérer les évènements associés (sans son mot de passe). Il faudrait chiffrer la base de données, l'externaliser sur un serveur, et vérifier à chaque requête d'un utilisateur un token correspondant à son identité, soit une implémentation overkill pour notre application.
\ \
Afin de renforcer un minimum la sécurité, j'ai ajouté le chiffrement de mot de passe à l'aide de `bcrypt`, la bibliothèque standard pour le chiffrement synchrone d'informations. Dans la classe `BcryptUtils` se trouvent deux méthodes, une permettant de chiffrer le mot de passe (pour l'inscription) et une permettant de comparer un mot de passe avec celui de la base de données (pour la connexion). Le chiffrement est synchrone, ce qui veut dire que même si un utilisateur lit la base de données, il ne pourra pas déchiffrer le mot de passe des utilisateurs, il sera obligé de tester toutes les combinaisons.

#pagebreak()
= Conclusion

Ce TP renforce encore notre connaissance d'Android, avec l'intégration de base de données. Très utile pour des applications pouvant fonctionner hors ligne, les performances avec la mise en cache ou même le stockage de données permanentes de manière structurée grâce à SQL.