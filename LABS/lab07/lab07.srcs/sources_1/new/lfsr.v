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
    output [5:0] Qout,
    input  [5:0] seed,
    input run,
    input btnC,
    input btnR,
    input clock
    );
    
    wire din;
    reg [5:0]Q;
    
    assign Qout [2:0] = Q[2:0] == 7? 6 : Q[2:0] == 0? 1 : Q[2:0];
    assign Qout [5:3] = Q[5:3] == 7? 6 : Q[5:3] == 0? 1 : Q[5:3];
   
    assign din = Q[1] ^ Q[2] ^ Q[3];
    
    always @(posedge clock)
        if (btnC) begin
            Q <= seed;
        end
        else if (~btnR && run) begin
            Q[0] <= din;
            Q[1] <= Q[0] ^ din;
            Q[2] <= Q[1] ^ din;
            Q[3] <= Q[2] ^ din;
            Q[4] <= Q[3] ^ din;
            Q[5] <= Q[4] ^ din;
        end
endmodule
