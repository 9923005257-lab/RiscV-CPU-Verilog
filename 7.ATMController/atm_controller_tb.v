`timescale 1ns/1ps
module atm_controller_tb;
    reg clk, reset, card_insert, pin_valid, withdraw_req, sufficient_balance;
    wire pin_prompt, menu_display, dispense_cash, transaction_done, card_eject;

    atm_controller uut (
        .clk(clk), .reset(reset), .card_insert(card_insert),
        .pin_valid(pin_valid), .withdraw_req(withdraw_req),
        .sufficient_balance(sufficient_balance), .pin_prompt(pin_prompt),
        .menu_display(menu_display), .dispense_cash(dispense_cash),
        .transaction_done(transaction_done), .card_eject(card_eject)
    );

    initial begin clk=0; forever #5 clk=~clk; end

    // Scenario: insert card, enter valid PIN, request withdrawal with sufficient balance
    initial begin
        reset=1; card_insert=0; pin_valid=0; withdraw_req=0; sufficient_balance=0;
        #12 reset=0;
        #8 card_insert=1;
        #10 card_insert=0; pin_valid=1;
        #10 withdraw_req=1; sufficient_balance=1;
        #10 withdraw_req=0;
        #50 $finish;
    end

    initial begin
        $monitor("t=%0t reset=%b card=%b pin=%b withdraw=%b balance=%b | prompt=%b menu=%b cash=%b done=%b eject=%b",
          $time, reset, card_insert, pin_valid, withdraw_req, sufficient_balance,
          pin_prompt, menu_display, dispense_cash, transaction_done, card_eject);
    end
endmodule
