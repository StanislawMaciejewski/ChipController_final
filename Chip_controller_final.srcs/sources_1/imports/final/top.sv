`timescale 1ns / 1ps
`include "controler.vh"

module top_module(
    input logic DIN,
    input logic CLKG,
    input logic CLKMX,
    input logic RSTN,
    input logic WRMX,
    output logic DOUT);
    
    wire [M+1:0] mx_data;
    wire [M+1:0] cr_data;
    wire clk_mx, rstn_mx, write_mx, shift_mx;
    wire [M-1:0] dout_mx;
    
    logic_control I1_logic_ctl(
        .DIN(DIN),
        .CLKG(CLKG), 
        .RSTN(RSTN),
        .CLKMX(CLKMX),
        .WRMX(WRMX),
        .DOUT(DOUT),
        .MX_DIN(mx_data[M+1:0]),
        .CR_DIN(cr_data[M+1:0]),
        .MX_CLKMX(clk_mx),
        .MX_RSTNMX(rstn_mx),
        .MX_WRMX(write_mx),
        .MX_DOUT(dout_mx));
    
    conf_reg I2_conf_reg (
        .clk(CLKMX),
        .rstn(RSTN),
        .wr(cr_data[M+1]),
        .sel(cr_data[M]),
        .wdata(cr_data[M-1:0]));
    
    matrix I3_matrix(
      .MX_DIN(mx_data[M-1:0]),
      .MX_CLKMX(clk_mx),
      .MX_RSTN(rstn_mx),
      .MX_WRMX(write_mx),
      .MX_SHIFTMX(mx_data[M+1]),
      .MX_DOUT(dout_mx));
      
      
endmodule
