`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2018 01:23:13 PM
// Design Name: 
// Module Name: lab4_top
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

module lab4_top(
    inout [7:0] q,
    output reg [6:0] seg,
    output reg [3:0] AN,
    input clk,
    input [7:0] seed,
    input rst
    );
    
    
    wire [6:0] Seg1;
    wire [6:0] Seg2;
    reg [20:0] refresh_counter;
        
    clock_divider CDIV (cout, clk);
    lfsr LSFR (q, seed, rst, cout);
    To_hex TH0 (Seg1, q);
    To_hex TH1 (Seg2, q >> 4);

    always @(posedge clk) refresh_counter <= refresh_counter + 1;
    
    always @(*) begin
      
        if (refresh_counter[20]) begin
            AN = 4'b1110;
            seg = Seg1;
        end else begin
            AN = 4'b1101;
            seg = Seg2;
        end 
    end        
 
endmodule
