`timescale 1ns/1ps
`default_nettype none

module practice(rst, clk, ena, seed, out);
input logic rst, clk, ena, seed;
output logic out;

logic d0, d1, d2, xor0;

always_comb xor0 = d1 ^ d2;
always_comb d0 = ena ? xor0 : seed;
logic rst_;
always_ff @(posedge clk or posedge rst) begin
        rst_ = ~rst;
        d1 <= rst_ & d0;
        d2 <= rst_ & d1;
        out <=rst_ & d2;
 end


endmodule
