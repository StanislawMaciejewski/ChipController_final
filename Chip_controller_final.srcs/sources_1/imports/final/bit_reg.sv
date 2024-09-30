`timescale 1ns / 1ps

module bit_reg(    
    input logic DIN1,
    input logic DIN2,
    input logic CLK,
    input logic RSTN,
    input logic SHIFTMX,
    output logic DOUT);
    
    logic out, out_neg;
    
    always_ff @(posedge CLK) begin
        if (!RSTN)
            DOUT <= 1'b0;
        else if (out === 1'bx)  
            DOUT <= 1'b0;
        else 
            DOUT <= out_neg;
    end 
    
    always_comb begin
        case (SHIFTMX)
            1'b0: out = DIN2;
            1'b1: out = (!DIN1);
            default: out = 1'b0;
         endcase
    end  
    
    assign out_neg = ~out;

        

endmodule