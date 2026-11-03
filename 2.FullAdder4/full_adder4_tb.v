`timescale 1ns/1ps

module full_adder4_tb;

reg  [3:0] A;
reg  [3:0] B;
reg        Cin;

wire [3:0] Sum;
wire       Cout;

full_adder4 uut (
    .A(A),
    .B(B),
    .Cin(Cin),
    .Sum(Sum),
    .Cout(Cout)
);

initial begin

    $display("==============================================");
    $display("        4-BIT FULL ADDER SIMULATION");
    $display("==============================================");
    $display("Time   A      B      Cin   Sum    Cout");
    $display("----------------------------------------------");

    $monitor("%4t   %b   %b   %b     %b   %b",
             $time, A, B, Cin, Sum, Cout);

    // 0 + 0 + 0 = 0       -> Sum 0000, Cout 0
    A = 4'b0000; B = 4'b0000; Cin = 1'b0;
    #20;

    // 5 + 3 + 0 = 8       -> Sum 1000, Cout 0
    A = 4'b0101; B = 4'b0011; Cin = 1'b0;
    #20;

    // 7 + 8 + 0 = 15      -> Sum 1111, Cout 0
    A = 4'b0111; B = 4'b1000; Cin = 1'b0;
    #20;

    // 9 + 6 + 1 = 16      -> Sum 0000, Cout 1
    A = 4'b1001; B = 4'b0110; Cin = 1'b1;
    #20;

    // 15 + 1 + 0 = 16     -> Sum 0000, Cout 1
    A = 4'b1111; B = 4'b0001; Cin = 1'b0;
    #20;

    // 15 + 15 + 1 = 31    -> Sum 1111, Cout 1
    A = 4'b1111; B = 4'b1111; Cin = 1'b1;
    #20;

    // 10 + 4 + 1 = 15     -> Sum 1111, Cout 0
    A = 4'b1010; B = 4'b0100; Cin = 1'b1;
    #20;

    // 12 + 7 + 0 = 19     -> Sum 0011, Cout 1
    A = 4'b1100; B = 4'b0111; Cin = 1'b0;
    #20;

    $display("==============================================");
    $display("          SIMULATION COMPLETED");
    $display("==============================================");

end

endmodule
