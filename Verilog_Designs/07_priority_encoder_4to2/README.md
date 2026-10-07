# 4:2 Priority Encoder

## Circuit
Four inputs, D3 to D0, with D3 having the highest priority. The output Y is the index of the highest input that is 1. V (valid) is 1 whenever any input is 1, so you can tell "D0 is active" (Y = 00, V = 1) apart from "nothing is active" (Y = 00, V = 0).

A plain 4:2 encoder assumes only one input is ever high. A priority encoder handles several inputs being high at once by ignoring everything below the highest one.

## Truth Table

`X` = don't care

| D3 | D2 | D1 | D0 | Y1 | Y0 | V |
|----|----|----|----|----|----|---|
| 0  | 0  | 0  | 0  | 0  | 0  | 0 |
| 0  | 0  | 0  | 1  | 0  | 0  | 1 |
| 0  | 0  | 1  | X  | 0  | 1  | 1 |
| 0  | 1  | X  | X  | 1  | 0  | 1 |
| 1  | X  | X  | X  | 1  | 1  | 1 |

## Equations (from K-maps)

```
Y1 = D3 + D2
Y0 = D3 + D2'·D1
V  = D3 + D2 + D1 + D0
```

## Design notes
- The `if / else if` chain in `always @(*)` gives the priority directly: D3 is checked first.
- Combinational `always @(*)` uses blocking assignment (`=`).
- The final `else` assigns both Y and V. If any output were left unassigned on some path, synthesis would infer a latch to hold its old value.

## Simulation

```bash
iverilog -o priority_encoder_4to2.vvp priority_encoder_4to2.v tb_priority_encoder_4to2.v
vvp priority_encoder_4to2.vvp
gtkwave priority_encoder_4to2.vcd
```

## Files

- `priority_encoder_4to2.v` — RTL (behavioural model)
- `tb_priority_encoder_4to2.v` — Exhaustive self-checking testbench (all 16 cases)
