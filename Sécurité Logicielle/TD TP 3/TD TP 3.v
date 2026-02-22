(* Exercice 1 *)

Fixpoint mult (n m : nat) {struct n} : nat :=
  match n with
    | 0 => 0
    | S p => plus (mult p m) m
  end.

Lemma p0 : forall n : nat, mult 2 n = plus n n.
Proof.
  intro.
  simpl.
  reflexivity.
Qed.

Axiom aux0 : forall n, (plus n 2) = S (S n).

Axiom aux1 : forall n m,
  (plus n (S m)) = S (plus n m).

Lemma p1 : forall n : nat, mult n 2 = plus n n.
Proof.
  intros.
  induction n.
  simpl.
  reflexivity.
  simpl.
  rewrite IHn.
  rewrite aux0.
  rewrite aux1.
  reflexivity.  
Qed.

(* Exercice 2 *)

Require Export List.
Open Scope list_scope.
Import ListNotations.

Parameter E : Type.

Fixpoint rev (l : List E) : list E :=
  match l with
    | [] => []
    | e::q => (rev q) ++ [e]
  end.

Lemma p3 : forall l : list E, forall e : E, rev (l ++ [e]) = e::rev(l).
Proof.
  induction l.
  intro.
  simpl.
  reflexivity.
  simpl.
  intro.
  rewrite IHl.
  reflexivity.
Qed.

Lemma p4 : forall l : list E, rev(rev (l)) = l.
Proof.
  induction l.
  simpl.
  reflexivity.
  simpl.
  rewrite p3.
  rewrite IHl.
  reflexivity.
Qed.

(* Exercice 4 *)

Inductive is_perm : list nat -> list nat -> Prop := 
  | is_perm_cons : forall (a : nat) (l0 l1 : list nat), is_perm l0 l1 -> is_perm (a::l0) (a::l1)
  | is_perm_append : forall (a : nat) (l : list nat), is_perm(a ::l) (l ++ a :: nil)
  | is_perm_refl : forall l : list nat,is_perm l l
  | is_perm_trans : forall l0 l1 l2 : list nat, is_perm l0 l1 -> is_perm l1 l2 -> is_perm l0 l2
  | is_perm_sym : forall l1 l2 : list nat, is_perm l1 l2 -> is_perm l2 l1.

Lemma p5 : is_perm [1;2;3] [3;2;1].
Proof.
  apply is_perm_trans with [2;3;1].
  apply is_perm_append.
  apply is_perm_trans with [3;1;2].
  apply is_perm_append.
  apply is_perm_cons.
  apply is_perm_trans with [2;1].
  apply is_perm_append.
  apply is_perm_refl.
Qed.

Inductive is_sorted : list nat -> Prop :=
  | is_sorted_nil : is_sorted nil
  | is_sorted_sing : forall n : nat, is_sorted [n]
  | is_sorted_cons : forall (n m : nat) (l : list nat), n <= m -> is_sorted(m::l) -> is_sorted(n::m::l).


