(* Exercice 1 *)

Parameters A B C : Prop.

Goal A -> B -> A.
  intros.
  assumption.
Qed.

Lemma q2 : (A -> B -> C) -> (A -> B) -> A -> C.
Proof.
    intros.
    apply (H H1 (H0 H1)).
Qed.

Lemma q3 : A /\ B -> B.
Proof.
    intro.
    elim H; intros; clear H.
    assumption.
Qed.

Lemma q4 : B -> A \/ B.
Proof.
    intro.
    right.
    assumption.
Qed.

Lemma q5 : (A \/ B) -> (A -> C) -> (B -> C) -> C.
Proof.
    intros.
    elim H.
    assumption.
    assumption.
Qed.

Lemma q6 : A -> False -> ~A.
Proof.
    intros.
    elim H0.
Qed.

Lemma q7 : False -> A.
Proof.
    intro.
    elim H.
Qed.

Lemma q8 : (A <-> B) -> A -> B.
Proof.
    intro.
    elim H.
    intros.
    apply H0.
    assumption.
Qed.

(* Exercice 2 *)

Parameter E : Set.
Parameter P Q : E -> Prop.

Lemma f1 : forall x : E, (P x)-> exists y : E, (P y) \/ (Q y).
Proof.
    intros.
    exists x.
    left.
    assumption.
Qed.

Lemma f2 : (exists x : E, (P x) \/  (Q x)) -> (exists x : E, (P x)) \/ (exists x : E, (Q x)).
Proof.
    intro.
    destruct H.
    destruct H.
    left.
    exists x.
    assumption.
    right.
    exists x.
    assumption.

