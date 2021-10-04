module FIR(data_valid, data, clk, rst, fir_valid, fir_d);
input clk, rst;
input data_valid;
input [15:0] data;

output fir_valid;
output [15:0] fir_d;
//---------------------------------------------------------------------------------
reg fir_valid;
reg [5:0]  j;
reg [10:0] i;
reg [15:0] fir_d;

reg [15:0] fir_mem [31:0];
reg [35:0] multiply ;
`include "./dat/FIR_coefficient.dat"
//---------------------------------------------------------------------------------
always@(posedge clk or posedge rst) begin
    if(rst) begin
        fir_valid = 0;
        fir_d = 0;
        i = 0;
        multiply = 0;
    end else begin
        for(j = 0; j < 31; j = j +1) begin
            fir_mem[j] = fir_mem[j + 1];
        end

        fir_mem[31] = data;

        if(i >= 1055) fir_valid = 0;
        else if(i >= 32) begin
            fir_valid = 1;
            multiply = 0;
            multiply = {{20{fir_mem[0][15]}}, fir_mem[0]} * {{16{FIR_C31[19]}}, FIR_C31} + {{20{fir_mem[1][15]}}, fir_mem[1]} * {{16{FIR_C30[19]}}, FIR_C30} + {{20{fir_mem[2][15]}}, fir_mem[2]} * {{16{FIR_C29[19]}}, FIR_C29} +
                        {{20{fir_mem[3][15]}}, fir_mem[3]} * {{16{FIR_C28[19]}}, FIR_C28} + {{20{fir_mem[4][15]}}, fir_mem[4]} * {{16{FIR_C27[19]}}, FIR_C27} + {{20{fir_mem[5][15]}}, fir_mem[5]} * {{16{FIR_C26[19]}}, FIR_C26} +
                        {{20{fir_mem[6][15]}}, fir_mem[6]} * {{16{FIR_C25[19]}}, FIR_C25} + {{20{fir_mem[7][15]}}, fir_mem[7]} * {{16{FIR_C24[19]}}, FIR_C24} + {{20{fir_mem[8][15]}}, fir_mem[8]} * {{16{FIR_C23[19]}}, FIR_C23} +
                        {{20{fir_mem[9][15]}}, fir_mem[9]} * {{16{FIR_C22[19]}}, FIR_C22} + {{20{fir_mem[10][15]}}, fir_mem[10]} * {{16{FIR_C21[19]}}, FIR_C21} + {{20{fir_mem[11][15]}}, fir_mem[11]} * {{16{FIR_C20[19]}}, FIR_C20} +
                        {{20{fir_mem[12][15]}}, fir_mem[12]} * {{16{FIR_C19[19]}}, FIR_C19} + {{20{fir_mem[13][15]}}, fir_mem[13]} * {{16{FIR_C18[19]}}, FIR_C18} + {{20{fir_mem[14][15]}}, fir_mem[14]} * {{16{FIR_C17[19]}}, FIR_C17} +
                        {{20{fir_mem[15][15]}}, fir_mem[15]} * {{16{FIR_C16[19]}}, FIR_C16} + {{20{fir_mem[16][15]}}, fir_mem[16]} * {{16{FIR_C15[19]}}, FIR_C15} + {{20{fir_mem[17][15]}}, fir_mem[17]} * {{16{FIR_C14[19]}}, FIR_C14} +
                        {{20{fir_mem[18][15]}}, fir_mem[18]} * {{16{FIR_C13[19]}}, FIR_C13} + {{20{fir_mem[19][15]}}, fir_mem[19]} * {{16{FIR_C12[19]}}, FIR_C12} + {{20{fir_mem[20][15]}}, fir_mem[20]} * {{16{FIR_C11[19]}}, FIR_C11} +
                        {{20{fir_mem[21][15]}}, fir_mem[21]} * {{16{FIR_C10[19]}}, FIR_C10} + {{20{fir_mem[22][15]}}, fir_mem[22]} * {{16{FIR_C09[19]}}, FIR_C09} + {{20{fir_mem[23][15]}}, fir_mem[23]} * {{16{FIR_C08[19]}}, FIR_C08} +
                        {{20{fir_mem[24][15]}}, fir_mem[24]} * {{16{FIR_C07[19]}}, FIR_C07} + {{20{fir_mem[25][15]}}, fir_mem[25]} * {{16{FIR_C06[19]}}, FIR_C06} + {{20{fir_mem[26][15]}}, fir_mem[26]} * {{16{FIR_C05[19]}}, FIR_C05} +
                        {{20{fir_mem[27][15]}}, fir_mem[27]} * {{16{FIR_C04[19]}}, FIR_C04} + {{20{fir_mem[28][15]}}, fir_mem[28]} * {{16{FIR_C03[19]}}, FIR_C03} + {{20{fir_mem[29][15]}}, fir_mem[29]} * {{16{FIR_C02[19]}}, FIR_C02} +
                        {{20{fir_mem[30][15]}}, fir_mem[30]} * {{16{FIR_C01[19]}}, FIR_C01} + {{20{fir_mem[31][15]}}, fir_mem[31]} * {{16{FIR_C00[19]}}, FIR_C00};
            fir_d = (multiply[31]) ? multiply[31:16] + 1 : multiply[31:16];
        end
        i = i + 1;
    end
end
//---------------------------------------------------------------------------------
endmodule