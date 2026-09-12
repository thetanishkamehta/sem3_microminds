// Testbench for 4:1 MUX

`timescale 1ns / 1ps

module tb_mux_4to1;

    reg  [3:0] D;
    reg  [1:0] Sel;
    wire       Y;

    mux_4to1 uut (
        .D   (D),
        .Sel (Sel),
        .Y   (Y)
    );

    integer errors = 0;
    reg expected;

    initial begin
        $dumpfile("mux_4to1.vcd");
        $dumpvars(0, tb_mux_4to1);

        $display("-------------------------------");
        $display(" 4:1 MUX Testbench");
        $display("-------------------------------");

        // Test: each select picks the correct input
        D = 4'b1010;  // D3=1, D2=0, D1=1, D0=0

        Sel = 2'b00; #10;
        expected = D[0];
        $display("Sel=%b D=%b Y=%b exp=%b %s", Sel, D, Y, expected, (Y===expected)?"PASS":"FAIL");
        if (Y !== expected) errors = errors + 1;

        Sel = 2'b01; #10;
        expected = D[1];
        $display("Sel=%b D=%b Y=%b exp=%b %s", Sel, D, Y, expected, (Y===expected)?"PASS":"FAIL");
        if (Y !== expected) errors = errors + 1;

        Sel = 2'b10; #10;
        expected = D[2];
        $display("Sel=%b D=%b Y=%b exp=%b %s", Sel, D, Y, expected, (Y===expected)?"PASS":"FAIL");
        if (Y !== expected) errors = errors + 1;

        Sel = 2'b11; #10;
        expected = D[3];
        $display("Sel=%b D=%b Y=%b exp=%b %s", Sel, D, Y, expected, (Y===expected)?"PASS":"FAIL");
        if (Y !== expected) errors = errors + 1;

        // Change data pattern
        D = 4'b0101;  // D3=0, D2=1, D1=0, D0=1

        Sel = 2'b00; #10;
        expected = D[0];
        $display("Sel=%b D=%b Y=%b exp=%b %s", Sel, D, Y, expected, (Y===expected)?"PASS":"FAIL");
        if (Y !== expected) errors = errors + 1;

        Sel = 2'b01; #10;
        expected = D[1];
        $display("Sel=%b D=%b Y=%b exp=%b %s", Sel, D, Y, expected, (Y===expected)?"PASS":"FAIL");
        if (Y !== expected) errors = errors + 1;

        Sel = 2'b10; #10;
        expected = D[2];
        $display("Sel=%b D=%b Y=%b exp=%b %s", Sel, D, Y, expected, (Y===expected)?"PASS":"FAIL");
        if (Y !== expected) errors = errors + 1;

        Sel = 2'b11; #10;
        expected = D[3];
        $display("Sel=%b D=%b Y=%b exp=%b %s", Sel, D, Y, expected, (Y===expected)?"PASS":"FAIL");
        if (Y !== expected) errors = errors + 1;

        $display("-------------------------------");
        if (errors == 0) $display(" ALL TESTS PASSED");
        else $display(" %0d TESTS FAILED", errors);
        $display("-------------------------------");
        $finish;
    end

endmodule
