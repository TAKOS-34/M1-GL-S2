= Exercice 1

== 1

C'est le manifeste. On affiche le message "Hello Android"

== 2

```java
EditText et = new EditText();
TextView tv = new TextView();

LinearLayout ll = new LinearLayout();
ll.setOrientation(LinearLayout.VERTICAL);

ll.add(tv);
ll.add(tv);
```

== 3

On a la vue dans le layout

== 4

Ajout de \<EditText\> dans le layout

= Exercice 2

== 1

Un fichier de ressource, pour externaliser la configuration

== 2

```xml <string name="hello_android">Hello Android</string>```

= Exercice 3

- layout1 : Trois boutons affichés horizontalement
- layout2 : Boutons et input pour username et bouton de submit
- layout3 : Tableau de boutons

= Exercice 4

== 1

Un bouton qui affiche un message quand on clique dessus dans une petite fenêtre

== 2 & 3

jsp

== 4

Utilisation de ressource pour changer la valeur facilement

== 5

Changer le new OnClickListener() par new OnLongClickListener()

= Exercice 5

Affiche un message "try linux" si la checkbox windows est sélectionné

Quand on clique sur display, affiche les résultats des cases cochées

= Exercice 6

#image("images/ex6.jpg", width: 100%)