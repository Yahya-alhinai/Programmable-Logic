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
    inout [5:0] Q,
    output reg [5:0] preQ,
    output reg [6:0] seg,
    output reg [3:0] AN,
    input [5:0] seed,
    input clk,
    input btnC,
    input btnR
    );
    
    parameter WIN   = 7'b1000001;
    parameter LOST  = 7'b1110001;
    parameter AGAIN = 7'b0001000;
    parameter OFF   = 7'b1111111;
    
    wire [6:0] Seg1;
    wire [6:0] Seg2;
    reg  [6:0] Seg3 = OFF;
    reg  [6:0] Seg4 = OFF;
    reg  [20:0] RefreshCounter;
    reg  [1:0] state = 0;
    reg  run = 0;
    reg  btnCE;
    reg  btnRE;
    
    clock_divider CDIV (cout, clk);
    lfsr LSFR (Q, seed, run, btnC, btnR, cout);    
    To_hex TH0 (Seg1, Q[2:0]);
    To_hex TH1 (Seg2, Q[5:3]);

    always @(posedge clk) begin
        RefreshCounter <= RefreshCounter + 1;
        btnRE <= btnR;
        btnCE <= btnC;
    end
    
    
    always @(posedge btnRE or posedge btnCE) begin
        if (btnCE) begin
            Seg4  <= OFF;
            run   <= 1;
            preQ <= 0;
            state <= 0;
            end
        else if (run) begin
            case (state)
                0: begin
                    if ((Q[2:0] + Q[5:3]) == 7 || (Q[2:0] + Q[5:3]) == 11) begin
                        Seg4  <= WIN;
                        run <= 0;                  
                        end
                    else if ((Q[2:0] + Q[5:3]) == 2 || (Q[2:0] + Q[5:3]) == 3  ||  (Q[2:0] + Q[5:3]) == 12) begin
                        Seg4  <= LOST;
                        run <= 0;
                        end
                    else begin
                        Seg4  <= AGAIN;
                        state <= 1;
                        preQ <= Q;
                        end
                    end
                1: begin
                    if ((preQ[2:0] + preQ[5:3]) == (Q[2:0] + Q[5:3])) begin
                        Seg4  <= WIN;
                        run <= 0;
                        end
                    else if ((Q[2:0] + Q[5:3]) == 7) begin
                        Seg4  <= LOST;
                        preQ <= 0;
                        run <= 0;
                    end else
                        state <= 1;
                        preQ <= Q;
                    end
            endcase
        end
    end

    
    always @(*) begin
        case (RefreshCounter[20:19])
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
