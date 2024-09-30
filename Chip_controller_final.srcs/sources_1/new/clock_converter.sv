`timescale 1ns / 1ps

module clock_converter(
    input logic clkmx,
    input logic clkg,
    input logic rstn,
    output logic load
);
   
   reg load_nxt; 
    
      always_ff @(posedge clkg or negedge rstn) begin
      if (!rstn)
        load <= 1'b0;
      else
        load <= load_nxt;
    end
    
    always_ff @(posedge clkmx or posedge load or negedge rstn) begin
      if (!rstn)
        load_nxt <= 1'b0;
      else if (!load)
        load_nxt <= 1'b1;
      else
        load_nxt <= 1'b0;
    end
    
endmodule