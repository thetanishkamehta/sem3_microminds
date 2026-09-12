# Full Adder

## Circuit
Three single-bit inputs (A, B, Cin) produce Sum and Cout. This is the building block of multi-bit adders.

```
Sum  = A ⊕ B ⊕ Cin
Cout = A·B + Cin·(A ⊕ B)
```

## Truth Table

| A | B | Cin | Sum | Cout |
|---|---|-----|-----|------|
| 0 | 0 |  0  |  0  |  0   |
| 0 | 0 |  1  |  1  |  0   |
| 0 | 1 |  0  |  1  |  0   |
| 0 | 1 |  1  |  0  |  1   |
| 1 | 0 |  0  |  1  |  0   |
| 1 | 0 |  1  |  0  |  1   |
| 1 | 1 |  0  |  0  |  1   |
| 1 | 1 |  1  |  1  |  1   |

## Simulation

```bash
iverilog -o full_adder_tb full_adder.v tb_full_adder.v
vvp full_adder_tb
gtkwave full_adder.vcd
```

## Files

- `full_adder.v` — RTL (dataflow model)
- `tb_full_adder.v` — Exhaustive self-checking testbench
