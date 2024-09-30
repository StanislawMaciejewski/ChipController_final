`include "controler.vh"

`timescale 1ns / 1ps

module column #(parameter N_NUM = 0)(
        input logic N_DIN,
        input logic N_CLKMX,
        input logic N_RSTN,
        input logic N_SHIFTMX,
        input logic N_WRMX,
        output logic N_DOUT);
    
    wire [N-2:0] px;
    wire last_px_dout;
    
    pixel #(.CNT_NUM(N*N_NUM)) PX_I11(
           .PX_DIN(N_DIN),
           .PX_CLKMX(N_CLKMX),
           .PX_RSTN(N_RSTN),
           .PX_SHIFTMX(N_SHIFTMX),
           .PX_WRMX(N_WRMX),
           .PX_DOUT(px[0]));    
    
    genvar i; 
    generate 
        for (i = 0; i < N-2; i = i + 1) begin
          pixel #(.CNT_NUM(N*N_NUM+i+1)) PX_I12(
          .PX_DIN(px[i]),
          .PX_CLKMX(N_CLKMX),
          .PX_RSTN(N_RSTN),
          .PX_SHIFTMX(N_SHIFTMX),
          .PX_WRMX(N_WRMX),
          .PX_DOUT(px[i+1])
         );
        end
    endgenerate
            
   pixel #(.CNT_NUM(N*N_NUM+N-1)) PX_I13(
         .PX_DIN(px[N-2]),
         .PX_CLKMX(N_CLKMX),
         .PX_RSTN(N_RSTN),
         .PX_SHIFTMX(N_SHIFTMX),
         .PX_WRMX(N_WRMX),
         .PX_DOUT(last_px_dout));  
         
   assign N_DOUT = N_SHIFTMX ? last_px_dout : 1'b0;
         
endmodule

