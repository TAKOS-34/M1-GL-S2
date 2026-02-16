#import "@preview/modern-report-umfds:0.1.2": umfds

#show: umfds.with(
    title: [
        *M1 Génie Logiciel* \ \
        HAI811I : Développement et programmation pour supports mobiles  \
        TP1 \ \ \
    ],
    authors: ("Elliot DURAND",),
    date: "16 Février 2026",
    lang: "fr",
)

#outline()

#pagebreak()

= Introduction

== Les différents projets réalisés

Dans ce TP, nous allons apprendre les bases de la programmation pour développer une application native pour Android. Ce TP ainsi que ce rapport seront segmentés en 3 parties, symbolisant les 3 applications demandées :

\

- Une première application, introduisant l'environnement et l'architecture de base d'une application android. Cette application sera un simple formulaire, avec une fenêtre de confirmation d'envoi, un récapitulatif des informations sur une autre vue ainsi qu'une dernière vue permettant d'appeler un numéro.

\

- La deuxième application sera une reprise de l'application de la SNCF. L'utilisateur insérera dans un formulaire la ville de départ et de destination ainsi qu'une date, et une liste de trajets lui sera affichée sur une nouvelle vue (ce seront de vrais trajets car une requête API à la SNCF sera faite). Il pourra ensuite cliquer sur un voyage pour consulter les détails de ce dernier.

\

- La troisième et dernière application sera un agenda, avec affichage et ajout d'évènement.

\

== Technologies utilisées

Ce TP est hébergé sur *Git*, le sujet nous demandant explicitement de séparer distinctement le code de chaque exercice, le code fourni dans le `.zip` est relié à un projet Git contenant une branche par exercice. Il suffit donc de faire par exemple : `git checkout exercice3-2` pour avoir le code correspondant deuxième version de l'exercice 3.
\ \
Le TP a été réalisé en *Java* pur et *non* en *Kotlin* pour plusieurs raisons :
\
- L'objectif pour le moment étant d'apprendre et de comprendre l'architecture et le fonctionnement d'une application mobile, l'introduction d'un langage, même similaire, différent de Java (que nous connaissons maintenant assez bien), ralentit le processus d'apprentissage.
\
- De plus, il tente plus à l'utilisation de l'IA pour des problèmes de code simple, et copié collé du code fait par IA est moins instructif que d'aller regarder le cours.
\
- Je trouve la documentation Kotlin assez mal faite.
\
Pour les raisons ci-dessus, ce TP est réalisé en Java exclusivement.
\ \
Ce rapport a été écrit en #link("https://typst.app/")[*Typst*]. Les schémas ont été réalisés avec le site #link("https://excalidraw.com/")[*Excalidraw*].

#pagebreak()

= Architecture commune des applications

L'architecture commune des applications respecte les normes des applications android et les principes fonctionnels et non fonctionnels. Ci-dessous une image de l'arborescence de fichier :

#figure(
    image("images/archi_global.png", width: 30%),
    caption: "Arborescence réelle des projets (affichage 'Projet' de Android studio)"
)
\
La structure utilisée est celle générée par Android Studio et l'on place les fichiers aux bons endroits.
\ \
Les ressources sont placées dans le dossier `res`, chacun dans leur espace prévu. Les ressources textuelles (style, valeurs, dimensions) dans le dossier `values`. Les vues dans le dossier `layout`. Les images dans le dossier `drawable`.
\ \
Les activités dans le `main/java/packages_names/`.
\ \
Les manifests dans le `main/`.
\ \
Le respect des principes non fonctionnels se fait par le moins de valeurs en dur dans les layouts, mais plutôt dans les fichiers `xml` du dossier `values` (principe SRP). Rendre le code le plus modulable et réutilisable en écrivant, quand cela est possible, des méthodes pouvant répondre à des besoins dans différentes parties de l'application. Par exemple la validation des champs de saisie.

#pagebreak()

= Application 1 : Formulaire simple

Comme mentionné en introduction, la première application sera un simple formulaire avec validation, un récapitulatif des informations saisies, et un dernier écran afin d'appeler le numéro soumis dans le formulaire.

== Architecture globale

Ci-dessous un schéma illustrant les différentes vues de l'application et les actions possibles :

#figure(
    image("images/app1-1.png", width: 100%),
    caption: "Architecture globale de l'application 1"
)

== Logique de l'application

=== Première activité

La première activité contient des champs de saisie simples. Ces dernières indiquent ce qu'il faut remplir à l'aide de `hint`, des placeholder. Il existe trois versions pour l'affichage de cette activité :

