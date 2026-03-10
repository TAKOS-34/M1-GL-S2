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

== Technologies utilisées

Ce TP est hébergé sur *Git*, le sujet nous demandant explicitement de séparer distinctement le code de chaque exercice, le code fourni dans le `.zip` est relié à un projet Git contenant une branche par exercice. Il suffit donc de faire par exemple : `git checkout exercice2` afin d'avoir le code correspondant à l'exercice 2.
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



#pagebreak()
= Conclusion

Ce TP nous a enseigné les bases du développement des applications android. Soit l'affichage d'informations sous forme de liste (très commun), les formulaires, le passage de valeurs entre activités, les différents écrans via les activités et les vues, l'appel API des applications du téléphone (le téléphone dans notre cas), la gestion de la persistance et même l'appel d'une API extérieure.
\ \
La charge de travail demandée étant conséquente, je regrette de ne pas avoir pu plus étudier plus en profondeur le design des applications, ayant tout délégué à l'IA par manque de temps. Je pense cependant avoir appris beaucoup.
