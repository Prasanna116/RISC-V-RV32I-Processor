module msrv32_alu (input signed [31:0] op_1_in,
       input signed [31:0] op_2_in,
       input [3:0] opcode_in,
       output reg [31:0]result_out);


parameter funct3_add  = 3'b000,
	  funct3_slt  = 3'b010,
	  funct3_sltu = 3'b011,
	  funct3_and  = 3'b111,
	  funct3_or   = 3'b110,
	  funct3_xor  = 3'b100,
	  funct3_sll  = 3'b001,
	  funct3_srl  = 3'b101;

wire signed [31:0] signed_op1;
wire [31:0] sra_result;
wire [31:0] srl_result;
wire [31:0] shr_result;
wire slt_result;
wire sltu_result;


assign signed_op1  = op_1_in;
assign sra_result  = signed_op1 >>> op_2_in [4:0];
assign srl_result  = op_1_in >> op_2_in [4:0];
assign shr_result  = opcode_in[3] == 1'b1 ? sra_result : srl_result;
assign sltu_result = op_1_in < op_2_in;
assign slt_result  = op_1_in[31]^op_2_in[31] ? op_1_in [31]: sltu_result;


always @(*)
begin
case (opcode_in [2:0])
funct3_add : result_out = opcode_in[3]? op_1_in - op_2_in: op_1_in + op_2_in;
funct3_srl : result_out = shr_result;
funct3_or  : result_out = op_1_in | op_2_in;
funct3_and : result_out = op_1_in & op_2_in;
funct3_xor : result_out = op_1_in ^ op_2_in;
funct3_slt : result_out = {31'b0, slt_result};
funct3_sltu: result_out = {31'b0, sltu_result};
funct3_sll : result_out = op_1_in << op_2_in[4:0];
default    : result_out = 32'b0;
endcase

end
endmodule
