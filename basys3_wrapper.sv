`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2016 03:44:02 PM
// Design Name: 
// Module Name: basys3_wrapper
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


module basys3_wrapper(
    input clk,
    input btnR,
    output [6:0] seg,
    output dp,
    output [3:0] an
    
    );
    
    wire [31:0] reg_write_data;
    reg [43:0] clk_divide;
    wire seg_disp_clk;
    wire processor_clk;
    
    assign dp = 1'b1;
    assign seg_disp_clk = clk_divide[17];
    assign processor_clk = clk_divide[28];
    
    
    processor 
        processor_31L(
        .clk(processor_clk),
        .rst(btnR),
        .reg_write_data(reg_write_data)
        );
    
    
    always_ff @(posedge clk) begin
        clk_divide = clk_divide + 'd1;
    end
    
    seg_display
        seg_display0 (
        .clk (seg_disp_clk),
        .rst (btnR),
        .data_in (reg_write_data[15:0]),
        .seg (seg),
        .an (an)
        );
    
    
endmodule
