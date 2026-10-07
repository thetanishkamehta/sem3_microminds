// 4-Bit Even Parity Checker — Dataflow Model
// Inputs: D[3:0] (received data), P (received parity bit)
// Output: Error — 1 when the 5 received bits hold an odd number of 1s
//
// With even parity, a correct word always XORs to 0. Any single
// flipped bit (in the data or in P itself) makes the XOR 1.

module parity_checker (
    input  wire [3:0] D,
    input  wire       P,
    output wire       Error
);

    assign Error = ^{D, P};

endmodule
