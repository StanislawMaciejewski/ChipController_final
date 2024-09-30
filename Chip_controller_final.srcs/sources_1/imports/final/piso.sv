`timescale 1ns / 1ps
`include "controler.vh"

module piso(
  input logic clkg,
  input logic rstn,
  input logic [M-1:0] p_in,
  input logic clkmx,
  output logic s_out);

  logic [M+1:0] out_nxt, out;
  logic load;
  
  clock_converter clk_convert(
    .clkg(clkg),
    .clkmx(clkmx),
    .rstn(rstn),
    .load(load)
  );
  
  always_ff @(posedge clkg)
  begin
    if(!rstn)
       out <= 0; 
    else if(load)
       out <= {2'b0, p_in};
    else
       out <= {1'b0, out[M+1:1]};
  end

  assign s_out = out[0];
  
endmodule 
