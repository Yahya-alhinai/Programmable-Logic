`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/16/2018 03:59:40 PM
// Design Name: 
// Module Name: lfsr
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


module lfsr (
    output reg [7:0]q,
    input [7:0] seed,
    input rst,
    input clock
    );
    
    wire din;
    
   assign din = q[1]^q[2]^q[3]^q[7];
   
    always @(posedge clock)
        if (rst) begin
            q <= seed;
        end else begin
            q[0] <= din;
            q[1] <= q[0];
            q[2] <= q[1];
            q[3] <= q[2];
            q[4] <= q[3];
            q[5] <= q[4];
            q[6] <= q[5];
            q[7] <= q[6];
        end
endmodule
