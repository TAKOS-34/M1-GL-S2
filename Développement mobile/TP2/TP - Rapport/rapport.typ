#import "@preview/modern-report-umfds:0.1.2": umfds

#show: umfds.with(
    title: [
        *M1 Génie Logiciel* \ \
        HAI811I : Développement et programmation pour supports mobiles  \
        TP2 \ \ \
    ],
    authors: ("Elliot DURAND",),
    date: "09 Mars 2026",
    lang: "fr",
)

#outline()

#pagebreak()

= Introduction

Ce TP est hébergé sur *Git*, le sujet nous demandant explicitement de séparer distinctement le code de chaque exercice, le code fourni dans le `.zip` est relié à un projet Git contenant une branche par exercice. Il suffit donc de faire par exemple : `git checkout exercice2` afin d'avoir le code correspondant à l'exercice 2. Toutes les applications sont traduites en anglais.
\ \
Le TP a été réalisé en *Java* pur et *non* en *Kotlin* pour plusieurs raisons :
\
- L'objectif pour le moment étant d'apprendre et de comprendre l'architecture et le fonctionnement d'une application mobile, l'introduction d'un langage, même similaire, différent de Java (que nous connaissons maintenant assez bien), ralentit le processus d'apprentissage.
\
- De plus, il tente plus à l'utilisation de l'IA pour des problèmes de code simple, et copié collé du code fait par IA est moins instructif que d'aller regarder le cours. J'essaye également de consulter la documentation de Java, même si je trouve cette dernière pas très bien faite. 
\
- Je trouve la documentation Kotlin assez mal faite.
\
Pour les raisons ci-dessus, ce TP est réalisé en Java exclusivement. 
\ \
Je n'utiliserai pas de bibliothèques graphique comme Material Design 3, l'objectif du TP étant de se focaliser sur l'utilisation des capteurs. Les aspects non fonctionnels seront considérés, par exemple utiliser les délais adaptés pour les envois d'informations des capteurs, afin d'économiser de la batterie.
\ \
Ce rapport a été écrit en #link("https://typst.app/")[*Typst*]. Les schémas ont été réalisés avec le site #link("https://excalidraw.com/")[*Excalidraw*].

#pagebreak()

= Application 1 : Liste des capteurs

Le code de cet exercice correspond à la branche git : `exercice1`.
\
#figure(
    image("images/app1.png", width: 30%),
    caption: "Capture d'écran de l'application 1"
)

La classe `SensorManager` (initialisée avec la méthode `getSystemService`) nous permet d'utiliser la méthode `getSensorList`, qui renvoie la liste des capteurs, des objets de type `Sensor`.
\ \
Nous avons externalisé la méthode de récupération des capteurs, afin de rendre le code modulaire, dans une classe `Sensor` du package `utils`. La méthode renvoie la liste des capteurs non nulls détectés par `SensorManager`. 
\ \
Pour l'affichage de la liste, nous réutiliserons ce qui a été fait dans le TP 1, soit un `Adapter` (ici `CaptorListAdapter`) avec une `RecyclerView` et une vue `captor_item`.

= Application 2 : Gérer un capteur essentiel non disponible

Le code de cet exercice correspond à la branche git : `exercice2`.
\
#figure(
    image("images/app2-1.png", width: 30%),
    caption: "Capture d'écran de l'application 2"
)

Pour une petite application de randonnée, on considère qu'avoir une boussole est indispensable, tandis qu'avoir l'altitude est certes important, mais on peut fonctionner sans. L'application va donc vérifier la présence de trois capteurs : le magnétomètre, l'accéléromètre et le capteur de pression. Les deux premiers sont indispensables pour faire une boussole, tandis que le capteur de pression estime l'altitude.
\ \
La logique ici est de récupérer les trois capteurs à l'aide de la méthode `getDefaultSensor` du `SensorManager`, cette méthode renvoie uniquement le capteur principal (et non une liste) choisi par le système de la catégorie désigné. Nous avons ensuite plusieurs possibilités :

- Le magnétomètre ou l'accéléromètre (ou les deux) sont à `null`, l'application ne peut pas fonctionner car nous n'avons pas de boussole

- Le capteur de pression est à `null`, l'application  peut fonctionner, mais partiellement, il faudra désactiver la partie qui gère l'altitude
\
Afin d'externaliser et centraliser l'information des capteurs disponibles à toute l'application, une classe singleton `SensorChecker` gère la récupération des capteurs et l'initialisation de deux valeurs booléennes : `canApplicationRun` et `canBarometerRun`. Ces variables se verront attribuer une valeur lors du test de la présence des capteurs et utilisables dans l'application via des accesseurs. Chaque activité peut ainsi s'adapter à ce qui est disponible ou non.
\ \
En fonction de si la boussole et l'altimètre peuvent fonctionner, un message différent sera montré à l'utilisateur, comme l'illustre la figure ci-dessous :

