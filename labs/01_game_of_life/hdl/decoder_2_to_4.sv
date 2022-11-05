`timescale 1ns/1ps
module decoder_2_to_4(ena, in, out);

input wire ena;
input wire [1:0] in;
output logic [3:0] out;

wire [1:0]ena_cascade;
decoder_1_to_2 d0  (.in(in[1]), .ena(ena), .out(ena_cascade));
decoder_1_to_2 d1a (.in(in[0]), .ena(ena_cascade[0]), .out(out[1:0]));
decoder_1_to_2 d1b (.in(in[0]), .ena(ena_cascade[1]), .out(out[3:2]));


endmodule   