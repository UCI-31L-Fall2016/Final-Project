`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2016 04:08:56 PM
// Design Name: 
// Module Name: seg_display
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


module seg_display(
    input logic clk,
    input logic rst,
    input logic [15:0] data_in,
    output logic [6:0] seg,
    output logic [3:0] an
    );

    logic [1:0] seg_choose;
    logic [3:0] digit0 = data_in[3:0];
    logic [3:0] digit1 = data_in[7:4];
    logic [3:0] digit2 = data_in[11:8];
    logic [3:0] digit3 = data_in[15:12];
    logic [3:0] curr_digit;


    always_ff @(posedge clk, posedge rst) begin
        if (rst) begin
            seg_choose = 'd0;
        end
        else begin
            seg_choose = seg_choose + 'd1;
        end
    end

    always_comb begin
        an = 4'b1111;

        case (seg_choose)
        2'b00 : an = 4'b1110;
        2'b01 : an = 4'b1101;
        2'b10 : an = 4'b1011;
        default : an = 4'b0111;
        endcase
    end
    
    always_comb begin
        curr_digit = digit0;

        case (seg_choose)
        2'b00 : curr_digit = digit0;
        2'b01 : curr_digit = digit1;
        2'b10 : curr_digit = digit2;
        default : curr_digit = digit3;
        endcase
    end



    always_comb begin
        seg = 7'b1111111;

        case(curr_digit)
        4'h0 : seg = 7'b1000000;
        4'h1 : seg = 7'b1111001;
        4'h2 : seg = 7'b0100100;
        4'h3 : seg = 7'b0110000;
        4'h4 : seg = 7'b0011001;
        4'h5 : seg = 7'b0010010;
        4'h6 : seg = 7'b0000010;
        4'h7 : seg = 7'b1111000;
        4'h8 : seg = 7'b0000000;
        4'h9 : seg = 7'b0011000;
        4'ha : seg = 7'b0001000;
        4'hb : seg = 7'b0000011;
        4'hc : seg = 7'b1000110;
        4'hd : seg = 7'b0100001;
        4'he : seg = 7'b0000110;
        default : seg = 7'b0001110;
        endcase

    end

endmodule
