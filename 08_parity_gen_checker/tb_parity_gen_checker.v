// Testbench for Even Parity Generator and Checker
//
// The generator's output feeds the checker, like a sender and a receiver.
// Part 1: all 16 data values sent cleanly — checker must report no error.
// Part 2: for every data value, flip each of the 5 transmitted bits in
//         turn (a single-bit error) — checker must report an error.

`timescale 1ns / 1ps

module tb_parity_gen_checker;

    reg  [3:0] D;          // data at the sender
    wire       P;          // parity bit from the generator
    reg  [4:0] flip;       // which transmitted bit to corrupt (one-hot, 0 = none)
    wire [3:0] D_rx;       // data at the receiver
    wire       P_rx;       // parity at the receiver
    wire       Error;

    parity_generator gen (
        .D (D),
        .P (P)
    );

    // "Channel" — XOR with flip injects an error into the chosen bit
    assign {D_rx, P_rx} = {D, P} ^ flip;

    parity_checker chk (
        .D     (D_rx),
        .P     (P_rx),
        .Error (Error)
    );

    integer i, b;
    integer errors = 0;
    integer ones;

    initial begin
        $dumpfile("parity_gen_checker.vcd");
        $dumpvars(0, tb_parity_gen_checker);

        $display("---------------------------------------------");
        $display(" Even Parity Generator / Checker Testbench");
        $display("---------------------------------------------");
        $display(" Part 1: clean transmission");
        $display("  D    | P | total 1s | Error");

        flip = 5'b00000;
        for (i = 0; i < 16; i = i + 1) begin
            D = i[3:0];
            #10;
            ones = D[3] + D[2] + D[1] + D[0] + P;

            $display("  %b | %b |    %0d     |   %b   %s",
                     D, P, ones, Error,
                     (ones % 2 == 0 && Error === 1'b0) ? "PASS" : "FAIL");

            if (ones % 2 != 0 || Error !== 1'b0)
                errors = errors + 1;
        end

        $display(" Part 2: single-bit errors (16 values x 5 bits = 80 cases)");
        for (i = 0; i < 16; i = i + 1) begin
            for (b = 0; b < 5; b = b + 1) begin
                D    = i[3:0];
                flip = 5'b00001 << b;
                #10;
                if (Error !== 1'b1) begin
                    $display("  FAIL: D=%b flip=%b not detected", D, flip);
                    errors = errors + 1;
                end
            end
        end
        flip = 5'b00000;
        $display("  done");

        $display("---------------------------------------------");
        if (errors == 0)
            $display(" ALL TESTS PASSED");
        else
            $display(" %0d TESTS FAILED", errors);
        $display("---------------------------------------------");

        $finish;
    end

endmodule
