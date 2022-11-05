	
`timescale 1ns/1ps
`default_nettype none
/*
  Making 32 different inputs is annoying, so I use python:
  print(", ".join([f"in{i:02}" for i in range(32)]))
  The solutions will include comments for where I use python-generated HDL.
*/

module mux32(in00, in01, in02, in03, in04, in05, in06, in07, in08, 
    in09, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19, in20, 
    in21, in22, in23, in24, in25, in26, in27, in28, in29, in30, in31,select,out);
	//parameter definitions
	parameter N = 1; // took me a bit to see wtf was going on still half understand why you did this
	//port definitions
  // python: print(", ".join([f"in{i:02}" for i in range(32)]))
	input  wire [(N-1):0] in00, in01, in02, in03, in04, in05, in06, in07, in08, 
    in09, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19, in20, 
    in21, in22, in23, in24, in25, in26, in27, in28, in29, in30, in31;
	input  wire [4:0] select;
	output logic [(N-1):0] out;
  
  logic [4:0] select_b;

  always_comb begin
    select_b[4:0] = ~select[4:0];
    out = 
    ({N{select_b[4] & select_b[3] & select_b[2] & select_b[1] & select_b[0]}} & in00) | 
    ({N{select_b[4] & select_b[3] & select_b[2] & select_b[1] & select[0]  }} & in01) | 
    ({N{select_b[4] & select_b[3] & select_b[2] & select[1]   & select_b[0]}} & in02) | 
    ({N{select_b[4] & select_b[3] & select_b[2] & select[1]   & select[0]  }} & in03) | 
    ({N{select_b[4] & select_b[3] & select[2]   & select_b[1] & select_b[0]}} & in04) | 
    ({N{select_b[4] & select_b[3] & select[2]   & select_b[1] & select[0]  }} & in05) | 
    ({N{select_b[4] & select_b[3] & select[2]   & select[1]   & select_b[0]}} & in06) | 
    ({N{select_b[4] & select_b[3] & select[2]   & select[1]   & select[0]  }} & in07) | 
    ({N{select_b[4] & select[3]   & select_b[2] & select_b[1] & select_b[0]}} & in08) | 
    ({N{select_b[4] & select[3]   & select_b[2] & select_b[1] & select[0]  }} & in09) | 
    ({N{select_b[4] & select[3]   & select_b[2] & select[1]   & select_b[0]}} & in10) | 
    ({N{select_b[4] & select[3]   & select_b[2] & select[1]   & select[0]  }} & in11) | 
    ({N{select_b[4] & select[3]   & select[2]   & select_b[1] & select_b[0]}} & in12) | 
    ({N{select_b[4] & select[3]   & select[2]   & select_b[1] & select[0]  }} & in13) | 
    ({N{select_b[4] & select[3]   & select[2]   & select[1]   & select_b[0]}} & in14) | 
    ({N{select_b[4] & select[3]   & select[2]   & select[1]   & select[0]  }} & in15) | 
    ({N{select[4]   & select_b[3] & select_b[2] & select_b[1] & select_b[0]}} & in16) | 
    ({N{select[4]   & select_b[3] & select_b[2] & select_b[1] & select[0]  }} & in17) | 
    ({N{select[4]   & select_b[3] & select_b[2] & select[1]   & select_b[0]}} & in18) | 
    ({N{select[4]   & select_b[3] & select_b[2] & select[1]   & select[0]  }} & in19) | 
    ({N{select[4]   & select_b[3] & select[2]   & select_b[1] & select_b[0]}} & in20) | 
    ({N{select[4]   & select_b[3] & select[2]   & select_b[1] & select[0]  }} & in21) | 
    ({N{select[4]   & select_b[3] & select[2]   & select[1]   & select_b[0]}} & in22) | 
    ({N{select[4]   & select_b[3] & select[2]   & select[1]   & select[0]  }} & in23) | 
    ({N{select[4]   & select[3]   & select_b[2] & select_b[1] & select_b[0]}} & in24) | 
    ({N{select[4]   & select[3]   & select_b[2] & select_b[1] & select[0]  }} & in25) | 
    ({N{select[4]   & select[3]   & select_b[2] & select[1]   & select_b[0]}} & in26) | 
    ({N{select[4]   & select[3]   & select_b[2] & select[1]   & select[0]  }} & in27) | 
    ({N{select[4]   & select[3]   & select[2]   & select_b[1] & select_b[0]}} & in28) | 
    ({N{select[4]   & select[3]   & select[2]   & select_b[1] & select[0]  }} & in29) | 
    ({N{select[4]   & select[3]   & select[2]   & select[1]   & select_b[0]}} & in30) | 
    ({N{select[4]   & select[3]   & select[2]   & select[1]   & select[0]  }} & in31);
  end

endmodule
