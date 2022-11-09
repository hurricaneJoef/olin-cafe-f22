`default_nettype none
`timescale 1ns/1ps

module register_file(
  clk, //Note - intentionally does not have a reset! 
  wr_ena, wr_addr, wr_data,
  rd_addr0, rd_data0,
  rd_addr1, rd_data1
);
// Not parametrizing, these widths are defined by the RISC-V Spec!
input wire clk;

// Write channel
input wire wr_ena;
input wire [4:0] wr_addr;
input wire [31:0] wr_data;

// Two read channels
input wire [4:0] rd_addr0, rd_addr1;
output logic [31:0] rd_data0, rd_data1;

wire [(32*32)-1:0] x;
logic [4:0] wr_addrb;
always_comb wr_addrb = ~wr_addr;

logic [31:0] x00; 
always_comb x00 = 32'd0; // ties x00 to ground. 
//always_comb x[31:0] = 32'd0; // ties x00 to ground.
// DON'T DO THIS:
// logic [31:0] register_file_registers [31:0]
// CAN'T: because that's a RAM. Works in simulation, fails miserably in synthesis.

// Hint - use a scripting language if you get tired of copying and pasting the logic 32 times - e.g. python: print(",".join(["x%02d"%i for i in range(0,32)]))
//wire [31:0] x01,x02,x03,x04,x05,x06,x07,x08,x09,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31;
logic [31:0] dout;
always_comb begin : decoder32
  dout[0]  = 0;//wr_ena & wr_addrb[4]& wr_addrb[3]& wr_addrb[2]& wr_addrb[1]& wr_addrb[0];
  dout[1]  = wr_ena & wr_addrb[4]& wr_addrb[3]& wr_addrb[2]& wr_addrb[1]& wr_addr[0];
  dout[2]  = wr_ena & wr_addrb[4]& wr_addrb[3]& wr_addrb[2]& wr_addr[1] & wr_addrb[0];
  dout[3]  = wr_ena & wr_addrb[4]& wr_addrb[3]& wr_addrb[2]& wr_addr[1] & wr_addr[0];
  dout[4]  = wr_ena & wr_addrb[4]& wr_addrb[3]& wr_addr[2] & wr_addrb[1]& wr_addrb[0];
  dout[5]  = wr_ena & wr_addrb[4]& wr_addrb[3]& wr_addr[2] & wr_addrb[1]& wr_addr[0];
  dout[6]  = wr_ena & wr_addrb[4]& wr_addrb[3]& wr_addr[2] & wr_addr[1] & wr_addrb[0];
  dout[7]  = wr_ena & wr_addrb[4]& wr_addrb[3]& wr_addr[2] & wr_addr[1] & wr_addr[0];
  dout[8]  = wr_ena & wr_addrb[4]& wr_addr[3] & wr_addrb[2]& wr_addrb[1]& wr_addrb[0];
  dout[9]  = wr_ena & wr_addrb[4]& wr_addr[3] & wr_addrb[2]& wr_addrb[1]& wr_addr[0];
  dout[10] = wr_ena & wr_addrb[4]& wr_addr[3] & wr_addrb[2]& wr_addr[1] & wr_addrb[0];
  dout[11] = wr_ena & wr_addrb[4]& wr_addr[3] & wr_addrb[2]& wr_addr[1] & wr_addr[0];
  dout[12] = wr_ena & wr_addrb[4]& wr_addr[3] & wr_addr[2] & wr_addrb[1]& wr_addrb[0];
  dout[13] = wr_ena & wr_addrb[4]& wr_addr[3] & wr_addr[2] & wr_addrb[1]& wr_addr[0];
  dout[14] = wr_ena & wr_addrb[4]& wr_addr[3] & wr_addr[2] & wr_addr[1] & wr_addrb[0];
  dout[15] = wr_ena & wr_addrb[4]& wr_addr[3] & wr_addr[2] & wr_addr[1] & wr_addr[0];
  dout[16] = wr_ena & wr_addr[4] & wr_addrb[3]& wr_addrb[2]& wr_addrb[1]& wr_addrb[0];
  dout[17] = wr_ena & wr_addr[4] & wr_addrb[3]& wr_addrb[2]& wr_addrb[1]& wr_addr[0];
  dout[18] = wr_ena & wr_addr[4] & wr_addrb[3]& wr_addrb[2]& wr_addr[1] & wr_addrb[0];
  dout[19] = wr_ena & wr_addr[4] & wr_addrb[3]& wr_addrb[2]& wr_addr[1] & wr_addr[0];
  dout[20] = wr_ena & wr_addr[4] & wr_addrb[3]& wr_addr[2] & wr_addrb[1]& wr_addrb[0];
  dout[21] = wr_ena & wr_addr[4] & wr_addrb[3]& wr_addr[2] & wr_addrb[1]& wr_addr[0];
  dout[22] = wr_ena & wr_addr[4] & wr_addrb[3]& wr_addr[2] & wr_addr[1] & wr_addrb[0];
  dout[23] = wr_ena & wr_addr[4] & wr_addrb[3]& wr_addr[2] & wr_addr[1] & wr_addr[0];
  dout[24] = wr_ena & wr_addr[4] & wr_addr[3] & wr_addrb[2]& wr_addrb[1]& wr_addrb[0];
  dout[25] = wr_ena & wr_addr[4] & wr_addr[3] & wr_addrb[2]& wr_addrb[1]& wr_addr[0];
  dout[26] = wr_ena & wr_addr[4] & wr_addr[3] & wr_addrb[2]& wr_addr[1] & wr_addrb[0];
  dout[27] = wr_ena & wr_addr[4] & wr_addr[3] & wr_addrb[2]& wr_addr[1] & wr_addr[0];
  dout[28] = wr_ena & wr_addr[4] & wr_addr[3] & wr_addr[2] & wr_addrb[1]& wr_addrb[0];
  dout[29] = wr_ena & wr_addr[4] & wr_addr[3] & wr_addr[2] & wr_addrb[1]& wr_addr[0];
  dout[30] = wr_ena & wr_addr[4] & wr_addr[3] & wr_addr[2] & wr_addr[1] & wr_addrb[0];
  dout[31] = wr_ena & wr_addr[4] & wr_addr[3] & wr_addr[2] & wr_addr[1] & wr_addr[0];
