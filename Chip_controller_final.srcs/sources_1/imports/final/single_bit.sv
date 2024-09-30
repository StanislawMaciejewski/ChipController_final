`timescale 1ns / 1ps

module single_bit(
    input logic DIN,
    input logic CNT,
    input logic CLKMX,
    input logic RSTN,
    input logic SHIFTMX,
    input logic WRMX,
    output logic DOUT,
    output logic STORED_BIT);
    
    logic clk, neg_clk;
    
    bit_reg PX_I4(
    .DIN1(DIN),
    .DIN2(DOUT),
    .CLK(neg_clk),
    .RSTN(RSTN),
    .SHIFTMX(SHIFTMX),
    .DOUT(DOUT));
    
    always_comb begin
        case (SHIFTMX)
            1'b0: clk = CNT;
            1'b1: clk = CLKMX;
            default: clk = 1'bx;
         endcase
    end
    
    always_ff @(posedge WRMX or negedge RSTN) begin
        if(!RSTN)
            STORED_BIT <= 0;
        else
            STORED_BIT <= DOUT;
    end
    
    assign neg_clk = ~clk;
    
endmodule