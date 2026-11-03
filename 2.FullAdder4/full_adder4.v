`timescale 1ns/1ps

// ------------------------------------------
// 1-bit Full Adder
// Adds 3 bits: a + b + cin
// ------------------------------------------
module full_adder (
    input  a,
    input  b,
    input  cin,
    output sum,
    output cout
);

assign sum  = a ^ b ^ cin;
assign cout = (a & b) | (b & cin) | (a & cin);

endmodule


// ------------------------------------------
// 4-bit Full Adder
// Four 1-bit full adders joined in a chain
// The carry from one goes into the next
// ------------------------------------------
module full_adder4 (
    input  [3:0] A,
    input  [3:0] B,
    input        Cin,
    output [3:0] Sum,
    output       Cout
);

wire c1, c2, c3;   // carries between the adders

full_adder fa0 (.a(A[0]), .b(B[0]), .cin(Cin), .sum(Sum[0]), .cout(c1));
full_adder fa1 (.a(A[1]), .b(B[1]), .cin(c1),  .sum(Sum[1]), .cout(c2));
full_adder fa2 (.a(A[2]), .b(B[2]), .cin(c2),  .sum(Sum[2]), .cout(c3));
full_adder fa3 (.a(A[3]), .b(B[3]), .cin(c3),  .sum(Sum[3]), .cout(Cout));

endmodule
