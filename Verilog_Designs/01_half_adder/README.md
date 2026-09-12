# Half Adder

## Circuit
Two single-bit inputs (A, B) produce a Sum and Carry output.

```
Sum   = A ⊕ B
Carry = A · B
```

## Truth Table

| A | B | Sum | Carry |
|---|---|-----|-------|
| 0 | 0 |  0  |   0   |
| 0 | 1 |  1  |   0   |
| 1 | 0 |  1  |   0   |
| 1 | 1 |  0  |   1   |

## Simulation

```bash
# Icarus Verilog
iverilog -o half_adder_tb half_adder.v tb_half_adder.v
vvp half_adder_tb
gtkwave half_adder.vcd
```

## Files

- `half_adder.v` — RTL (dataflow model)
- `tb_half_adder.v` — Exhaustive testbench with self-checking
