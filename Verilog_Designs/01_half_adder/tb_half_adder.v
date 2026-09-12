// Testbench for Half Adder
// Exhaustive — tests all 4 input combinations

`timescale 1ns / 1ps

module tb_half_adder;

    reg  A, B;
    wire Sum, Carry;

    half_adder uut (
        .A     (A),
        .B     (B),
        .Sum   (Sum),
        .Carry (Carry)
    );

    integer i;
    reg expected_sum, expected_carry;
    integer errors = 0;

    initial begin
        $dumpfile("half_adder.vcd");
        $dumpvars(0, tb_half_adder);

        $display("------------------------------------");
        $display(" Half Adder Testbench");
        $display("------------------------------------");
        $display(" A  B | Sum Carry | Expected S C");

        for (i = 0; i < 4; i = i + 1) begin
            {A, B} = i[1:0];
            #10;

            expected_sum   = A ^ B;
            expected_carry = A & B;

            $display(" %b  %b |  %b    %b   |    %b      %b   %s",
                     A, B, Sum, Carry, expected_sum, expected_carry,
                     (Sum === expected_sum && Carry === expected_carry) ? "PASS" : "FAIL");

            if (Sum !== expected_sum || Carry !== expected_carry)
                errors = errors + 1;
        end

        $display("------------------------------------");
        if (errors == 0)
            $display(" ALL TESTS PASSED");
        else
            $display(" %0d TESTS FAILED", errors);
        $display("------------------------------------");

        $finish;
    end

endmodule
