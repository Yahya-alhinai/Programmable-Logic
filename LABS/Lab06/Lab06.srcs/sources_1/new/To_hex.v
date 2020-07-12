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
    output reg [6:0] Seg,
    input [2:0] LED
    );
    
    always @(*) begin
        case(LED)
            4'b001: Seg = 7'b1001111; // "1" 
            4'b010: Seg = 7'b0010010; // "2" 
            4'b011: Seg = 7'b0000110; // "3" 
            4'b100: Seg = 7'b1001100; // "4" 
            4'b101: Seg = 7'b0100100; // "5" 
            4'b110: Seg = 7'b0100000; // "6" 
           default: Seg = 7'b1001111; // "1"
        endcase
    end

endmodule