- La branche Git `exercice3-1` : Les champs sont directement dans le fichier Java `Main.java`, qui représente l'activité principal de l'application.
\
- La branche Git  `exercice3-2` : Les champs sont dans un layout XML.
\
- La branche Git `exercice3-3` : Une version avec un affichage différent, des labels sont présents avant les champs de saisie, et les `hint` sont un exemple de quoi remplir. Par souci d'ergonomie, cette version ne sera pas conservée. Ci-dessous un exemple de l'affichage du formulaire de cette version :

#figure(
    image("images/app1-2.png", width: 30%),
    caption: "Application 1 avec des labels"
)
\
Lors de la soumission du formulaire, une vérification des champs est effectuée dans le code Java. Ci-dessous un affichage d'erreur dans les champs de saisie :

#figure(
    image("images/app1-3.png", width: 60%),
    caption: "Erreurs dans les champs de l'application 1"
)
\
Si le formulaire est bien validé, alors on construit un `AlertDialog` (la norme en Android) afin de demander à l'utilisateur s'il est certain de son choix. Il existe cependant deux versions de cette façon de confirmer l'envoie du formulaire :

- La branche Git `exercice5-1` : Cette version utilise la méthode `startActivityForResult`. On définit une variable `submitButtonCode` à 1, puis on démarre un intent d'une activité avec deux boutons (dans le code elle s'appelle `FormConfirmation.java`), lors de la soumission de l'utilisateur, la méthode `onActivityResult` est déclenchée et l'on peut décider de la prochaine action avec les valeurs de retour `RESULT_OK` et `RESULT_CANCELED`. Par souci de convention, cette version ne sera pas conservée. Ci-dessous un aperçu de l'activité `FormConfirmation` :

#figure(
    image("images/app1-4.png", width: 30%),
    caption: "Activité de confirmation de l'application 1"
)
\
- La branche Git  `exercice5-2` : Utilisation de `AlertDialog`.

La branche Git `exercice4` introduit le langage Anglais de l'éditeur de langue de Android Studio, ce dernier crée automatiquement un fichier `strings.xml` dans le dossier `values-en`. Ci-dessous le formulaire en version anglaise :

#figure(
    image("images/app1-5.png", width: 30%),
    caption: "Application 1 en anglais"
)
\

=== Deuxième activité

La branche Git `exercice6` introduit la deuxième activité.
\ \
Cette dernière a pour but de récupérer les informations transmises par l'activité précédente. Cela se fait via le passage de données par les extras d'un Intent. L'activité voulant transmettre des données utilise la méthode `putExtra` sur l'intent en passant une paire clé valeur. L'activité voulant récupérer ses données utilise la méthode `getStringExtra` sur l'intent précédent récupéré grâce à la méthode `getIntent`, en précisant la clé, elle récupère sa valeur. Il suffit d'utiliser la méthode `setText` sur les champs dédiés à l'affichage des informations, définis dans le layout.
\ \
Le bouton Retour appelle simplement la méthode `finish`. Cette méthode va chercher l'activité précédente dans la pile d'activité Android et va l'afficher. Cette manière de faire est la meilleure car au lieu de charger de nouveau l'activité, elle va simplement la chercher dans la mémoire. Elle permet également de charger les valeurs précédemment soumises dans le formulaire automatiquement, sans repasser de valeur via la méthode `putExtra`. 

=== Troisième activité

La branche Git `exercice7` introduit la troisième activité.
\ \
Cette dernière affiche le numéro précédemment soumis, une image ainsi qu'un bouton pour appeler le numéro. L'affichage du numéro se fait de la même manière que l'activité précédente, soit le passage de données par les extras d'un Intent.
\ \
L'image est elle mise dans le dossier `drawable` et chargée dans le layout via la propriété `ImageView`.
\ \
Le bouton d'appel déclenche deux opérations dans le code Java. En premier il parse le numéro via la classe `URI` et sa méthode `parse`. Il y a ensuite un Intent implicite qui est lancé, avec l'action `ACTION_DIAL`, ce type d'action permet de lancer l'application de téléphone. C'est une requête à l'API vers le système interne d'Android , ce dernier se charge de lancer l'application de téléphone qui lui est propre.

= Application 2 : SNCF

Cette application permettra à un utilisateur de saisir une ville de départ, une ville d'arrivée, ainsi qu'une date et de pouvoir consulter les trains disponibles.
\ \
A partir de maintenant, le développement se concentrera sur la logique métier, la propreté du code et les squelettes des vues. Le design sera (quasiment) totalement délégué à une IA (Gemini). Ce dernier fera de belles interfaces, rapidement (car il ne touche qu'aux vues) et utilise les méthodes modernes de développement d'UI.
\ \
Les icônes seront importées grâce au Vector Asset de Android Studio, outil très utile pour avoir de belles icones rapidement, gratuitement et bien intégré à l'écosystème Android.

== Première version

Une première version de cette application utilise la branche Git `exercice8-1`.

=== Architecture globale

Ci-dessous un schéma illustrant les différentes vues de l'application et les actions possibles :

#figure(
    image("images/app2-1.png", width: 100%),
    caption: "Architecture globale de l'application 2"
)

