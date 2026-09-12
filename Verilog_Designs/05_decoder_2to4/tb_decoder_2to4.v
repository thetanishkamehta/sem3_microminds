// Testbench for 2:4 Decoder

`timescale 1ns / 1ps

module tb_decoder_2to4;

    reg  [1:0] A;
    reg        En;
    wire [3:0] Y;

    decoder_2to4 uut (
        .A  (A),
        .En (En),
        .Y  (Y)
    );

    integer i, errors = 0;
    reg [3:0] expected;

    initial begin
        $dumpfile("decoder_2to4.vcd");
        $dumpvars(0, tb_decoder_2to4);

        $display("-------------------------------");
        $display(" 2:4 Decoder Testbench");
        $display("-------------------------------");

        // Test with enable OFF — all outputs should be 0
        En = 0;
        for (i = 0; i < 4; i = i + 1) begin
            A = i[1:0]; #10;
            if (Y !== 4'b0000) begin
                $display("FAIL: En=0 A=%b Y=%b (expected 0000)", A, Y);
                errors = errors + 1;
            end else
                $display("PASS: En=0 A=%b Y=%b", A, Y);
        end

        // Test with enable ON
        En = 1;
        for (i = 0; i < 4; i = i + 1) begin
            A = i[1:0]; #10;
            expected = (1 << i);
            if (Y !== expected) begin
                $display("FAIL: En=1 A=%b Y=%b (expected %b)", A, Y, expected);
                errors = errors + 1;
            end else
                $display("PASS: En=1 A=%b Y=%b", A, Y);
        end

        $display("-------------------------------");
        if (errors == 0) $display(" ALL TESTS PASSED");
        else $display(" %0d TESTS FAILED", errors);
        $display("-------------------------------");
        $finish;
    end

endmodule
