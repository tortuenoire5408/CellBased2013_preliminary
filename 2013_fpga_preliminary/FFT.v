module FFT(fir_valid, fir_d, fft_valid, clk, rst,
           fft_d0, fft_d1, fft_d2, fft_d3, fft_d4, fft_d5, fft_d6, fft_d7,
           fft_d8, fft_d9, fft_d10, fft_d11, fft_d12, fft_d13, fft_d14, fft_d15);
input clk, rst;
input fir_valid;
input [15:0] fir_d;
output fft_valid;
output [31:0] fft_d0, fft_d1, fft_d2, fft_d3, fft_d4, fft_d5, fft_d6, fft_d7,
               fft_d8, fft_d9, fft_d10, fft_d11, fft_d12, fft_d13, fft_d14, fft_d15;
//---------------------------------------------------------------------------------
wire [15:0] o0, o1, o2, o3, o4, o5, o6, o7, o8, o9, o10, o11, o12, o13, o14, o15;
wire [63:0] p0, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15;
wire [63:0] q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15;
wire [63:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
wire valid_0, valid_1, valid_2, valid_3, valid_4, valid_5, valid_6, valid_7;
//---------------------------------------------------------------------------------
STP s0(.fir_valid(fir_valid), .fir_d(fir_d), .clk(clk), .rst(rst),
       .o0(o0), .o1(o1), .o2(o2), .o3(o3), .o4(o4), .o5(o5), .o6(o6), .o7(o7),
       .o8(o8), .o9(o9), .o10(o10), .o11(o11), .o12(o12), .o13(o13), .o14(o14), .o15(o15));
//---------------------------------------------------------------------------------
FFT16 f16_0(.clk(clk), .rst(rst), .i0(o0), .i1(o1), .i2(o2), .i3(o3), .i4(o4),
         .i5(o5), .i6(o6), .i7(o7), .i8(o8), .i9(o9), .i10(o10), .i11(o11),
         .i12(o12), .i13(o13), .i14(o14), .i15(o15),
         .o0(p0), .o1(p1), .o2(p2), .o3(p3), .o4(p4), .o5(p5), .o6(p6), .o7(p7), .o8(p8),
         .o9(p9), .o10(p10), .o11(p11), .o12(p12), .o13(p13), .o14(p14), .o15(p15));
//---------------------------------------------------------------------------------
FFT8 f8_0(.clk(clk), .rst(rst), .i0(p0), .i1(p1), .i2(p2), .i3(p3), .i4(p4), .i5(p5), .i6(p6), .i7(p7),
        .o0(q0), .o1(q1), .o2(q2), .o3(q3), .o4(q4), .o5(q5), .o6(q6), .o7(q7));

FFT8 f8_1(.clk(clk), .rst(rst), .i0(p8), .i1(p9), .i2(p10), .i3(p11), .i4(p12), .i5(p13), .i6(p14), .i7(p15),
        .o0(q8), .o1(q9), .o2(q10), .o3(q11), .o4(q12), .o5(q13), .o6(q14), .o7(q15));
//---------------------------------------------------------------------------------
FFT4 f4_0(.clk(clk), .rst(rst),
        .i0(q0), .i1(q1), .i2(q2), .i3(q3),
        .o0(r0), .o1(r1), .o2(r2), .o3(r3));

FFT4 f4_1(.clk(clk), .rst(rst),
        .i0(q4), .i1(q5), .i2(q6), .i3(q7),
        .o0(r4), .o1(r5), .o2(r6), .o3(r7));

FFT4 f4_2(.clk(clk), .rst(rst),
        .i0(q8), .i1(q9), .i2(q10), .i3(q11),
        .o0(r8), .o1(r9), .o2(r10), .o3(r11));

FFT4 f4_3(.clk(clk), .rst(rst),
        .i0(q12), .i1(q13), .i2(q14), .i3(q15),
        .o0(r12), .o1(r13), .o2(r14), .o3(r15));
//---------------------------------------------------------------------------------
FFT2 f2_0(.clk(clk), .rst(rst), .valid(valid_0), .i0(r0), .i1(r1), .o0(fft_d0), .o1(fft_d8));

FFT2 f2_1(.clk(clk), .rst(rst), .valid(valid_1), .i0(r2), .i1(r3), .o0(fft_d4), .o1(fft_d12));

FFT2 f2_2(.clk(clk), .rst(rst), .valid(valid_2), .i0(r4), .i1(r5), .o0(fft_d2), .o1(fft_d10));

FFT2 f2_3(.clk(clk), .rst(rst), .valid(valid_3), .i0(r6), .i1(r7), .o0(fft_d6), .o1(fft_d14));

FFT2 f2_4(.clk(clk), .rst(rst), .valid(valid_4), .i0(r8), .i1(r9), .o0(fft_d1), .o1(fft_d9));

FFT2 f2_5(.clk(clk), .rst(rst), .valid(valid_5), .i0(r10), .i1(r11), .o0(fft_d5), .o1(fft_d13));

FFT2 f2_6(.clk(clk), .rst(rst), .valid(valid_6), .i0(r12), .i1(r13), .o0(fft_d3), .o1(fft_d11));

FFT2 f2_7(.clk(clk), .rst(rst), .valid(valid_7), .i0(r14), .i1(r15), .o0(fft_d7), .o1(fft_d15));
//---------------------------------------------------------------------------------
assign fft_valid = valid_0 && valid_1 && valid_2 && valid_3 && valid_4 && valid_5 && valid_6 && valid_7;
//---------------------------------------------------------------------------------
endmodule
//---------------------------------------------------------------------------------