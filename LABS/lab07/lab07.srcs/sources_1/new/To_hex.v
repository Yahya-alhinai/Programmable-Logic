`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2018 01:12:55 PM
// Design Name: 
// Module Name: To_hex
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


module To_hex(
    output [7:0] Seg,
    input [7:0] sw
    );
    
    assign Seg = sw;


endmodule
