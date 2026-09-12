// Testbench for 4-Bit Ripple Carry Adder
// Tests a selection of cases including edge cases

`timescale 1ns / 1ps

module tb_ripple_carry_adder_4bit;

    reg  [3:0] A, B;
    reg        Cin;
    wire [3:0] Sum;
    wire       Cout;

    ripple_carry_adder_4bit uut (
        .A    (A),
        .B    (B),
        .Cin  (Cin),
        .Sum  (Sum),
        .Cout (Cout)
    );

    integer errors = 0;
    reg [4:0] expected;

    task check;
        input [3:0] a_in, b_in;
        input cin_in;
        begin
            A = a_in; B = b_in; Cin = cin_in;
            #20;
            expected = a_in + b_in + cin_in;
            if ({Cout, Sum} !== expected) begin
                $display("FAIL: %0d + %0d + %0d = %0d, got %0d",
                         a_in, b_in, cin_in, expected, {Cout, Sum});
                errors = errors + 1;
            end else begin
                $display("PASS: %0d + %0d + %0d = %0d",
                         a_in, b_in, cin_in, expected);
            end
        end
    endtask

    initial begin
        $dumpfile("ripple_carry_adder.vcd");
        $dumpvars(0, tb_ripple_carry_adder_4bit);

        $display("---------------------------------------------");
        $display(" 4-Bit Ripple Carry Adder Testbench");
        $display("---------------------------------------------");

        check(4'd0,  4'd0,  1'b0);   // 0+0
        check(4'd1,  4'd1,  1'b0);   // 1+1
        check(4'd5,  4'd3,  1'b0);   // 5+3
        check(4'd7,  4'd8,  1'b0);   // 7+8 = 15
        check(4'd15, 4'd0,  1'b0);   // 15+0
        check(4'd15, 4'd1,  1'b0);   // 15+1 = 16 (overflow)
        check(4'd15, 4'd15, 1'b0);   // 15+15 = 30
        check(4'd15, 4'd15, 1'b1);   // 15+15+1 = 31
        check(4'd6,  4'd3,  1'b1);   // 6+3+1 = 10
        check(4'd0,  4'd0,  1'b1);   // 0+0+1

        $display("---------------------------------------------");
        if (errors == 0)
            $display(" ALL TESTS PASSED");
        else
            $display(" %0d TESTS FAILED", errors);
        $display("---------------------------------------------");
        $finish;
    end

endmodule
