`default_nettype none
`timescale 1ns/1ps

module led_array_driver(ena, x, cells, rows, cols);
// Module I/O and parameters
parameter N=5; // Size of Conway Cell Grid.
parameter ROWS=N;
parameter COLS=N;

// I/O declarations
input wire ena;
input wire [$clog2(N):0] x;
input wire [N*N-1:0] cells;
output logic [N-1:0] rows;
output logic [N-1:0] cols;


// You can check parameters with the $error macro within initial blocks.
initial begin
  if ((N <= 0) || (N > 8)) begin
    $error("N must be within 0 and 8.");
  end
  if (ROWS != COLS) begin
    $error("Non square led arrays are not supported. (%dx%d)", ROWS, COLS);
  end
  if (ROWS < N) begin
    $error("ROWS/COLS must be >= than the size of the Conway Grid.");
  end
end

wire [N-1:0] x_decoded;
decoder_3_to_8 COL_DECODER(ena, x[2:0], x_decoded);
logic [N-1:0] y_decoded;
logic [N*N-1:0] anded_cells, wide_xd;
always_comb wide_xd = {N{x_decoded[(N-1):0]}};
always_comb anded_cells = wide_xd & cells;

generate
  genvar i;
  for (i = 0; i<ROWS; i++) begin : row_iter
    always_comb y_decoded[i] = |anded_cells[(((i+1)*COLS)-1):(i*COLS)];
  end
endgenerate
always_comb cols = x_decoded;
always_comb rows = ~y_decoded;

endmodule
