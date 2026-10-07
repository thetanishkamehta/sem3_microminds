// Testbench for 4:2 Priority Encoder
// Exhaustive — tests all 16 input combinations
// Expected output is found by scanning D from bit 0 upward and
// keeping the last 1 seen, which gives the highest active index.

`timescale 1ns / 1ps

module tb_priority_encoder_4to2;

    reg  [3:0] D;
    wire [1:0] Y;
    wire       V;

    priority_encoder_4to2 uut (
        .D (D),
        .Y (Y),
        .V (V)
    );

    integer i, k;
    integer errors = 0;
    reg [1:0] exp_y;
    reg       exp_v;

    initial begin
        $dumpfile("priority_encoder_4to2.vcd");
        $dumpvars(0, tb_priority_encoder_4to2);

        $display("--------------------------------------");
        $display(" 4:2 Priority Encoder Testbench");
        $display("--------------------------------------");
        $display("  D3 D2 D1 D0 | Y1 Y0 V | Exp Y V");

        for (i = 0; i < 16; i = i + 1) begin
            D = i[3:0];
            #10;

            // Reference model
            exp_y = 2'b00;
            exp_v = 1'b0;
            for (k = 0; k < 4; k = k + 1) begin
                if (D[k]) begin
                    exp_y = k[1:0];
                    exp_v = 1'b1;
                end
            end

            $display("   %b  %b  %b  %b |  %b  %b %b |  %b  %b  %s",
                     D[3], D[2], D[1], D[0], Y[1], Y[0], V, exp_y, exp_v,
                     (Y === exp_y && V === exp_v) ? "PASS" : "FAIL");

            if (Y !== exp_y || V !== exp_v)
                errors = errors + 1;
        end

        $display("--------------------------------------");
        if (errors == 0)
            $display(" ALL TESTS PASSED");
        else
            $display(" %0d TESTS FAILED", errors);
        $display("--------------------------------------");

        $finish;
    end

endmodule
