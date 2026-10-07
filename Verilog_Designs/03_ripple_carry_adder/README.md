# 4-Bit Ripple Carry Adder

## Circuit
Chains four full adders. Carry output of each stage feeds the carry input of the next. Produces a 4-bit sum and a carry-out.

Worst-case delay scales linearly with bit width (carry must ripple through all stages).

## Simulation

```bash
# Needs full_adder.v from ../02_full_adder/
iverilog -o rca_tb ../02_full_adder/full_adder.v ripple_carry_adder_4bit.v tb_ripple_carry_adder_4bit.v
vvp rca_tb
gtkwave ripple_carry_adder.vcd
```

## Files

- `ripple_carry_adder_4bit.v` — Structural model instantiating 4 full adders
- `tb_ripple_carry_adder_4bit.v` — Self-checking testbench with edge cases
