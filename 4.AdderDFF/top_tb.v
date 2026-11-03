`timescale 1ns/1ps

// Testbench for top module
module top_tb;

reg clk;
reg [3:0] a, b;
wire [3:0] q;

top uut(clk, a, b, q);

// Clock generation: 10 ns period
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

// Input stimulus
initial begin
    a = 4'b0011; b = 4'b0010; // 3 + 2 = 5
    #10 a = 4'b0100; b = 4'b0011; // 4 + 3 = 7
    #10 a = 4'b1000; b = 4'b0010; // 8 + 2 = 10
    #10 a = 4'b1111; b = 4'b0000; // 15 + 0 = 15
    #10 $finish;
end

// Monitor and waveform dump
initial begin
    $dumpfile("top.vcd");
    $dumpvars(0, top_tb);
    $monitor("Time=%0t CLK=%b A=%b B=%b Q=%b", $time, clk, a, b, q);
end

endmodule
