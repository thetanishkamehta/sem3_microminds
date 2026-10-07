// 4-Bit Magnitude Comparator — Dataflow Model
// Inputs:  A[3:0], B[3:0]
// Outputs: A_gt_B, A_eq_B, A_lt_B (exactly one is high at any time)
//
// Built from the gate equations rather than the > and < operators,
// so the hardware is visible: an XNOR per bit for equality, then
// "first bit from the MSB where A and B differ decides".

module comparator_4bit (
    input  wire [3:0] A,
    input  wire [3:0] B,
    output wire       A_gt_B,
    output wire       A_eq_B,
    output wire       A_lt_B
);

    // x[i] = 1 when bit i of A and B are equal (XNOR)
    wire [3:0] x;
    assign x = ~(A ^ B);

    // Equal only if every bit matches
    assign A_eq_B = &x;

    // A > B: the highest differing bit has A = 1 and B = 0
    assign A_gt_B = ( A[3] & ~B[3])
                  | (x[3] &  A[2] & ~B[2])
                  | (x[3] &  x[2] &  A[1] & ~B[1])
                  | (x[3] &  x[2] &  x[1] &  A[0] & ~B[0]);

    // A < B: neither greater nor equal
    assign A_lt_B = ~(A_gt_B | A_eq_B);

endmodule
