`timescale 1ns / 1ps
//`define DIN_SERIAL
`define COUNT
`define CHECK_DOUT


module testbench_4Mx18N();
    
    parameter M = 4;
    parameter N = 18;
    parameter T_CLKG = 10;
    parameter T_CLKMX = 60; // (M+2)*T_CLKG
    
    reg din, clkg, clkmx, rstn, write;
    wire dout;
    
    reg [0:23] data [M-1:0] = '{24'h000000, 24'hFFFFFF, 24'h555555, 24'h777777};
    
    top_module dut(
    .DIN(din),
    .CLKG(clkg),
    .CLKMX(clkmx),
    .RSTN(rstn),
    .DOUT(dout));
    
    task reset;
        begin
            @(negedge clkmx);
            din = 1'b1;
            rstn = 1'b0;
            @(negedge clkmx);
            din = 1'b1;
            rstn = 1'b1;
        end
    endtask
    
    task serial_data_din; // funkcja do wpisywania ramek danych
        input [0:23] data [M-1:0];
        input integer delay;
        input integer repeat_cnt;
        
        integer i, m_id;
        begin
            repeat(repeat_cnt) begin
                for (i=0; i < 24; i = i+1) begin
                    din = 1'b1;
                    #delay;
                    din = 1'b0;
                    #delay;
                    for (m_id = M-1; m_id >= 0; m_id = m_id - 1) begin
                        din = data[m_id][i];
                        #delay;
                    end
                end
            end
        end
    endtask
    
    task serial_din; // funkcja do wpisywania pozosta³ych ramek
        input [M+1:0] pattern;
        input integer delay;
        input integer repeat_cnt;
        
        integer i,j ;
        begin
            for (i=0; i < repeat_cnt; i = i+1) begin
                for (j = M+1; j >= 0; j = j-1) begin
                    din = pattern[j];
                    #delay;
                end
            end
        end
    endtask
    
    initial begin
        rstn = 1;
        din = 1;
        write = 0;
        
        reset();
        
        `ifdef DIN_SERIAL
            serial_data_din(data, T_CLKG, N); 
        `endif
        
        `ifdef COUNT
            serial_din(6'b00xxxx, T_CLKG, 500);
        `endif
        
        serial_din(6'b10xxxx, T_CLKG, 500);
        serial_din(6'b011111, T_CLKG, N/2);
        serial_din(6'b010000, T_CLKG, N/2); 
    end
    
    initial begin
        clkmx = 0;
        forever #(T_CLKMX/2) clkmx = ~clkmx; // 40
    end
    
    initial begin
        clkg = 0;
        forever #(T_CLKG/2) clkg = ~clkg;
    end
    
    `ifdef CHECK_DOUT
            
      integer infile;
      reg expected_data;
      
      initial begin
        integer mismatch_count;
        mismatch_count = 0;
        
        `ifdef DIN_SERIAL
            infile = $fopen("din_serial_4Mx18N.txt", "r");
        `elsif COUNT
            infile = $fopen("count_4Mx18N.txt", "r");
        `endif
        
        if (infile == 0) begin
            $display("Error: Failed to open file data.txt");
            $finish;
        end
        
        #1;
        forever begin
            #T_CLKG;
            if ($fscanf(infile, "%d\n", expected_data) != 1) begin
                if (mismatch_count == 0) begin
                    $display("Data passed: No mismatches found.");
                end else begin
                    $display("Data failed: %0d mismatches found.", mismatch_count);
                end
                $finish;
            end
        
            if (expected_data !== dout) begin
                $display("%0t: Mismatch detected: Expected %d, Got %d", $time, expected_data, dout);
                mismatch_count = mismatch_count + 1;
            end
        end
     end
    `endif

endmodule
