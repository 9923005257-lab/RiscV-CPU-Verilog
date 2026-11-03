`timescale 1ns/1ps

// ------------------------------------------------------------
// Traffic Light Controller - Moore FSM
// Two roads: North-South (NS) and East-West (EW)
// Sequence: NS_GREEN -> NS_YELLOW -> EW_GREEN -> EW_YELLOW -> repeat
// ------------------------------------------------------------
module traffic_light (
    input  wire clk,
    input  wire reset,

    // North-South road lights
    output reg ns_red,
    output reg ns_yellow,
    output reg ns_green,

    // East-West road lights
    output reg ew_red,
    output reg ew_yellow,
    output reg ew_green
);

    // State encoding (4 states -> 2 bits)
    parameter NS_GREEN  = 2'b00,   // NS go,   EW stop
              NS_YELLOW = 2'b01,   // NS slow, EW stop
              EW_GREEN  = 2'b10,   // EW go,   NS stop
              EW_YELLOW = 2'b11;   // EW slow, NS stop

    // How long each light stays on (in clock ticks)
    parameter GREEN_TIME  = 4'd5,
              YELLOW_TIME = 4'd2;

    reg [1:0] state, next_state;
    reg [3:0] count;   // timer: ticks spent in the current state

    // --------------------------------------------------------
    // 1. State register + timer (sequential)
    // --------------------------------------------------------
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= NS_GREEN;
            count <= 4'd0;
        end
        else begin
            state <= next_state;

            if (state != next_state)
                count <= 4'd0;          // new state: restart timer
            else
                count <= count + 1'b1;  // same state: keep counting
        end
    end

    // --------------------------------------------------------
    // 2. Next-state logic (combinational)
    // --------------------------------------------------------
    always @(*) begin
        next_state = state;

        case (state)
            NS_GREEN:
                if (count == GREEN_TIME - 1)
                    next_state = NS_YELLOW;

            NS_YELLOW:
                if (count == YELLOW_TIME - 1)
                    next_state = EW_GREEN;

            EW_GREEN:
                if (count == GREEN_TIME - 1)
                    next_state = EW_YELLOW;

            EW_YELLOW:
                if (count == YELLOW_TIME - 1)
                    next_state = NS_GREEN;

            default:
                next_state = NS_GREEN;
        endcase
    end

    // --------------------------------------------------------
    // 3. Output logic (combinational, Moore)
    // --------------------------------------------------------
    always @(*) begin
        ns_red = 1'b0;  ns_yellow = 1'b0;  ns_green = 1'b0;
        ew_red = 1'b0;  ew_yellow = 1'b0;  ew_green = 1'b0;

        case (state)
            NS_GREEN:  begin ns_green  = 1'b1; ew_red = 1'b1; end
            NS_YELLOW: begin ns_yellow = 1'b1; ew_red = 1'b1; end
            EW_GREEN:  begin ew_green  = 1'b1; ns_red = 1'b1; end
            EW_YELLOW: begin ew_yellow = 1'b1; ns_red = 1'b1; end
            default:   begin ns_red    = 1'b1; ew_red = 1'b1; end  // safe: all red
        endcase
    end

endmodule
