//`define GEN_SIG

`timescale 1ns / 1ps
`include "controler.vh"

module pixel #(parameter CNT_NUM = 0)(
    input logic PX_DIN,
    input logic PX_CLKMX,
    input logic PX_RSTN,
    input logic PX_SHIFTMX,
    input logic PX_WRMX,
    output logic PX_DOUT);

    wire pulse_out;
    logic [23:0]REG_STORED;
    
`ifdef GEN_SIG
    pulse_generator I0_detector(
    .RSTN(PX_RSTN),
    .SHIFTMX(PX_SHIFTMX),
    .COUNTS(CNT_NUM),
    .PULSE(pulse_out));
`endif
    
   reg_count_24b REG_CNT_I2(
    .REG_DIN(PX_DIN),
    .REG_CNT(pulse_out),
    .REG_CLKMX(PX_CLKMX),
    .REG_RSTN(PX_RSTN),
    .REG_SHIFTMX(PX_SHIFTMX),
    .REG_WRMX(PX_WRMX),
    .REG_DOUT(PX_DOUT),
    .REG_STORED(REG_STORED)
    );
         
         
endmodule