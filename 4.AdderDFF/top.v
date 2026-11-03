// Design: 4-bit Adder with D Flip-Flop
module top(
    input clk,
    input [3:0] a, b,
    output reg [3:0] q
);

wire [3:0] sum;

// 4-bit adder
assign sum = a + b;

// Store adder output on rising clock edge
always @(posedge clk)
    q <= sum;

endmodule
