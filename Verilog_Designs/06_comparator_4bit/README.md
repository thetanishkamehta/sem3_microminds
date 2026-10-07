# 4-Bit Magnitude Comparator

## Circuit
Compares two 4-bit numbers A and B. Exactly one of three outputs is high: A > B, A = B, or A < B.

First, an XNOR on each bit pair tells you whether that bit matches:

```
x3 = A3 ⊙ B3    x2 = A2 ⊙ B2    x1 = A1 ⊙ B1    x0 = A0 ⊙ B0
```

Then:

```
A = B  →  x3 · x2 · x1 · x0

A > B  →  A3·B3'
        + x3·A2·B2'
        + x3·x2·A1·B1'
        + x3·x2·x1·A0·B0'

A < B  →  (A > B + A = B)'
```

Reading the A > B equation: start at the MSB. If A3 = 1 and B3 = 0, A is bigger. If bit 3 matches (x3), move down to bit 2, and so on. The first bit where they differ decides.

## Hardware
- 4 XNOR gates (one per bit)
- 1 four-input AND for equality
- 4 AND terms (2, 3, 4 and 5 inputs) feeding a 4-input OR for A > B
- 1 NOR for A < B

## Example

| A (dec) | A (bin) | B (dec) | B (bin) | Deciding bit | Result |
|---|---|---|---|---|---|
| 9 | 1001 | 5 | 0101 | bit 3 | A > B |
| 7 | 0111 | 7 | 0111 | — | A = B |
| 3 | 0011 | 12 | 1100 | bit 3 | A < B |
| 8 | 1000 | 7 | 0111 | bit 3 | A > B |

## Simulation

```bash
iverilog -o comparator_4bit.vvp comparator_4bit.v tb_comparator_4bit.v
vvp comparator_4bit.vvp
gtkwave comparator_4bit.vcd
```

## Files

- `comparator_4bit.v` — RTL (dataflow model, gate equations)
- `tb_comparator_4bit.v` — Exhaustive self-checking testbench (all 256 cases)
