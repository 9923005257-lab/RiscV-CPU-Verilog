`timescale 1ns/1ps

module dff_tb;

reg  clk;
reg  rst;
reg  d;
wire q;

dff uut (
    .clk(clk),
    .rst(rst),
    .d(d),
    .q(q)
);

// Clock: flips every 5 ns -> one full tick every 10 ns
initial clk = 0;
always #5 clk = ~clk;

initial begin

    $display("==============================================");
    $display("          D FLIP-FLOP SIMULATION");
    $display("==============================================");
    $display("Time   rst  d  q");
    $display("----------------------------------------------");

    $monitor("%4t    %b   %b  %b", $time, rst, d, q);

    // 1. Reset ON: q goes to 0
    rst = 1; d = 1;
    #12;

    // 2. Reset OFF: q copies d at every rising clock edge
    rst = 0;
    d = 1; #10;      // q -> 1
    d = 0; #10;      // q -> 0
    d = 1; #10;      // q -> 1
    d = 1; #10;      // q stays 1
    d = 0; #10;      // q -> 0

    // 3. d flickers between clock edges: q ignores it
    #4;
    d = 1; #2;
    d = 0; #12;      // q stays 0

    // 4. Set q to 1, then reset again
    d = 1;   #10;    // q -> 1
    rst = 1; #10;    // q -> 0 (reset wins, even though d = 1)

    $display("==============================================");
    $display("          SIMULATION COMPLETED");
    $display("==============================================");

    $stop;   // pause here (the clock never stops on its own)
end

endmodule
