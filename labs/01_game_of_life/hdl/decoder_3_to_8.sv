`timescale 1ns/1ps
module decoder_3_to_8(ena, in, out);

  input wire ena;
  input wire [2:0] in;
  output logic [7:0] out;

  // VVVVVVV   enable cascade version VVVVVVVV
  //wire [1:0] ena_cascade;
  //decoder_1_to_2 d0  (.in(in[2]),.ena(ena),.out(ena_cascade));
  //decoder_2_to_4 d1a (.in(in[1:0]),.ena(ena_cascade[0]),.out(out[3:0]));
  //decoder_2_to_4 d1b (.in(in[1:0]),.ena(ena_cascade[1]),.out(out[7:4]));
  logic [2:0] inb;
  always_comb begin
    inb = ~in;
    out[0] = ena & inb[2]& inb[1]& inb[0];
    out[1] = ena & inb[2]& inb[1]&  in[0];
    out[2] = ena & inb[2]&  in[1]& inb[0];
    out[3] = ena & inb[2]&  in[1]&  in[0];
    out[4] = ena &  in[2]& inb[1]& inb[0];
    out[5] = ena &  in[2]& inb[1]&  in[0];
    out[6] = ena &  in[2]&  in[1]& inb[0];
    out[7] = ena &  in[2]&  in[1]&  in[0];

  end
endmodule