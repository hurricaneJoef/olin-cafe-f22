`timescale 1ns/1ps
`default_nettype none
module shift_left_logical(in, shamt, out);

parameter N = 32; // only used as a constant! Don't feel like you need to a shifter for arbitrary N.

input wire [N-1:0] in;            // the input number that will be shifted left. Fill in the remainder with zeros.
input wire [$clog2(N)-1:0] shamt; // the amount to shift by (think of it as a decimal number from 0 to 31). 
output logic [N-1:0] out;       


    mux32 #(.N(N)) mux(in[31:0],{in[31:1],1'd0},{in[31:2],2'd0},{in[31:3],3'd0},{in[31:4],4'd0},
        {in[31:5],5'd0},{in[31:6],6'd0},{in[31:7],7'd0},{in[31:8],8'd0},{in[31:9],9'd0},{in[31:10],10'd0},
        {in[31:11],11'd0},{in[31:12],12'd0},{in[31:13],13'd0},{in[31:14],14'd0},{in[31:15],15'd0},
        {in[31:16],16'd0},{in[31:17],17'd0},{in[31:18],18'd0},{in[31:19],19'd0},{in[31:20],20'd0},
        {in[31:21],21'd0},{in[31:22],22'd0},{in[31:23],23'd0},{in[31:24],24'd0},{in[31:25],25'd0},
        {in[31:26],26'd0},{in[31:27],27'd0},{in[31:28],28'd0},{in[31:29],29'd0},{in[31:30],30'd0},
        {in[31],31'd0},shamt,out);
    


endmodule
