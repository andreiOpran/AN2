
- ∧
- ∨

---

De demonstrat: { X = n  ∧ Y = m} (X = X + Y; Y = X - Y); X = X - Y { X = M ∧ Y = n}

{Y = m ∧ X + Y - Y = n} X = X + Y {Y = m ∧ X - Y = n} (Asgn)

(2) {X - (X - Y) = m ∧ X - Y = n} Y = X - Y { X - Y = m ∧ Y = n} (Asgn)

(3) { X = n  ∧ Y = m} (X = X + Y; Y = X - Y) => 
=> { X = n  ∧ Y = m} (X = X + Y; Y = X - Y) {X - Y = m ∧Y = n} (Seq: ??)

(4) X = X - Y { X = M ∧ Y = n} => 
=> {X - Y = m ∧ Y = n} X = X - Y { X = M ∧ Y = n} (Asgn)
 
(5) { X = n  ∧ Y = m} (X = X + Y; Y = X - Y); X = X - Y { X = M ∧ Y = n} (Seq: 3, 4)

Regula:
{P} S1 {Q}    {Q} S2 {R}   /   {P} S1; S2 {R}
{Q(e)} X := e {Q(X)}

---

{ i = 1 ∧ 1 <= N ∧ S = 0} while i <= 2\*N do (S = S + 1, i = i + 2) {S = N\*N}

{S = \[(i + 2) - 1) / 2\]^2 ∧ i + 2 <= 2N + 1} i := i + 2 {P} 

{P ∧ b} S := S + i; i := i + 2 {P}

Regula pentru while:
{P ∧ b} s {P} / {P} while b do s {P ∧ !b}