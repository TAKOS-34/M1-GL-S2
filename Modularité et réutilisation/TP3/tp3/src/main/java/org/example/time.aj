package org.example;

public aspect time {
    pointcut timeMethodsSet():
            call(* Ligne.setP1(*)) ||
            call(* Ligne.setP2(*));

    pointcut timeMethodsGet():
            call(* Ligne.getP1()) ||
            call(* Ligne.getP2());

    void around(): timeMethodsSet() {
        double debut = System.nanoTime();

        proceed();

        double fin = System.nanoTime();
        double time = fin - debut;
        System.out.println("Temps d'execution d'un setter : " + time);
    }

    void around(): timeMethodsSet() {
        double debut = System.nanoTime();

        proceed();

        double fin = System.nanoTime();
        double time = fin - debut;
        System.out.println("Temps d'execution d'un getter : " + time);
    }
}
