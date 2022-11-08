`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_mux32;

  parameter N = 8;
  logic [4:0] s;
  logic [(N-1):0] in00, in01, in02, in03, in04, in05, in06, in07, in08, 
    in09, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19, in20, 
    in21, in22, in23, in24, in25, in26, in27, in28, in29, in30, in31;
  wire [(N-1):0] out;
  mux32 #(.N(N)) UUT(in00, in01, in02, in03, in04, in05, in06, in07, in08, 
    in09, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19, in20, 
    in21, in22, in23, in24, in25, in26, in27, in28, in29, in30, in31,s,out);
// copied from 3 to 8 mux
  initial begin // In standard programming land (line by line execution)
    // Collect waveforms
    $dumpfile("mux32.fst");
    $dumpvars(0, UUT);
    in00 = 8'd01;
    in01 = 8'd02;
    in02 = 8'd03;
    in03 = 8'd04;
    in04 = 8'd05;
    in05 = 8'd06;
    in06 = 8'd07;
    in07 = 8'd08;
    in08 = 8'd09;
    in09 = 8'd10;
    in10 = 8'd11;
    in11 = 8'd12;
    in12 = 8'd13;
    in13 = 8'd14;
    in14 = 8'd15;
    in15 = 8'd16;
    in16 = 8'd17;
    in17 = 8'd18;
    in18 = 8'd19;
    in19 = 8'd20;
    in20 = 8'd21;
    in21 = 8'd22;
    in22 = 8'd23;
    in23 = 8'd24;
    in24 = 8'd25;
    in25 = 8'd26;
    in26 = 8'd27;
    in27 = 8'd28;
    in28 = 8'd29;
    in29 = 8'd30;
    in30 = 8'd31;
    in31 = 8'd32;

    $display("  s    | out");
    for (int i = 0; i < 32; i = i + 1) begin
      s = i[4:0];
      #10 $display(" %5b | %8b", s, out);
    end

    $finish;
	end

endmodule