

module CORDIC(
    input clk, 
    input [15:0] angle,
    input btnR,
    input btnC,
    output reg [6:0] seg,
    output reg [3:0] AN
    );
    
    integer i = 0;
  
    parameter OFF = 7'b1111111;
    reg [15:0] cos;
    reg [15:0] sin;

    reg [20:0] refresh_counter;

    wire [6:0] Seg1;
    wire [6:0] Seg2;
    wire [6:0] Seg3;
    wire [6:0] Seg4;
    
    wire [6:0] Seg5;
    wire [6:0] Seg6;
    wire [6:0] Seg7;
    wire [6:0] Seg8;
    
    reg signed [16:0] x [0:15];
    reg signed [16:0] y [0:15];
    reg signed [16:0] z [0:15];
    
    To_hex TH0 (Seg1, sin[3:0]);
    To_hex TH1 (Seg2, sin[7:4]);
    To_hex TH2 (Seg3, sin[11:8]);
    To_hex TH3 (Seg4, sin[15:12]);

    To_hex TH4 (Seg5, cos[3:0]);
    To_hex TH5 (Seg6, cos[7:4]);
    To_hex TH6 (Seg7, cos[11:8]);
    To_hex TH7 (Seg8, cos[15:12]);

    always @(posedge clk) refresh_counter <= refresh_counter + 1;
        
    reg signed [15:0] tan_rom [0:15];
                          
    initial begin
        tan_rom[0]  <= 16'b0011001001000011;
        tan_rom[1]  <= 16'b0001110110101100;
        tan_rom[2]  <= 16'b0000111110101101;
        tan_rom[3]  <= 16'b0000011111110101;
        tan_rom[4]  <= 16'b0000001111111110;
        tan_rom[5]  <= 16'b0000000111111111;
        tan_rom[6]  <= 16'b0000000011111111;
        tan_rom[7]  <= 16'b0000000001111111;
        tan_rom[8]  <= 16'b0000000000111111;
        tan_rom[9]  <= 16'b0000000000011111;
        tan_rom[10] <= 16'b0000000000001111;
        tan_rom[11] <= 16'b0000000000000111;
        tan_rom[12] <= 16'b0000000000000011;
        tan_rom[13] <= 16'b0000000000000001;
        tan_rom[14] <= 16'b0000000000000000;
        tan_rom[15] <= 16'b0000000000000000;
    end

    always @(posedge clk)
    begin
        cos <= (i == 16) ? x[15] : 0;
        sin <= (i == 16) ? y[15] : 0;
        if (btnC) begin
            x[0] <= 16'h25dd; // 0.607253 * 2^14
            y[0] <= 0;
            z[0] <= angle;
            i <= 0;
        end
        else if (i < 16)
        begin
            x[i+1] <= z[i][15] ? x[i] + (y[i] >>> i) : x[i] - (y[i] >>> i);
            y[i+1] <= z[i][15] ? y[i] - (x[i] >>> i) : y[i] + (x[i] >>> i);
            z[i+1] <= z[i][15] ? z[i] + tan_rom[i] : z[i] - tan_rom[i];
            i = i + 1;
        end
    end
      
always @(*) begin
    case (refresh_counter[20:19])
        2'b00: begin
            AN  <= 4'b1110;
            seg <= btnR ? Seg5 : Seg1;
        end
        2'b01: begin
            AN  <= 4'b1101;
            seg <= btnR ? Seg6 : Seg2;
        end
        2'b10: begin
            AN  <= 4'b1011;
            seg <= btnR ? Seg7 : Seg3;
        end
        2'b11: begin
            AN  <= 4'b0111;
            seg <= btnR ? Seg8 : Seg4;
        end
    endcase
end        

endmodule