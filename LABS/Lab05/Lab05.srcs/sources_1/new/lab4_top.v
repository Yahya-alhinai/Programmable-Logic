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
    input btnC,
    input btnR
    );
        
    wire [6:0] Seg1;
    wire [6:0] Seg2;
    reg [6:0] Seg3 = 7'b1111111;
    reg [6:0] Seg4 = 7'b1111111;
    reg [20:0] refresh_counter;
    reg btnCE;
    reg btnRE;
        
    clock_divider CDIV (cout, clk);
    lfsr LSFR (q, seed, btnC, cout);
    To_hex TH0 (Seg1, q[3:0]);
    To_hex TH1 (Seg2, q [7:4]);

    always @(posedge clk) begin
        refresh_counter <= refresh_counter + 1;
        btnRE <= btnR;
        btnCE <= btnC;
    end
        
    always @(posedge btnRE or posedge btnCE) begin
        if (btnCE) begin
            Seg3 <= 7'b1111111;
            Seg4 <= 7'b1111111;
        end
        else if (q [3:0]== q [7:4]) begin
            Seg3 <= 7'b1111001;
            Seg4 <= 7'b1000001;
        end
        else begin
            Seg3 <= 7'b0000001;
            Seg4 <= 7'b1110001;
        end
    end
    
    always @(*) begin
        case (refresh_counter[20:19])
            2'b00: begin
                AN  <= 4'b1110;
                seg <= Seg1;
            end
            2'b01: begin
                AN  <= 4'b1101;
                seg <= Seg2;
            end
            2'b10: begin
                AN  <= 4'b1011;
                seg <= Seg3;
            end
            2'b11: begin
                AN  <= 4'b0111;
                seg <= Seg4;
            end
        endcase
    end        
 
endmodule
