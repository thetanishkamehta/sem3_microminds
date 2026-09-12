# Digital Electronics — Theory Notes

Reference: Neso Academy – Digital Electronics / All About Electronics (YouTube)

---

## 1. Number Systems and Codes

### Base Conversions

| System | Base | Digits |
|--------|------|--------|
| Binary | 2 | 0, 1 |
| Octal | 8 | 0–7 |
| Decimal | 10 | 0–9 |
| Hexadecimal | 16 | 0–9, A–F |

**Decimal → Binary:** Repeated division by 2, read remainders bottom-up.
**Binary → Decimal:** Positional weights — e.g. `1011` = 1×8 + 0×4 + 1×2 + 1×1 = 11.
**Binary ↔ Hex:** Group bits in 4s from LSB — `1010 1111` = `AF`.
**Binary ↔ Octal:** Group bits in 3s from LSB — `101 011` = `53`.

### Signed Number Representation

- **Sign-magnitude:** MSB = sign, rest = magnitude. Two representations of zero.
- **1's complement:** Invert all bits. Still two zeros.
- **2's complement:** Invert all bits + 1. One zero, range is −2^(n−1) to +2^(n−1)−1. This is what hardware uses.

### Binary Codes

- **BCD (8421):** Each decimal digit → 4 bits. `59` = `0101 1001`.
- **Gray code:** Adjacent values differ by 1 bit only. Used in encoders and K-maps.
  - Binary → Gray: MSB stays, then XOR each adjacent pair.
  - Gray → Binary: MSB stays, then each bit = previous binary bit XOR current gray bit.
- **Excess-3:** BCD + 3. Self-complementing (9's complement = bitwise NOT).

---

## 2. Boolean Algebra and K-Maps

### Laws and Theorems

| Law | AND form | OR form |
|-----|----------|---------|
| Identity | A · 1 = A | A + 0 = A |
| Null | A · 0 = 0 | A + 1 = 1 |
| Idempotent | A · A = A | A + A = A |
| Complement | A · A' = 0 | A + A' = 1 |
| Commutative | A · B = B · A | A + B = B + A |
| Associative | (AB)C = A(BC) | (A+B)+C = A+(B+C) |
| Distributive | A(B+C) = AB+AC | A+BC = (A+B)(A+C) |
| Absorption | A(A+B) = A | A+AB = A |

### De Morgan's Theorems

```
(A · B)' = A' + B'
(A + B)' = A' · B'
```

Generalises to any number of variables. This is how NAND/NOR universality works.

### Canonical Forms

- **SOP (Sum of Products) / Minterms:** OR of AND terms. Each minterm is a row in the truth table where output = 1.
  - F(A,B,C) = Σm(1,3,5) means minterms 1, 3, 5 are ON.
- **POS (Product of Sums) / Maxterms:** AND of OR terms. Each maxterm is a row where output = 0.
  - F(A,B,C) = ΠM(0,2,4,6,7) — the complement set.

### Karnaugh Maps (K-Maps)

Used to simplify Boolean expressions visually.

**2-variable K-map:**
```
        B=0   B=1
A=0  |  m0  |  m1  |
A=1  |  m2  |  m3  |
```

**3-variable K-map:**
```
          BC
       00   01   11   10
A=0 |  m0 | m1 | m3 | m2 |
A=1 |  m4 | m5 | m7 | m6 |
```

**4-variable K-map:**
```
            CD
         00   01   11   10
AB=00 |  m0 | m1 | m3 | m2  |
AB=01 |  m4 | m5 | m7 | m6  |
AB=11 | m12 | m13| m15| m14 |
AB=10 |  m8 | m9 | m11| m10 |
```

**Grouping rules:**
1. Groups must be powers of 2 (1, 2, 4, 8, 16).
2. Groups must be rectangular.
3. The map wraps — top↔bottom, left↔right.
4. Larger groups → simpler terms.
5. Every 1 must be covered. Overlapping is allowed.
6. Don't-cares (X) can be included in groups if they help simplify.

**Reading a group:** Variables that stay constant across the group appear in the product term. Variables that change are eliminated.

---

## 3. Combinational Circuits

### Half Adder

Two inputs (A, B), two outputs (Sum, Carry).

```
Sum   = A ⊕ B
Carry = A · B
```

### Full Adder

Three inputs (A, B, Cin), two outputs (Sum, Cout).

```
Sum  = A ⊕ B ⊕ Cin
Cout = (A · B) + (Cin · (A ⊕ B))
```

### Ripple Carry Adder

Chain n full adders: Cout of bit i feeds Cin of bit i+1. Simple but slow — worst-case delay is proportional to n (carry has to ripple through every stage).

### Subtractor

Use 2's complement: A − B = A + B' + 1. A full adder with B inverted and Cin = 1 gives subtraction. An adder-subtractor uses a control signal and XOR gates to toggle between add and subtract.

### Multiplexer (MUX)

2^n inputs, n select lines, 1 output. Selects one input and routes it to output.

**4:1 MUX:**
```
Y = S1'·S0'·I0 + S1'·S0·I1 + S1·S0'·I2 + S1·S0·I3
```

MUX can implement any Boolean function — connect constants/variables to the data inputs.

### Demultiplexer (DEMUX)

1 input, n select lines, 2^n outputs. Routes the input to one of the outputs. A decoder with an enable input acts as a DEMUX.

### Decoder

n inputs, 2^n outputs. Exactly one output is HIGH for each input combination.

**2:4 Decoder:**
```
Y0 = A'·B'
Y1 = A'·B
Y2 = A·B'
Y3 = A·B
```

With an enable pin, it becomes a DEMUX.

### Encoder

2^n inputs (only one active at a time), n outputs. Reverse of a decoder.

**Priority Encoder:** When multiple inputs are active, the highest-priority input wins. Outputs the binary code of the highest active input plus a valid bit.

### Comparator

Compares two n-bit numbers. Outputs: A > B, A = B, A < B.

For 1-bit:
```
A > B : A · B'
A = B : A ⊕ B (inverted, i.e., XNOR)
A < B : A' · B
```

Multi-bit comparators cascade — check from MSB down.

### Parity Generator / Checker

- **Even parity:** XOR all bits. Parity bit makes total number of 1s even.
- **Odd parity:** XNOR all bits (or XOR + invert).
- **Checker:** XOR all received bits including parity. Output 0 = no error (for even parity).

---

## Key Takeaways for Verilog

- Every combinational circuit above can be described with `assign` statements (dataflow) or `always @(*)` blocks (behavioural).
- Always think: what hardware am I describing? Draw it first.
- Combinational logic in an `always` block uses **blocking assignment** (`=`).
