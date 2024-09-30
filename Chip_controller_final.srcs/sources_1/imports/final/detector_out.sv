`timescale 1ns / 1ps

module pulse_generator (
    input logic RSTN,
    input logic SHIFTMX,
    input logic [31:0] COUNTS,
    output logic PULSE
);

reg clk;
integer i;
reg enable;

initial begin
   //i=0;
   clk = 0; 
   forever #(($random%10) + 45) clk = ~clk;  //(($random%10) + 10)
end

always_ff @(posedge clk or negedge RSTN) begin
    if(!RSTN) begin
        i=0;
        enable = 0;
    end
    else begin
        if(!SHIFTMX) begin 
            if(i<COUNTS) begin // <
                enable = 1;
                i++;
            end
            else begin
                enable = 0;
            end
        end
    end
end

and_gate AND_1(
.a(enable), 
.b(clk), 
.y(PULSE));

endmodule
