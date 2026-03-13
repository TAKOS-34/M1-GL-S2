Require Export ZArith.
Open Scope Z.

Inductive expr : Set :=
| Cte : Z -> expr
| Var : nat -> expr
| Plus : expr -> expr -> expr
| Moins : expr -> expr -> expr
| Mult : expr -> expr -> expr
| Div : expr -> expr -> expr.

Inductive value : Set :=
| Val : Z -> value
| Err: value.

Definition context := nat -> (option Z).

Definition env0 (n:nat) : (option Z):=
match n with 
  | 0%nat => Some 2
  | _ => None
end.

Inductive eval (env : context) : expr -> value -> Prop :=
| ECte : forall c : Z, eval env (Cte c) (Val c)
| EVar : forall (i : nat) (v : Z), (env i) = Some v -> eval env (Var i) (Val v) 
| EVarErr : forall (i : nat), 
    env i = None -> 
    eval env (Var i) Err

| EPlus : forall (e1 e2 : expr) (v1 v2 v : Z),
    eval env e1 (Val v1) -> 
    eval env e2 (Val v2) ->
    v = v1 + v2 -> 
    eval env (Plus e1 e2) (Val v)
| EPlusErrL : forall (e1 e2 : expr),
    eval env e1 Err -> eval env (Plus e1 e2) Err
| EPlusErrR : forall (e1 e2 : expr) (v1:Z),
    eval env e1 (Val v1) -> eval env e2 Err -> eval env (Plus e1 e2) Err

| EMoins : forall (e1 e2 : expr) (v1 v2 v : Z),
    eval env e1 (Val v1) ->
    eval env e2 (Val v2) ->
    v = v1 - v2 ->
    eval env (Moins e1 e2) (Val v)
| EMoinsErrL : forall (e1 e2 : expr),
    eval env e1 Err -> eval env (Moins e1 e2) Err
| EMoinsErrR : forall (e1 e2 : expr) (v1 : Z),
    eval env e1 (Val v1) -> eval env e2 Err -> eval env (Moins e1 e2) Err

| EMult : forall (e1 e2 : expr) (v1 v2 v : Z),
    eval env e1 (Val v1) ->
    eval env e2 (Val v2) ->
    v = v1 * v2 ->
    eval env (Mult e1 e2) (Val (v))
| EMultErrL : forall (e1 e2 : expr),
    eval env e1 Err -> eval env (Mult e1 e2) Err
| EMultErrR : forall (e1 e2 : expr) (v1 : Z),
    eval env e1 (Val v1) -> eval env e2 Err -> eval env (Mult e1 e2) Err

| EDiv : forall (e1 e2 : expr) (v1 v2 v : Z),
    eval env e1 (Val v1) ->
    eval env e2 (Val v2) ->
    v2 <> 0 ->
    v = Z.div v1 v2 ->
    eval env (Div e1 e2) (Val v)
| EDivErrL : forall (e1 e2 : expr),
    eval env e1 Err -> eval env (Div e1 e2) Err
| EDivErrR : forall (e1 e2 : expr) (v1 : Z),
    eval env e1 (Val v1) -> eval env e2 Err -> eval env (Div e1 e2) Err
| EDiv0 : forall (e1 e2 : expr) (v1 : Z),
    eval env e1 (Val v1) -> eval env e2 (Val 0) -> eval env (Div e1 e2) Err.

Definition env1 (n: nat) : (option Z) :=
    match n with
    | 0%nat => Some 2
    | 1%nat => Some 1
    | _ => None
end.

Lemma eval0 : eval env0 (Plus (Var 0) (Cte 1)) (Val 3).
Proof.
    eapply EPlus.
    eapply EVar.
    simpl.
    auto.
    eapply ECte.
    simpl.
    auto.
Qed.

Ltac apply_eval_val :=
    repeat eapply EPlus
        || eapply EMoins
        || eapply Mult
        || eapply EDiv
        || apply ECte
        || (apply EVar; simpl; auto)
        || auto.

Ltac apply_eval_err :=
    match goal with
    | |- eval _ (Var _) Err => apply EVarErr; simpl; auto

    | |- eval _ (Plus _ _) Err => 
        (apply EPlusErrL; apply_eval_err) 
        || (eapply EPlusErrR; [ apply_eval_val | apply_eval_err ])

    | |- eval _ (Moins _ _) Err => 
        (apply EMoinsErrL; apply_eval_err) 
        || (eapply EMoinsErrR; [ apply_eval_val | apply_eval_err ])

    | |- eval _ (Mult _ _) Err => 
        (apply EMultErrL; apply_eval_err) 
        || (eapply EMultErrR; [ apply_eval_val | apply_eval_err ])

    | |- eval _ (Div _ _) Err => 
        (apply EDiv0; [ apply_eval_val | apply_eval_val | reflexivity ])
        || (apply EDivErrL; apply_eval_err)
        || (eapply EDivErrR; [ apply_eval_val | apply_eval_err ])
    end.

Fixpoint f_eval (env : context) (e : expr) : value :=
match e with 
|Cte c => Val c
|Var i => match env i with
  |Some v => Val v
  |None => Err
  end
|Plus e1 e2 =>  
  match f_eval env e1 with 
    |Val v1 => match f_eval env e2 with
      |Val v2 => Val (v1 + v2)
      |_ => Err
      end
    |_ => Err
    end
|Moins e1 e2 =>  
  match f_eval env e1 with 
    |Val v1 => match f_eval env e2 with
      |Val v2 => Val (v1 - v2)
      |_ => Err
      end
    |_ => Err
    end
|Mult e1 e2 =>  
  match f_eval env e1 with 
    |Val v1 => match f_eval env e2 with
      |Val v2 => Val (v1 * v2)
      |_ => Err
      end
    |_ => Err
    end
|Div e1 e2 =>  
  match f_eval env e1 with 
    |Val v1 => match f_eval env e2 with
      |Val 0 => Err
      |Val v2 => Val (v1 / v2)
      |_ => Err
      end
    |_ => Err
    end
end.










