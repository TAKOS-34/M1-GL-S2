Require Export ZArith.
Open Scope Z.

(* Question 1 *)

Inductive expr : Set :=
| Cte : Z -> expr
| Plus : expr -> expr -> expr
| Moins : expr -> expr -> expr
| Mult : expr -> expr -> expr
| Div : expr -> expr -> expr.

(* Question 2 *)

Definition p0 := Plus (Cte 1) (Cte 1).
Definition p1 := Mult (Plus (Cte 4) (Cte 2)) (Moins (Cte 9) (Cte 2)).

(* Question 3 *)

Inductive eval : expr -> Z -> Prop :=
| ECte : forall c : Z, eval (Cte c) c
| EPlus : forall (e1 e2 : expr) (v1 v2 v : Z), eval e1 v1 -> eval e2 v2 -> v = v1 + v2 -> eval (Plus e1 e2) v
| EMoins : forall (e1 e2 : expr) (v1 v2 v : Z), eval e1 v1 -> eval e2 v2 -> v = v1 - v2 -> eval (Moins e1 e2) v
| EMult : forall (e1 e2 : expr) (v1 v2 v : Z), eval e1 v1 -> eval e2 v2 -> v = v1 * v2 -> eval (Mult e1 e2) v
| EDiv : forall (e1 e2 : expr) (v1 v2 v : Z), eval e1 v1 -> eval e2 v2 -> v = v1 / v2 -> eval (Div e1 e2) v.

(* Question 4 *)

Lemma eval0 : eval p0 2.
Proof.
  unfold p0.
  eapply EPlus.
  apply ECte.
  apply ECte.
  auto.
Qed.

Lemma eval1 : eval p1 42.
Proof.
  unfold p1.
  eapply EMult.
  eapply EPlus.
  apply ECte.
  apply ECte.
  auto.
  eapply EMoins.
  apply ECte.
  apply ECte.
  auto.
  auto.
Qed.

(* Question 5 *)

Ltac prove :=
  repeat
    (eapply EPlus || eapply EMoins || eapply EMult || eapply EDiv || apply ECte || auto).

Lemma eval0b : eval p0 2.

Proof.
  unfold p0.
  prove.
Qed.

(* Question 6 *)

Fixpoint f_eval (e : expr) : Z :=
match e with 
|Cte c => c
|Plus e1 e2 => 
  let v1 := f_eval e1 in 
  let v2 := f_eval e2 in
  v1 + v2
|Moins e1 e2 => 
  let v1 := f_eval e1 in 
  let v2 := f_eval e2 in
  v1 - v2
|Mult e1 e2 => 
  let v1 := f_eval e1 in 
  let v2 := f_eval e2 in
  v1 * v2
|Div e1 e2 => 
  let v1 := f_eval e1 in 
  let v2 := f_eval e2 in
  v1/v2
end.

(* Question 7 *)

Eval compute in (f_eval p0).
Eval compute in (f_eval p1).

(* Question 8 *)

Ltac prove_sound H IHe1 IHe2 e1 e2 :=
  simpl in H;
  rewrite <- H;
  (eapply EPlus || eapply EMoins || eapply EMult || eapply EDiv);
    [ apply (IHe1 (f_eval e1)); reflexivity
    | apply (IHe2 (f_eval e2)); reflexivity
    | reflexivity ].

Lemma  f_eval_sound :
  forall (e : expr) (v : Z), (f_eval e) = v -> eval e v.
Proof.
  induction e.
  intros.
  (* ((simpl in H;
    rewrite H;
    apply ECte)
    || prove_sound H IHe1 IHe2 e1 e2).
Qed. *)

  (* ECte *)
  simpl in H.
  rewrite H.
  apply ECte.

  (* EPlus *)
  intros.
  simpl in H.
  rewrite <- H.
  eapply EPlus.
  apply (IHe1 (f_eval e1)); reflexivity.
  apply (IHe2 (f_eval e2)); reflexivity.
  reflexivity.

  (* EMoins *)
  intros.
  simpl in H.
  rewrite <- H.
  eapply EMoins.
  apply (IHe1 (f_eval e1)); reflexivity.
  apply (IHe2 (f_eval e2)); reflexivity.
  reflexivity.

  (* EMult *)
  intros.
  simpl in H.
  rewrite <- H.
  eapply EMult.
  apply (IHe1 (f_eval e1)); reflexivity.
  apply (IHe2 (f_eval e2)); reflexivity.
  reflexivity.

  (* EDiv *)
  intros.
  simpl in H.
  rewrite <- H.
  eapply EDiv.
  apply (IHe1 (f_eval e1)); reflexivity.
  apply (IHe2 (f_eval e2)); reflexivity.
  reflexivity.
Qed.


Lemma f_eval_compl:
  forall (e : expr) (v : Z), eval e v -> (f_eval e) = v.
Proof.
  intros.  elim H; intros;
  ((simpl; reflexivity)
  || simpl; rewrite H1; rewrite H3; rewrite H4; reflexivity).
Qed.