#figure(
    image("images/app2-2.png", width: 85%),
    caption: "Capture d'écran de l'application 2, si certains capteurs ne fonctionnent pas"
)
\
Il est possible de désactiver volontairement des capteurs dans le fichier `config.ini` de l'émulateur Android Studio.
\ \
Cette logique de classe unique qui gère la récupération du capteur sera utilisée dans tout le reste des exercices, à chaque fois que l'on utilise un capteur, il sera géré par une classe externe appelée : TypeCapteurService (exemple AccelerometerService). Si le capteur requis n'est pas disponible alors un message indiquant quel type de capteur est requis.

= Application 3 : Accéléromètre

Le code de cet exercice correspond à la branche git : `exercice3`.
\ \
Après avoir récupéré l'accéléromètre, il faut maintenant recevoir des informations de sa part, ceci sera fait grâce à la méthode `registerListener` de la classe `SensorManager`. Cette méthode permet de "s'abonner" au capteur afin de recevoir ses informations, à la manière d'un pattern observer.
\ \
Afin d'optimiser au maximum l'application, l'abonnement se fera dans la redéfinition de la méthode `onResume`, et le désabonnement dans la redéfinition de la méthode `onPause`, avec la méthode `unregisterListener`. Cette étape est cruciale afin de ne pas consommer trop de batterie, l'application va arrêter de demander des informations au capteur lorsqu'elle n'est pas active (éteinte ou pas au premier plan).
\ \
Cette implémentation permet de tirer parti du cycle de vie des activités Android, `onResume` est toujours appelée lorsque l'activité passe au premier plan, elle est donc forcément appelée après le `onCreate` si l'on vient de lancer l'application, mais également si on la remet au premier plan, on "catch" toutes les possibilités. C'est la même logique pour `onPause`, il est déclenché lors de l'arrêt complet de l'application et la mise en second plan.
\ \
Une fois abonné au capteur, on récupère ses informations en implémentant l'interface `SensorEventListener` et en redéfinissant les méthodes `onAccuracyChanged` (corps vide) et `onSensorChanged`. Dans cette dernière, on vérifie que le type du capteur est bien celui que l'on recherche et l'on transfère le comportement à une méthode `update` (pareil dans les prochains exercices) afin de séparer la logique de récupération d'informations et de logique métier.
\ \
La méthode `update` utilise ses paramètres x, y et z et grâce à une formule mathématique demandée à Gemini, détermine la vitesse en mètre par seconde. Entre 0 et 4 m/s le fond est vert, entre 4 et 9 jaune et supérieur à 9 rouge.

#figure(
    image("images/app3.png", width: 85%),
    caption: "Capture d'écran de l'application 3"
)
\
L'accéléromètre peut être manipulé grâce à Android studio grâce au menu : Extended Controls > Virtual sensors > Device Pose > Move, d'ici; l'on peut modifier l'axe x, y et z.
\ \
A partir de maintenant et dans toutes les applications suivantes, les capteurs devant être utilisés seront précisés dans le `manifest` Android. Pour l'accéléromètre voici la ligne qui déclare au Google Play Store que l'application a besoin de ce capteur pour fonctionner : `<uses-feature android:name="android.hardware.sensor.accelerometer" android:required="true" />`.

= Application 4 : Direction des mouvements

Le code de cet exercice correspond à la branche git : `exercice4`.
\ \
La séparation des responsabilités ayant été bien faite dans l'exercice précédent, il suffit pour cette application de modifier légèrement l'UI et la méthode `update`. Nous allons également utiliser l'accélèromètre linéaire plutôt que l'accélèromètre simple, ce dernier étant plus adapté.
\ \
Gemini m'a donné une fois encore la formule à utiliser, avec un seuil, on teste si x > seuil ou x < -seuil (droite ou gauche), pareil pour y (haut ou bas), z n'est pas utile dans notre cas, car il mesure l'accélération perpendiculaire à l'écran.

#figure(
    image("images/app4.png", width: 85%),
    caption: "Capture d'écran de l'application 4"
)
\

= Application 5 : Allumer et éteindre le flash si secousse

