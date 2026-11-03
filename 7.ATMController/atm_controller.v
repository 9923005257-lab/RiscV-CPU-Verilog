// ATM Machine Controller - Verilog Design
module atm_controller (
    input wire clk, reset, card_insert, pin_valid, withdraw_req, sufficient_balance,
    output reg pin_prompt, menu_display, dispense_cash, transaction_done, card_eject
);
    localparam IDLE=3'd0, PIN_CHECK=3'd1, MENU=3'd2, WITHDRAW=3'd3,
               DISPENSE=3'd4, DONE=3'd5, EJECT_CARD=3'd6;
    reg [2:0] state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) state <= IDLE;
        else state <= next_state;
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE:       if (card_insert) next_state = PIN_CHECK;
            PIN_CHECK:  if (pin_valid) next_state = MENU;
                        else next_state = EJECT_CARD;
            MENU:       if (withdraw_req) next_state = WITHDRAW;
            WITHDRAW:  if (sufficient_balance) next_state = DISPENSE;
                        else next_state = DONE;
            DISPENSE:   next_state = DONE;
            DONE:       next_state = EJECT_CARD;
            EJECT_CARD: next_state = IDLE;
            default:    next_state = IDLE;
        endcase
    end

    always @(*) begin
        pin_prompt = 0; menu_display = 0; dispense_cash = 0;
        transaction_done = 0; card_eject = 0;
        case (state)
            PIN_CHECK:  pin_prompt = 1;
            MENU:       menu_display = 1;
            DISPENSE:   dispense_cash = 1;
            DONE:       transaction_done = 1;
            EJECT_CARD: card_eject = 1;
            default: ;
        endcase
    end
endmodule