=== Logique de l'application

==== Première activité

Nous retrouvons ici un simple formulaire, avec vérification de remplissage et de format. La ville de départ et d'arrivée nous est demandée. Pour la sélection de la date, l'on utilise un `Builder` de la classe `MaterialDatePicker`. Le bouton "chercher des trajets" est un intent qui lance la deuxième activité.

==== Deuxième activité

Lors du lancement de la deuxième activité, des trajets aléatoires sont générés avec la création d'objet `Trajet` via la méthode `genererTrajetsAleatoires`.
\ \
Pour afficher la liste des trajets, l'on utilise la norme android, soit `RecyclerView`, cette dernière permet de gérer efficacement l'affichage de listes. Un autre concept est celui d'`Adaptor`, il est lié à un `RecyclerView` et son rôle est de faire le lien entre les données ainsi que l'affichage graphique. Dans notre cas, l'`Adaptor` formate les données en entrées afin de créer des layout "template" `trip_item` (ces composants graphiques ont été générés par IA, mais pas la logique métier).
\ \
Chaque trajet affiche des informations telles que la date et ville de départ, la date et ville d'arrivée, le temps du trajet et le prix. Le nombre de trajets trouvés est indiqué entre parenthèses à droite de "Trajets disponibles" en haut de l'écran.
\ \
En bas de l'activité se trouve un bouton retour, exécutant `finish`.

== Deuxième version

Une deuxième version de cette application utilise la branche Git `exercice8-2`. Cette version utilise l'API officielle SNCF. Se familiariser à l'intégration d'API dans une application mobile est crucial aujourd'hui.

=== Architecture globale

Ci-dessous un schéma illustrant les différentes vues de l'application et les actions possibles (version avec API) :

#figure(
    image("images/app2-2.png", width: 100%),
    caption: "Architecture globale de l'application 2 avec intégration API"
)

=== Logique de l'application

Il faut tout d'abord demander une clé API sur le site de la SNCF (_ https://numerique.sncf.com/startup/api/token-developpeur/ _).
\ \
Pour des raisons de sécurité, cette dernière sera dans le fichier local (non destiné à être mis sur Git) `local.properties` et récupérable dans le code via la variable `BuildConfig.SNCF_API_KEY`. Ensuite il faut mettre dans notre fichier de configuration Gradle le plugin `secrets-gradle-plugin`, afin d'utiliser cette variable dans tout le projet.

==== Première activité

La première activité est maintenant nettement plus complexe.
\ \
Il faut mettre un écouteur sur chaque nouveau caractère de notre utilisateur dans les champs des villes de départ et d'arrivée. Lorsque le texte dépasse 3 caractères (pour ne pas envoyer trop de requêtes), on appelle la méthode `fetchCities`. Une requête API avec le texte inséré est effectuée, la SNCF nous répond avec des noms de villes et d'ID (très important) correspondant. Cette réponse est stockée dans une `HashMap` afin de conserver l'ID.
\ \
On affiche la liste des clés de la `HashMap` à l'utilisateur grâce au champ de saisie `MaterialAutoCompleteTextView`, qui est la fusion entre un champ de saisie de texte et une liste déroulante.
\ \
Lors de la soumission du formulaire, on récupère l'id associé aux villes dans la `HashMap` et on convertit la date grâce à la méthode `formatToSncfDate`, qui la convertit en `SimpleDateFormat`. Ces informations sont transmises à l'autre activité via l'intent.

==== Deuxième activité

Lors de la création de l'activité, l'on récupère les valeurs transmises par l'activité 1. Ensuite, une requête API à la SNCF est faite afin de trouver les 20 premiers trajets correspondant aux critères de recherche.
\ \
Les valeurs transmises à l'API seront les ID de villes et la date convertie au format standard `SimpleDateFormat`. Ces conversions sont essentielles afin de se conformer au protocole de communication de l'API SNCF. 
\ \
Comme la première version de l'activité, l'on affiche la liste via `RecyclerView` et son `Adaptor`. Cependant, certaines informations sont manquantes par rapport à la première version, comme le prix. Cela vient de notre clé API qui n'est pas assez "puissante" pour récupérer le prix. Cela est voulu par la SNCF afin éviter à n'importe qui de pouvoir facilement et rapidement faire un comparateur de prix.

== Améliorations possibles

En effet notre application est encore très simple, mais le manque de temps oblige à faire des choix. Dans un premier temps l'on aurait pu mettre la possibilité d'un aller retour. Certains ont fait une activité pour chaque nouveau champ de saisie, cela est plutôt simple à mettre en place (avec passage de valeurs par intent), mais j'ai toujours trouvé cela insupportable de segmenter les formulaires sur plusieurs pages. Le choix d'avoir un seul formulaire sur la première activité est donc tout à fait intentionnel.

