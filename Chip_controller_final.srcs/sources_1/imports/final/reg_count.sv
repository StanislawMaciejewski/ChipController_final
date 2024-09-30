`timescale 1ns / 1ps

module reg_count_24b(
    input logic REG_DIN,
    input logic REG_CNT,
    input logic REG_CLKMX,
    input logic REG_SHIFTMX,
    input logic REG_RSTN,
    input logic REG_WRMX,
    output logic [23:0] REG_STORED,
    output logic REG_DOUT
    );
      
   wire [23:0] px;
   
   single_bit PX_I31(
        .DIN(REG_DIN),
        .CNT(REG_CNT),
        .CLKMX(REG_CLKMX),
        .RSTN(REG_RSTN),
        .WRMX(REG_WRMX),
        .SHIFTMX(REG_SHIFTMX),
        .DOUT(px[0]),
        .STORED_BIT(REG_STORED[0]));    
        
   genvar i; 
   generate 
       for (i = 0; i < 23; i = i + 1) begin
         single_bit PX_I32(
         .DIN(px[i]),
         .CNT(px[i]),
         .CLKMX(REG_CLKMX),
         .RSTN(REG_RSTN),
         .WRMX(REG_WRMX),
         .SHIFTMX(REG_SHIFTMX),
         .DOUT(px[i+1]),
         .STORED_BIT(REG_STORED[i+1])
        );
       end
   endgenerate
                
    single_bit PX_I33(
        .DIN(px[23]),
        .CNT(px[23]),
        .CLKMX(REG_CLKMX),
        .RSTN(REG_RSTN),
        .WRMX(REG_WRMX),
        .SHIFTMX(REG_SHIFTMX),
        .DOUT(REG_DOUT),
        .STORED_BIT(REG_STORED[23]));
         
endmodule

