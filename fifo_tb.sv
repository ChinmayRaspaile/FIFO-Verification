`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2025 23:08:35
// Design Name: 
// Module Name: fifo_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps

module fifo_tb;
parameter DEPTH = 16, WIDTH = 8;

logic clk, rst, wr_en, rd_en;
logic [WIDTH-1:0] data_in, data_out;
logic full, empty;

fifo #(DEPTH, WIDTH) l1 
(.clk(clk), .rst(rst), .wr_en(wr_en), .rd_en(rd_en),
.data_in(data_in), .data_out(data_out),.full(full), .empty(empty));

initial clk = 0;
always #5 clk = ~clk;

task reset_fifo;
begin
    rst = 1;
    wr_en = 0;
    rd_en = 0;
    data_in = 0;
    #10 rst = 0;
end
endtask

task write_fifo(input logic [WIDTH-1:0] value);
begin
    if (!full) begin
        wr_en = 1;
        data_in = value;
        #10 wr_en = 0;
    end
end
endtask

task read_fifo(output logic [WIDTH-1:0] value);
begin
    if (!empty) begin
        rd_en = 1;
        #10 value = data_out;
        rd_en = 0;
    end
end
endtask

initial begin
    reset_fifo();

    // Directed Test Cases
    for (int i = 0; i < DEPTH; i++) begin
        write_fifo(i);
    end

    if (full) $display("PASS Overflow Test: FIFO is full after 16 writes");
    else $error("FAIL Overflow Test: FIFO should be full");

    for (int i = 0; i < DEPTH; i++) begin
        logic [WIDTH-1:0] expected_value = i;
        logic [WIDTH-1:0] read_value;
        read_fifo(read_value);
        if (read_value !== expected_value)
            $error("FAIL Read FIFO: Mismatch Detected. Expected: %0d, Got: %0d", expected_value, read_value);
        else
            $display("PASS Read FIFO: Expected: %0d, Got: %0d", expected_value, read_value);
    end

    if (empty) $display("PASS: FIFO is empty after 16 reads");
    else $error("FAIL: FIFO should be empty");

    // Random Test Cases
    // Random Test Cases
// Random Test Cases
for (int i = 0; i < 10; i++) begin
    logic [WIDTH-1:0] rand_val = $urandom_range(0, 255);
    logic [WIDTH-1:0] read_val;

    write_fifo(rand_val);
    #20; // Ensure write completes before checking FIFO state

    if (!empty) begin
        #10; // Extra delay to stabilize FIFO output
        read_fifo(read_val);
        #10; // Ensure data is latched before checking

        if (rand_val !== read_val)
            $error("FAIL: Mismatch Detected Random Testing. Expected: %0d, Got: %0d", rand_val, read_val);
        else
            $display("PASS Random Testing: Expected: %0d, Got: %0d", rand_val, read_val);
    end else begin
        $error("FAIL: FIFO was empty when trying to read random data");
    end
end




    $display("Test Completed");
    $finish;
end

endmodule

