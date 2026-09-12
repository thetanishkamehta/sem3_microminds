// 4:1 Multiplexer — Behavioural Model
// 4 data inputs, 2 select lines, 1 output

module mux_4to1 (
    input  wire [3:0] D,    // data inputs D[0]..D[3]
    input  wire [1:0] Sel,  // select lines
    output reg        Y     // output
);

    always @(*) begin
        case (Sel)
            2'b00 : Y = D[0];
            2'b01 : Y = D[1];
            2'b10 : Y = D[2];
            2'b11 : Y = D[3];
            default: Y = 1'b0;
        endcase
    end

endmodule
