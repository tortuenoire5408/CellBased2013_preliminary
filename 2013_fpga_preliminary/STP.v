module STP(fir_valid, fir_d, clk, rst, o0, o1, o2, o3, o4, o5,
            o6, o7, o8, o9, ,o10 , o11, o12, o13, o14, o15);
input clk, rst;
input fir_valid;
input [15:0] fir_d;

output [15:0] o0, o1, o2, o3, o4, o5, o6, o7, o8, o9, o10, o11, o12, o13, o14, o15;
//---------------------------------------------------------------------------------
reg [15:0] o0, o1, o2, o3, o4, o5, o6, o7, o8, o9, o10, o11, o12, o13, o14, o15;
reg [3:0] k;

reg [15:0] stp_mem [15:0];
//---------------------------------------------------------------------------------
always@(*) begin
    if(rst) begin
        k = 0;
        o0 = 0; o1 = 0; o2 = 0; o3 = 0; o4 = 0; o5 = 0; o6 = 0; o7 = 0;
        o8 = 0; o9 = 0; o10 = 0; o11 = 0; o12 = 0; o13 = 0; o14 = 0; o15 = 0;
    end else begin
        if(fir_valid) begin
            stp_mem[k] = fir_d;

            if(k == 15) begin
                o0 = stp_mem[0];
                o1 = stp_mem[1];
                o2 = stp_mem[2];
                o3 = stp_mem[3];
                o4 = stp_mem[4];
                o5 = stp_mem[5];
                o6 = stp_mem[6];
                o7 = stp_mem[7];
                o8 = stp_mem[8];
                o9 = stp_mem[9];
                o10 = stp_mem[10];
                o11 = stp_mem[11];
                o12 = stp_mem[12];
                o13 = stp_mem[13];
                o14 = stp_mem[14];
                o15 = stp_mem[15];
            end

            k = (!clk) ? k + 1 : k;
        end

    end
end


//---------------------------------------------------------------------------------
endmodule
//---------------------------------------------------------------------------------