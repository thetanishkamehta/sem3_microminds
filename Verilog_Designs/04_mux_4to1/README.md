# 4:1 Multiplexer

## Circuit
4 data inputs, 2 select lines, 1 output. Select lines choose which data input is routed to the output.

```
Sel = 00 → Y = D[0]
Sel = 01 → Y = D[1]
Sel = 10 → Y = D[2]
Sel = 11 → Y = D[3]
```

## Simulation

```bash
iverilog -o mux_tb mux_4to1.v tb_mux_4to1.v
vvp mux_tb
gtkwave mux_4to1.vcd
```
