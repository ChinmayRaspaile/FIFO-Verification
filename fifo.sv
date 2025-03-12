`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2025 23:07:08
// Design Name: 
// Module Name: fifo
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


module fifo #(parameter DEPTH = 16, WIDTH = 8) (
    input logic clk, rst,
    input logic wr_en, rd_en,
    input logic [WIDTH-1:0] data_in,
    output logic [WIDTH-1:0] data_out,
    output logic full, empty);

    logic [WIDTH-1:0] mem [0:DEPTH-1]; // FIFO memory
    logic [$clog2(DEPTH)-1:0] wr_ptr, rd_ptr; // Reduced bit width
    logic [$clog2(DEPTH):0] count;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            count  <= 0;
            data_out <= 0;
        end else begin
            // Write operation
            if (wr_en && !full) begin
                mem[wr_ptr] <= data_in;
                wr_ptr <= (wr_ptr + 1) % DEPTH;
                count  <= count + 1;
            end
            
            // Read operation
            if (rd_en && !empty) begin
                data_out <= mem[rd_ptr];
                rd_ptr <= (rd_ptr + 1) % DEPTH;
                count  <= count - 1;
            end
        end
    end

    // Status flags
    assign full  = (count == DEPTH);
    assign empty = (count == 0);

endmodule

