`timescale 1ns / 1ps

module demux_2_1#(parameter SIZE = 1)(
  input logic sel,
  input logic [SIZE-1:0] i,
  output logic [SIZE-1:0] y0, 
  output logic [SIZE-1:0] y1);
  
  
  logic [SIZE-1:0] val = 'bx;
  assign {y0,y1} = sel?{val,i}: {i,val};
  
endmodule