Le code de cet exercice correspond à la branche git : `exercice5`.
\ \
Tout comme l'exercice précédent, les modifications sont légères par rapport à la base de code déjà présente. Nous rajoutons une classe `CameraService` gérant la caméra avec une méthode `toggleFlash`, qui inverse l'état actuel du flash. A l'aide encore une fois de Gemini, on définit un seuil et calcule la vitesse approximative du mouvement, si le seuil est dépassé, alors on appelle la méthode `toggleFlash`.
\ \
#figure(
    image("images/app5.png", width: 85%),
    caption: "Capture d'écran de l'application 5"
)<app5>
\
Comme il n'y a pas grand chose à dire de plus sur cet exercice, vous pouvez observer tout à droite de la @app5 le message affiché si le capteur n'est pas disponible.

= Application 6 : Proximité avec image

Le code de cet exercice correspond à la branche git : `exercice6`.
\ \
Nous gardons encore une fois la même logique en changeant le type du capteur. La méthode `update` prend un seul paramètre, la distance. En fonction de cette dernière, le texte de l'UI et l'image est mis à jour, si la distance est inférieure à la méthode `getMaxRange` du capteur, alors on affiche le texte "proche" et l'image proche, inférieure à 4cm moyen et supérieure à 4 cm loin.

#figure(
    image("images/app6.png", width: 85%),
    caption: "Capture d'écran de l'application 6"
)

= Application 7 : Géolocalisation de l'utilisateur

Le code de cet exercice correspond à la branche git : `exercice7-2`. Une autre version est disponible sur la branche `exercice7-1`, mais elle n'est pas mise à jour dynamiquement, elle récupère la dernière position de l'utilisateur et c'est tout.
\ \
Cette application utilise la même logique mais doit être enrichie. L'on utilise maintenant le `LocationManager` de Android, qui ne fonctionne pas vraiment comme un capteur mais comme un wrapper qui utilise le GPS, qui lui-même utilise différents capteurs, comme par exemple le récepteur d'ondes radio.

#figure(
    image("images/app7-1.png", width: 20%),
    caption: "Capture d'écran de l'application 7, demandant une autorisation à l'utilisateur"
)<app7-1>
\
Nous précisons dans le manifest que la localisation est requise, mais comme l'illustre la @app7-1, l'utilisation de ce service contraint une autorisation explicite de l'utilisateur, par souci de confidentialité. Dans le `onCreate` de notre application, nous utilisons la méthode `requestPermissions` si l'autorisation n'est pas déjà donnée, avec l'attribut `ACCESS_FINE_LOCATION`. Cette méthode provient de la classe `Activity` et permet de demander le consentement de l'utilisateur. 
\ \
Ensuite, l'on crée une instance de `LocationManager`, puis on implémente la même logique que "l'abonnement" aux capteurs. `LocationManager` utilise les méthodes `requestLocationUpdates` et `removeUpdates` pour s'abonner et se désabonner. Ces méthodes sont donc appelées dans le `onResume` et `onPause`. La méthode `requestLocationUpdates` prend 3 paramètres, le provider, le temps entre chaque prise et la distance minimum à parcourir pour être notifié. Dans notre cas nous demandons un minimum 10 mètres, toutes les 2 secondes et utilisons 2 providers, soit le GPS et internet.
\ \
La méthode `onLocationChanged` indique quand la position change avec en paramètre un objet de type `Location`. Il suffit d'appeler les méthodes `getLatitude` et `getLongitude` afin d'obtenir la position, on transmet ensuite ces informations aux méthodes `updateUI` et `updateMap`, qui s'occupent de la logique métier.
\ \
La méthode `updateUI` indique la longitude et la latitude à l'utilisateur. La méthode `updateMap` elle, démarre une instance de Google Maps avec la balise `WebView`, l'équivalent d'un `iframe` en HTML. En conséquence, le manifest demande l'autorisation d'accéder à internet pour faire une requête API.
\ \
Bien que très demandante en ressource, car elle lance une instance Google Maps à chaque changement de localisation et laisse le GPS en permanence allumé (et de manière moins optimisée que les manières les plus récentes de faire), l'application est dynamique et chaque changement de localisation déclenche une mise à jour de l'UI.

#figure(
    image("images/app7-2.png", width: 33%),
    caption: "Capture d'écran de l'application 7"
)

= Conclusion

Ce TP nous a enseigné les bases de l'utilisation des capteurs dans des applications Android. Cet aspect est très important car la plupart des applications d'aujourd'hui sollicitent des capteurs, afin de rendre l'expérience plus agréable.
\ \
Même si la technologie a progressé et les contraintes techniques sont moindres, utiliser les capteurs de la manière la plus optimisée reste indispensable, cela fait la différence entre un bon et un excellent ingénieur.