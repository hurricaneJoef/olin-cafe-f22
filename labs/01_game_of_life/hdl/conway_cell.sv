`default_nettype none
`timescale 1ns/1ps

module conway_cell(clk, rst, ena, state_0, state_d, state_q, neighbors);
    input wire clk;
    input wire rst;
    input wire ena;

    input wire state_0;
    output logic state_d; // NOTE - this is only an output of the module for debugging purposes. 
    output logic state_q;

    input wire [7:0] neighbors;
    logic [2:0] neighbor_sum;
    logic c;

    sum_8 sum8(neighbors,neighbor_sum,c);

    always_comb state_d = (~neighbor_sum[2] & neighbor_sum[1] & (neighbor_sum[0] | state_q));

    logic internal_clk;

    always_comb internal_clk = (clk & ena) | rst;

    always_ff @(posedge internal_clk) begin
        state_q <= ((state_d & (~rst) | (state_0 & rst)));//| (ena & state_q);
    end

endmodule