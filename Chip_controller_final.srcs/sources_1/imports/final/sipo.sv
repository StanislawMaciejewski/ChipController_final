`timescale 1ns / 1ps
`include "controler.vh"

module sipo(
    input logic clk, 
    input logic rstn, 
    input logic s_in,
    input logic en, 
    output logic [M+1:0] p_out);

    logic [M+1:0] p_out_nxt;

    always_ff @(negedge clk)
    begin
//        if (!rstn)  
//            p_out_nxt <= 0;
//        else begin
            p_out_nxt <= p_out_nxt << 1;
            p_out_nxt[0] <= s_in;
//        end   
    end
    
    always_ff @(negedge en)
    begin
          p_out <= p_out_nxt;
    end

endmodule