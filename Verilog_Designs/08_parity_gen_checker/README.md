# Even Parity Generator and Checker (4-bit)

## Circuit
**Generator (sender side):** adds a parity bit P to 4 data bits so that the 5 bits together always contain an even number of 1s.

```
P = D3 ⊕ D2 ⊕ D1 ⊕ D0
```

**Checker (receiver side):** XORs all 5 received bits. If the word arrived intact, the result is 0. If any single bit flipped on the way, the count of 1s becomes odd and the result is 1.

```
Error = D3 ⊕ D2 ⊕ D1 ⊕ D0 ⊕ P
```

## Hardware
- Generator: 3 two-input XOR gates (a chain or a tree)
- Checker: 4 two-input XOR gates

In Verilog, `^D` is the reduction XOR, which XORs every bit of D together.

## Truth Table (generator)

| D3 D2 D1 D0 | 1s in D | P | 1s in total |
|---|---|---|---|
| 0000 | 0 | 0 | 0 |
| 0001 | 1 | 1 | 2 |
| 0011 | 2 | 0 | 2 |
| 0111 | 3 | 1 | 4 |
| 1111 | 4 | 0 | 4 |
| 1010 | 2 | 0 | 2 |
| 1011 | 3 | 1 | 4 |

## Limitation
Parity detects any odd number of flipped bits but misses an even number. If two bits flip, the count stays even and the checker reports no error.

## Testbench
The generator output is wired into the checker through a "channel" that can flip any one of the 5 bits.

1. All 16 data values with no errors: the checker must report Error = 0.
2. Every data value with each of the 5 bits flipped in turn (80 cases): the checker must report Error = 1.

## Simulation

```bash
iverilog -o parity_gen_checker.vvp parity_generator.v parity_checker.v tb_parity_gen_checker.v
vvp parity_gen_checker.vvp
gtkwave parity_gen_checker.vcd
```

## Files

- `parity_generator.v` — RTL (dataflow, reduction XOR)
- `parity_checker.v` — RTL (dataflow, reduction XOR)
- `tb_parity_gen_checker.v` — Self-checking testbench with error injection
