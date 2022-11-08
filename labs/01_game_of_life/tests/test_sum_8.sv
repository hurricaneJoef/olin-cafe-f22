`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_sum_8;

  logic [7:0] in;
  wire [3:0] out;
  wire c;
  sum_8 UUT (in,out,c);

  initial begin // In standard programming land (line by line execution)
    // Collect waveforms
    $dumpfile("sum_8.fst");
    $dumpvars(0, UUT);

    $display("    in    | c out");
    for (int i = 0; i < 256; i = i + 1) begin
      in = i[7:0];
      #1 $display(" %8b | %1b %3b", in, c, out);
    end
        
    $finish;      
	end

endmodule
