// 4:2 Priority Encoder — Behavioural Model
// Inputs:  D[3:0]  (D[3] has the highest priority)
// Outputs: Y[1:0]  (index of the highest active input)
//          V       (valid — high when at least one input is active)
//
// The if / else-if chain is what creates the priority: D[3] is
// checked first, so it wins over everything below it.

module priority_encoder_4to2 (
    input  wire [3:0] D,
    output reg  [1:0] Y,
    output reg        V
);

    always @(*) begin
        if (D[3]) begin
            Y = 2'b11;
            V = 1'b1;
        end else if (D[2]) begin
            Y = 2'b10;
            V = 1'b1;
        end else if (D[1]) begin
            Y = 2'b01;
            V = 1'b1;
        end else if (D[0]) begin
            Y = 2'b00;
            V = 1'b1;
        end else begin
            // No input active. Every output is still assigned here,
            // otherwise synthesis would infer a latch.
            Y = 2'b00;
            V = 1'b0;
        end
    end

endmodule
