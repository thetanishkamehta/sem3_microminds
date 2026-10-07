# 2:4 Decoder with Enable

## Circuit
2 input bits select which of 4 output lines goes HIGH. Enable pin gates all outputs.

```
En=0 → Y = 0000
En=1, A=00 → Y = 0001
En=1, A=01 → Y = 0010
En=1, A=10 → Y = 0100
En=1, A=11 → Y = 1000
```

## Simulation

```bash
iverilog -o dec_tb decoder_2to4.v tb_decoder_2to4.v
vvp dec_tb
gtkwave decoder_2to4.vcd
```
