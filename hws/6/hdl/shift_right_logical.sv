`timescale 1ns/1ps
`default_nettype none
module shift_right_logical(in,shamt,out);
parameter N = 32; // only used as a constant! Don't feel like you need to a shifter for arbitrary N.

//port definitions
input  wire [N-1:0] in;    // A 32 bit input
input  wire [$clog2(N)-1:0] shamt; // Amount we shift by.
output wire [N-1:0] out;  // Output.
    mux32 #(.N(N)) mux1(
        in[31:0],{1'd0,in[31:1]},{2'd0,in[31:2]},{3'd0,in[31:3]},{4'd0,in[31:4]},{5'd0,in[31:5]},
        {6'd0,in[31:6]},{7'd0,in[31:7]},{8'd0,in[31:8]},{9'd0,in[31:9]},{10'd0,in[31:10]},
        {11'd0,in[31:11]},{12'd0,in[31:12]},{13'd0,in[31:13]},{14'd0,in[31:14]},{15'd0,in[31:15]},
        {16'd0,in[31:16]},{17'd0,in[31:17]},{18'd0,in[31:18]},{19'd0,in[31:19]},{20'd0,in[31:20]},
        {21'd0,in[31:21]},{22'd0,in[31:22]},{23'd0,in[31:23]},{24'd0,in[31:24]},{25'd0,in[31:25]},
        {26'd0,in[31:26]},{27'd0,in[31:27]},{28'd0,in[31:28]},{29'd0,in[31:29]},{30'd0,in[31:30]},
        {31'd0,in[31]},shamt,out);

endmodule
