// Testbench for Full Adder
// Exhaustive — tests all 8 input combinations

`timescale 1ns / 1ps

module tb_full_adder;

    reg  A, B, Cin;
    wire Sum, Cout;

    full_adder uut (
        .A    (A),
        .B    (B),
        .Cin  (Cin),
        .Sum  (Sum),
        .Cout (Cout)
    );

    integer i;
    reg expected_sum, expected_cout;
    integer errors = 0;

    initial begin
        $dumpfile("full_adder.vcd");
        $dumpvars(0, tb_full_adder);

        $display("------------------------------------------");
        $display(" Full Adder Testbench");
        $display("------------------------------------------");
        $display(" A  B  Cin | Sum Cout | Expected S C");

        for (i = 0; i < 8; i = i + 1) begin
            {A, B, Cin} = i[2:0];
            #10;

            expected_sum  = A ^ B ^ Cin;
            expected_cout = (A & B) | (Cin & (A ^ B));

            $display(" %b  %b   %b  |  %b    %b   |    %b      %b   %s",
                     A, B, Cin, Sum, Cout, expected_sum, expected_cout,
                     (Sum === expected_sum && Cout === expected_cout) ? "PASS" : "FAIL");

            if (Sum !== expected_sum || Cout !== expected_cout)
                errors = errors + 1;
        end

        $display("------------------------------------------");
        if (errors == 0)
            $display(" ALL TESTS PASSED");
        else
            $display(" %0d TESTS FAILED", errors);
        $display("------------------------------------------");

        $finish;
    end

endmodule
