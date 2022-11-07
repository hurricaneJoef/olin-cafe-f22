/*
  Outputs a pulse generator with a period of "ticks".
  out should go high for one cycle ever "ticks" clocks.
*/
module pulse_generator(clk, rst, ena, ticks, out);

parameter N = 8;
input wire clk, rst, ena;
input wire [N-1:0] ticks;
output logic out;


logic counter_comparator;

logic interal_rst; always_comb interal_rst = rst|out;

//counter start
logic c_out;
logic [N-1:0] counter, counter_next;
always_comb counter_next = counter+1;
always_ff @(posedge clk) begin
  if(interal_rst) counter <= 0;
  else if (ena) counter <= counter_next;
end
//counter end
always_comb out = {1'b0, counter_next}=={1'b0, ticks};

endmodule
