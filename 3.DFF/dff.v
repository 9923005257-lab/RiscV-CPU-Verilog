`timescale 1ns/1ps

// ------------------------------------------
// D Flip-Flop
// At every rising clock edge, q copies d.
// If rst = 1, q is cleared to 0.
// ------------------------------------------
module dff (
    input      clk,
    input      rst,
    input      d,
    output reg q
);

always @(posedge clk) begin
    if (rst)
        q <= 1'b0;   // reset: clear to 0
    else
        q <= d;      // normal: copy d
end

endmodule