= Troisième application : Agenda

La troisième et dernière application sera un agenda avec gestion d'évènements. Cette application utilise la branche Git `exercice9`.

== Architecture globale

Ci-dessous un schéma illustrant les différentes vues de l'application et les actions possibles :

#figure(
    image("images/app3-1.png", width: 100%),
    caption: "Architecture globale de l'application 2 avec intégration API"
)

== Logique de l'application

=== Interface principale

L'interface principale est séparée en trois grandes parties, de bas en haut :

- Le calendrier est importé de la bibiothèque Applandeo MaterialCalendarView. Ce choix est motivé par le fait qu'il soit bien plus poussé en fonctionnalité, plus esthétique et pas forcément plus demandant en performance que `CalenderView` natif d'android. Il permet par exemple d'afficher des petits points en dessous des jours possédant un ou plusieurs évènements. Les écouteurs d'évènements sont également bien plus simples à mettre en place. 
\
- L'affichage des tâches présentes en fonction du jour (indiqué juste au dessus de la liste) sous forme de liste. Le composant `RecyclerView` et un `Adapter` est utilisé, de la même manière que pour l'application 2. Chaque évènement affiche des informations telles que le titre, la couleur sous forme de point, la date ainsi que, si elle est remplie, la description. Une image de poubelle symbolise la demande de suppression de l'évènement.
\
- Le bouton plus, permettant d'ajouter un évènement.

=== Ajout d'un évènement

Lorsque le bouton plus est pressé, une `AlertDialog` est lancée. Elle permet via un formulaire, d'ajouter le titre, la description, une date de début et de fin, une case à cocher pour signifier que l'évènement dure toute la journée et une couleur. Les champs obligatoires sont dénotés avec une étoile (\*).
\ \
Si la case "Toute la journée" est cochée, l'utilisateur peut ne pas remplir la date de fin. Également, lors de son affichage sur l'interface principale, seulement le jour et non l'heure sera affiché, avec la mention "Toute la journée".

=== Suppression d'un évènement

Si l'utilisateur clique sur le bouton poubelle, une fenêtre de confirmation s'affiche. Si l'utilisateur sélectionne oui, l'évènement est supprimé.

== Gestion de la persistance

L'application intègre de la persistance grâce à `Room`. Cette bibliothèque très légère d'Android intègre une surcouche afin de gérer une base de données SQLite (base de données en un seul fichier) via une API. Ceci est la manière la plus simple et commune d'intégrer de la persistance structurée dans une application Android.
\ \
On déclare une `Entity`, un objet qui sera une table dans notre base de données. Ici l'event sera composé des attributs correspondant à l'évènement, soit un title, description, etc.
\ \
On crée ensuite un `Dao`, une interface définissant les méthodes utilisables sur l'`Entity`.
\ \
La dernière étape est de créer une database, avec une classe abstraite possédant l'annotation `Database`. Après avoir défini la méthode `getDatabase`, l'on peut récupérer la base de données et faire les appels de méthodes du `Dao` partout dans le code.
\ \
Dans notre cas, voici comment la base de données est sollicitée :

- Récupération de tous les évènements pour afficher les points en dessous des jours, lors du chargement de l'application, l'ajout ou la suppression d'évènement.
\
- Récupération des évènements sur un seul jour lors du clic de l'utilisateur sur un jour. Grâce à l'écouteur fixé sur le calendrier, l'on peut faire une requête à la base de données avec le jour précis.
\
- Ajout d'un évènement, après la soumission du formulaire d'ajout.
\
- Suppression d'un évènement, après la soumission du formulaire de suppression.

== Améliorations possibles

Les premières améliorations à apporter seraient plus de fonctionnalités sur les évènements, par exemple la répétition par année (anniversaire, fête). Il manque également une opération CRUD, la plus difficile, la mise à jour d'évènement. Après nous pouvons voir plus loin, par exemple avec les notifications lors du démarrage d'un évènement. Ces améliorations auraient pu être mises en place avec plus de temps, mais j'ai préféré prioriser les fonctionnalités les plus importantes.

#pagebreak()
= Conclusion

Ce TP nous a enseigné les bases du développement des applications android. Soit l'affichage d'informations sous forme de liste (très commun), les formulaires, le passage de valeurs entre activités, les différents écrans via les activités et les vues, l'appel API des applications du téléphone (le téléphone dans notre cas), la gestion de la persistance et même l'appel d'une API extérieure.
\ \
La charge de travail demandée étant conséquente, je regrette de ne pas avoir pu plus étudier plus en profondeur le design des applications, ayant tout délégué à l'IA par manque de temps. Je pense cependant avoir appris beaucoup.