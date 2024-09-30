`include "controler.vh"

module conf_reg (
    input logic clk,
    input logic rstn,
    input logic wr,
    input logic sel,
    inout logic [M-1:0]    wdata,
    output logic [M*N-1:0]   data);

	reg [M*N-1:0] register;

	always_ff @(posedge clk) begin
    if (!rstn)
    	register <= 0;
    else begin
    	if (sel & ~wr) begin
    	     register <= register << M;
      	     register[M-1:0] <= wdata;
      	end
    	else
      	     register <= register;
        end
	end

	assign data = register;
endmodule