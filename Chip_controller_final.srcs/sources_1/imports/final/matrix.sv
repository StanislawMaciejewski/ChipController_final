`include "controler.vh"

`timescale 1ns / 1ps

module matrix (
        input logic [M-1:0] MX_DIN,
        input logic MX_CLKMX,
        input logic MX_RSTN,
        input logic MX_SHIFTMX,
        input logic MX_WRMX,
        output logic [M-1:0] MX_DOUT);
        
        logic shiftmx;
        
        always_ff @(posedge MX_CLKMX)
        begin
            shiftmx <= MX_SHIFTMX;
        end
        
        genvar i; 
        generate 
            for (i = 0; i < M; i = i + 1) begin
              column #(.N_NUM(i)) COL_I0(
                   .N_DIN(MX_DIN[i]),
                   .N_CLKMX(MX_CLKMX),
                   .N_RSTN(MX_RSTN),
                   .N_SHIFTMX(shiftmx),
                   .N_WRMX(MX_WRMX),
                   .N_DOUT(MX_DOUT[i])
             );
            end
        endgenerate
    
endmodule

