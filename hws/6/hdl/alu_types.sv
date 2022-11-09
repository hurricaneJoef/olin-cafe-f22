`ifndef ALU_TYPES_H
`define ALU_TYPES_H

typedef enum logic [3:0] {
  ALU_AND  = 4'b0001, //in
  ALU_OR   = 4'b0010, //in
  ALU_XOR  = 4'b0011, //in
  ALU_SLL  = 4'b0101,
  ALU_SRL  = 4'b0110,
  ALU_SRA  = 4'b0111, 
  ALU_ADD  = 4'b1000, // in
  ALU_SUB  = 4'b1100, // in
  ALU_SLT  = 4'b1101,// in 
  ALU_SLTU = 4'b1111 // in
} alu_control_t;

function string alu_control_name(alu_control_t control);
  case(control)
    ALU_AND  : alu_control_name = " AND ";
    ALU_OR   : alu_control_name = " OR  ";
    ALU_XOR  : alu_control_name = " XOR ";
    ALU_SLL  : alu_control_name = " SLL ";
    ALU_SRL  : alu_control_name = " SRL ";
    ALU_SRA  : alu_control_name = " SRA ";
    ALU_ADD  : alu_control_name = " ADD ";
    ALU_SUB  : alu_control_name = " SUB ";
    ALU_SLT  : alu_control_name = " SLT ";
    ALU_SLTU : alu_control_name = " SLTU";
    default  : alu_control_name = "UNDEF";
  endcase
endfunction

`endif // ALU_TYPES_H