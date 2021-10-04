module AC(clk, rst, fft_valid, done, freq,
            fft_d0, fft_d1, fft_d2, fft_d3, fft_d4, fft_d5, fft_d6, fft_d7,
            fft_d8, fft_d9, fft_d10, fft_d11, fft_d12, fft_d13, fft_d14, fft_d15);
input clk, rst, fft_valid;
input [31:0] fft_d0, fft_d1, fft_d2, fft_d3, fft_d4, fft_d5, fft_d6, fft_d7,
             fft_d8, fft_d9, fft_d10, fft_d11, fft_d12, fft_d13, fft_d14, fft_d15;
output done;
output [3:0] freq;
//---------------------------------------------------------------------------------
reg done;
reg [3:0] freq;
reg [4:0] i;
reg [6:0] count;

reg [32:0] dist [15:0];
reg [24:0] max;
//---------------------------------------------------------------------------------
always@(posedge clk or posedge rst) begin
    if(rst) begin
        done = 0; freq = 0; max = 0; count = 0;
    end else begin
        if(done) done = 0;
        if(fft_valid) begin
            max = 0; freq = 0;

            dist[0] = {{16{fft_d0[31]}},  fft_d0[31:16]} * {{16{fft_d0[31]}},  fft_d0[31:16]}
                        + {{16{fft_d0[15]}},  fft_d0[15:0]} * {{16{fft_d0[15]}},  fft_d0[15:0]};
            dist[1] = {{16{fft_d1[31]}},  fft_d1[31:16]} * {{16{fft_d1[31]}},  fft_d1[31:16]}
                        + {{16{fft_d1[15]}},  fft_d1[15:0]} * {{16{fft_d1[15]}},  fft_d1[15:0]};
            dist[2] = {{16{fft_d2[31]}},  fft_d2[31:16]} * {{16{fft_d2[31]}},  fft_d2[31:16]}
                        + {{16{fft_d2[15]}},  fft_d2[15:0]} * {{16{fft_d2[15]}},  fft_d2[15:0]};
            dist[3] = {{16{fft_d3[31]}},  fft_d3[31:16]} * {{16{fft_d3[31]}},  fft_d3[31:16]}
                        + {{16{fft_d3[15]}},  fft_d3[15:0]} * {{16{fft_d3[15]}},  fft_d3[15:0]};
            dist[4] = {{16{fft_d4[31]}},  fft_d4[31:16]} * {{16{fft_d4[31]}},  fft_d4[31:16]}
                        + {{16{fft_d4[15]}},  fft_d4[15:0]} * {{16{fft_d4[15]}},  fft_d4[15:0]};
            dist[5] = {{16{fft_d5[31]}},  fft_d5[31:16]} * {{16{fft_d5[31]}},  fft_d5[31:16]}
                        + {{16{fft_d5[15]}},  fft_d5[15:0]} * {{16{fft_d5[15]}},  fft_d5[15:0]};
            dist[6] = {{16{fft_d6[31]}},  fft_d6[31:16]} * {{16{fft_d6[31]}},  fft_d6[31:16]}
                        + {{16{fft_d6[15]}},  fft_d6[15:0]} * {{16{fft_d6[15]}},  fft_d6[15:0]};
            dist[7] = {{16{fft_d7[31]}},  fft_d7[31:16]} * {{16{fft_d7[31]}},  fft_d7[31:16]}
                        + {{16{fft_d7[15]}},  fft_d7[15:0]} * {{16{fft_d7[15]}},  fft_d7[15:0]};
            dist[8] = {{16{fft_d8[31]}},  fft_d8[31:16]} * {{16{fft_d8[31]}},  fft_d8[31:16]}
                        + {{16{fft_d8[15]}},  fft_d8[15:0]} * {{16{fft_d8[15]}},  fft_d8[15:0]};
            dist[9] = {{16{fft_d9[31]}},  fft_d9[31:16]} * {{16{fft_d9[31]}},  fft_d9[31:16]}
                        + {{16{fft_d9[15]}},  fft_d9[15:0]} * {{16{fft_d9[15]}},  fft_d9[15:0]};
            dist[10] = {{16{fft_d10[31]}},  fft_d10[31:16]} * {{16{fft_d10[31]}},  fft_d10[31:16]}
                        + {{16{fft_d10[15]}},  fft_d10[15:0]} * {{16{fft_d10[15]}},  fft_d10[15:0]};
            dist[11] = {{16{fft_d11[31]}},  fft_d11[31:16]} * {{16{fft_d11[31]}},  fft_d11[31:16]}
                        + {{16{fft_d11[15]}},  fft_d11[15:0]} * {{16{fft_d11[15]}},  fft_d11[15:0]};
            dist[12] = {{16{fft_d12[31]}},  fft_d12[31:16]} * {{16{fft_d12[31]}},  fft_d12[31:16]}
                        + {{16{fft_d12[15]}},  fft_d12[15:0]} * {{16{fft_d12[15]}},  fft_d12[15:0]};
            dist[13] = {{16{fft_d13[31]}},  fft_d13[31:16]} * {{16{fft_d13[31]}},  fft_d13[31:16]}
                        + {{16{fft_d13[15]}},  fft_d13[15:0]} * {{16{fft_d13[15]}},  fft_d13[15:0]};
            dist[14] = {{16{fft_d14[31]}},  fft_d14[31:16]} * {{16{fft_d14[31]}},  fft_d14[31:16]}
                        + {{16{fft_d14[15]}},  fft_d14[15:0]} * {{16{fft_d14[15]}},  fft_d14[15:0]};
            dist[15] = {{16{fft_d15[31]}},  fft_d15[31:16]} * {{16{fft_d15[31]}},  fft_d15[31:16]}
                        + {{16{fft_d15[15]}},  fft_d15[15:0]} * {{16{fft_d15[15]}},  fft_d15[15:0]};

            for(i = 0; i <= 15; i = i + 1) begin
                if(max < dist[i]) begin
                    max = dist[i];
                    freq = i;
                end else begin
                    max = max;
                    freq = freq;
                end
                if(i == 15) begin
                    done = 1;
                end
            end
            if(done) count = count + 1;
            if(count >= 64) begin
                done = 0;
                count = 64;
            end
        end
    end
end
//---------------------------------------------------------------------------------
endmodule