end


generate 
  genvar i;
  for(i=1;i<32;i++) begin : make_write
    register #(.N(32)) REG(clk, dout[i], 1'd0,//that is rst
               wr_data, x[(31+32*i):(32*i)]);
  end
endgenerate

// make_read0
  mux32 #(.N(32)) read0mux( x00, x[63:32], x[95:64], x[127:96], x[159:128],
                            x[191:160], x[223:192], x[255:224], x[287:256], x[319:288],
                            x[351:320], x[383:352], x[415:384], x[447:416], x[479:448],
                            x[511:480], x[543:512], x[575:544], x[607:576], x[639:608],
                            x[671:640], x[703:672], x[735:704], x[767:736], x[799:768],
                            x[831:800], x[863:832], x[895:864], x[927:896], x[959:928],
                            x[991:960], x[1023:992],rd_addr0,rd_data0);
//end

// make_read1
  mux32 #(.N(32)) read1mux( x00, x[63:32], x[95:64], x[127:96], x[159:128],
                            x[191:160], x[223:192], x[255:224], x[287:256], x[319:288],
                            x[351:320], x[383:352], x[415:384], x[447:416], x[479:448],
                            x[511:480], x[543:512], x[575:544], x[607:576], x[639:608],
                            x[671:640], x[703:672], x[735:704], x[767:736], x[799:768],
                            x[831:800], x[863:832], x[895:864], x[927:896], x[959:928],
                            x[991:960], x[1023:992],rd_addr1,rd_data1);
//end

endmodule