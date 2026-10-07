// Testbench for 4-Bit Magnitude Comparator
// Exhaustive — tests all 256 combinations of A and B
// Expected values come from Verilog's >, == and < operators,
// which are independent of the gate equations in the RTL.

`timescale 1ns / 1ps

module tb_comparator_4bit;

    reg  [3:0] A, B;
    wire       A_gt_B, A_eq_B, A_lt_B;

    comparator_4bit uut (
        .A      (A),
        .B      (B),
        .A_gt_B (A_gt_B),
        .A_eq_B (A_eq_B),
        .A_lt_B (A_lt_B)
    );

    integer i, j;
    integer errors = 0;
    reg exp_gt, exp_eq, exp_lt;

    initial begin
        $dumpfile("comparator_4bit.vcd");
        $dumpvars(0, tb_comparator_4bit);

        $display("------------------------------------------");
        $display(" 4-Bit Comparator Testbench (256 cases)");
        $display("------------------------------------------");

        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                A = i[3:0];
                B = j[3:0];
                #10;

                exp_gt = (A >  B);
                exp_eq = (A == B);
                exp_lt = (A <  B);

                if (A_gt_B !== exp_gt || A_eq_B !== exp_eq || A_lt_B !== exp_lt) begin
                    $display("FAIL: A=%0d B=%0d  got gt=%b eq=%b lt=%b  exp gt=%b eq=%b lt=%b",
                             A, B, A_gt_B, A_eq_B, A_lt_B, exp_gt, exp_eq, exp_lt);
                    errors = errors + 1;
                end

                // Exactly one output must be high
                if ((A_gt_B + A_eq_B + A_lt_B) !== 1) begin
                    $display("FAIL: A=%0d B=%0d  more than one output high", A, B);
                    errors = errors + 1;
                end
            end
        end

        // Print a few representative cases for the log
        $display(" Sample results:");
        A = 4'd9;  B = 4'd5;  #10; $display("  A=%2d B=%2d  gt=%b eq=%b lt=%b", A, B, A_gt_B, A_eq_B, A_lt_B);
        A = 4'd7;  B = 4'd7;  #10; $display("  A=%2d B=%2d  gt=%b eq=%b lt=%b", A, B, A_gt_B, A_eq_B, A_lt_B);
        A = 4'd3;  B = 4'd12; #10; $display("  A=%2d B=%2d  gt=%b eq=%b lt=%b", A, B, A_gt_B, A_eq_B, A_lt_B);
        A = 4'd8;  B = 4'd7;  #10; $display("  A=%2d B=%2d  gt=%b eq=%b lt=%b", A, B, A_gt_B, A_eq_B, A_lt_B);

        $display("------------------------------------------");
        if (errors == 0)
            $display(" ALL TESTS PASSED");
        else
            $display(" %0d TESTS FAILED", errors);
        $display("------------------------------------------");

        $finish;
    end

endmodule
