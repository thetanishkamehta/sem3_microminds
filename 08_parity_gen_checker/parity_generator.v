// 4-Bit Even Parity Generator — Dataflow Model
// Input:  D[3:0]
// Output: P — chosen so that D plus P together hold an even number of 1s
//
// ^D is the reduction XOR: D[3] ^ D[2] ^ D[1] ^ D[0].
// It is 1 when D has an odd number of 1s, which is exactly when
// an extra 1 is needed to make the total even.

module parity_generator (
    input  wire [3:0] D,
    output wire       P
);

    assign P = ^D;

endmodule
