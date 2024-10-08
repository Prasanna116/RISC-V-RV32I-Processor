module msrv32_wb_mux_sel_unit(input [2:0] wb_mux_sel_reg_in,
input [31:0] alu_result_in,
input [31:0] lu_output_in,
input signed [31:0] imm_reg_in,
input [31:0] iadder_out_reg_in,
input [31:0] csr_data_in,
input [31:0] pc_plus_4_reg_in,
input signed [31:0] rs2_reg_in,
input  alu_src_reg_in,
output reg [31:0] wb_mux_out,
output wire [31:0] alu_2nd_src_mux_out);

parameter wb_alu     = 3'b000,
	  wb_lu      = 3'b001,
	  wb_imm     = 3'b010,
	  wb_iadder_out = 3'b011,
	  wb_csr     = 3'b100,
  	  wb_pc_plus = 3'b101;
always @(*)
begin
case(wb_mux_sel_reg_in)

	wb_alu     : wb_mux_out = alu_result_in;
	wb_lu      : wb_mux_out = lu_output_in;
	wb_imm     : wb_mux_out = imm_reg_in;	
	wb_iadder_out: wb_mux_out = iadder_out_reg_in;
	wb_csr     : wb_mux_out = csr_data_in;
	wb_pc_plus : wb_mux_out = pc_plus_4_reg_in;
	default    : wb_mux_out = alu_result_in;
endcase
end
assign alu_2nd_src_mux_out = alu_src_reg_in  ? rs2_reg_in : imm_reg_in ;
endmodule 
