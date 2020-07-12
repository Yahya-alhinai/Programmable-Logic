`timescale 1ns / 1ps


module lab4_top(
    input [7:0] sw,
    input [2:0] state,
    output reg [7:0] seg,
    output reg [3:0] AN,
    input clk
    );
    
    parameter OFF   = 8'b11111111;
    
    reg [7:0] Seg1;
    reg [7:0] Seg2;
    reg [7:0] Seg3;
    reg [7:0] Seg4;
    
    reg [20:0] RefreshCounter;
    reg [7:0] display [0:19] = {OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF,
                                OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF, OFF};
    reg [4:0] keep = 0;
    reg digit = 0;
    reg [4:0] number = 0;
    
    reg [7:0] mem [0:3] = {8'h0,8'h1,8'h2,8'h3};
    clock_divider CDIV (cout, clk);
    
    always @(posedge clk) begin
        RefreshCounter <= RefreshCounter + 1;
    end
        
     always @(posedge clk) begin
        if (state == 3'b010) begin
            display [0] <= OFF;
            display [1] <= OFF;
            display [2] <= OFF;
            display [3] <= OFF;
            display [4] <= OFF;
            display [5] <= OFF;
            display [6] <= OFF;
            display [7] <= OFF;
            display [8] <= OFF;
            display [9] <= OFF;
            display [10] <= OFF;
            display [11] <= OFF;
            display [12] <= OFF;
            display [13] <= OFF;
            display [14] <= OFF;
            display [15] <= OFF;
            keep <= 0;
            end
        else begin
            case (digit)
            0:begin
                if (state == 3'b110) digit <= 1;
            end
            1:begin
                if (state == 3'b111)begin
                    digit <= 0;
                    display[keep] <= sw;
                    keep <= (keep >= 19)? 0 : keep + 1;
                    
                end
            end
            endcase
        end
    end
    
    reg chage = 0;
    
    always @(posedge cout) begin
        if (state != 3'b110 && state != 3'b111  && state != 3'b010) begin
            if (chage) begin
                chage <= 0;
                number <= 0;
                Seg1 <= OFF;
            end else begin
                number = (number >= keep)? 0 : number + 1;
                Seg1 <= display [number];
                Seg2 <= Seg1;
                Seg3 <= Seg2;
                Seg4 <= Seg3;
        end
        end else begin
            Seg1 <= (state != 3'b010)? sw : OFF;
            Seg2 <= OFF;
            Seg3 <= OFF;
            Seg4 <= OFF;
            chage <= 1;
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
