`include "controler.vh"

`timescale 1ns / 1ps

module logic_control(
    input logic DIN,
    input logic CLKG,
    input logic RSTN,
    input logic CLKMX,
    input logic WRMX,
    input  logic [M-1:0] MX_DOUT,
    output logic DOUT,
    output logic [M+1:0] MX_DIN,
    output logic [M+1:0] CR_DIN,
    output logic  MX_CLKMX,
    output logic MX_RSTNMX,
    output logic MX_WRMX
);
    
    wire [M+1:0] p_out, y0_out, y1_out;
    wire en_piso, en_sipo;
    
    sipo I21_SIPO (
        .clk(CLKG), 
        .rstn(RSTN), 
        .en(CLKMX),
        .s_in(DIN), 
        .p_out(p_out)
    );
    
    piso I22_PISO (
        .clkg(CLKG), 
        .rstn(RSTN), 
        .p_in(MX_DOUT),
        .clkmx(CLKMX), 
        .s_out(DOUT)
    );
    
    demux_2_1 #(M+2) I23_DEMUX(
      .sel(p_out[M]),
      .i(p_out),
      .y0(MX_DIN), 
      .y1(CR_DIN));
    
    assign MX_CLKMX     = CLKMX;
    assign MX_RSTNMX    = RSTN;
    assign MX_WRMX      = WRMX;
    
endmodule
