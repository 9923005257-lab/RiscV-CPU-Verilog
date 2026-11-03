`timescale 1ns/1ps

module traffic_light_tb;

    reg clk;
    reg reset;

    wire ns_red, ns_yellow, ns_green;
    wire ew_red, ew_yellow, ew_green;

    integer errors;

    // Device under test
    traffic_light uut (
        .clk(clk),
        .reset(reset),
        .ns_red(ns_red),
        .ns_yellow(ns_yellow),
        .ns_green(ns_green),
        .ew_red(ew_red),
        .ew_yellow(ew_yellow),
        .ew_green(ew_green)
    );

    // 10 ns clock period
    always #5 clk = ~clk;

    initial begin
        clk    = 1'b0;
        reset  = 1'b1;
        errors = 0;

        // Reset
        #12;
        reset = 1'b0;

        // Run 2 full light cycles: (5 + 2 + 5 + 2) ticks x 10 ns x 2 = 280 ns
        #280;

        if (errors == 0)
            $display("TEST PASSED: both roads were never open together");
        else
            $display("TEST FAILED: %0d unsafe moments", errors);

        $stop;
    end

    // Safety check: both roads must never be allowed to move at the same time
    always @(negedge clk) begin
        if ((ns_green || ns_yellow) && (ew_green || ew_yellow)) begin
            errors = errors + 1;
            $display("ERROR at %0t: both roads open!", $time);
        end
    end

    // Print every change
    initial begin
        $monitor(
            "Time=%0t | State=%b | NS: R=%b Y=%b G=%b | EW: R=%b Y=%b G=%b",
            $time, uut.state,
            ns_red, ns_yellow, ns_green,
            ew_red, ew_yellow, ew_green
        );
    end

endmodule
