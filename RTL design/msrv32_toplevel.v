module msrv32_toplevel( input wire ms_riscv32_mp_rst_in,
                  input wire ms_riscv32_mp_clk_in,
                  input wire ms_riscv32_mp_instr_hready_in,
		  input wire ms_riscv32_mp_data_hready_in,
		  input ms_riscv32_mp_hresp_in,
		  input wire [31:0] ms_riscv32_mp_instr_in,
		  input wire [31:0] ms_riscv32_mp_dmdata_in,
		  input ms_riscv32_mp_eirq_in,
		  input ms_riscv32_mp_sirq_in,
		  input ms_riscv32_mp_tirq_in,
		  input [63:0]ms_riscv32_mp_rc_in,

                  output wire[31:0] ms_riscv32_mp_imaddr_out,
		  output wire [31:0] ms_riscv32_mp_dmdata_out,
		  output wire [31:0] ms_riscv32_mp_dmadder_out,
                  output wire [3:0] ms_riscv32_mp_dmwr_mask_out,
	          output wire ms_riscv32_mp_dmwr_req_out,
	          output wire [1:0] ms_riscv32_mp_data_htrans_out
                  );


// Outputs
wire [31:0] pc_plus_4_out;
wire misaligned_instr_logic_out;
wire [31:0] pc_mux_out;
wire [31:0] pc_out;
wire [31:0] imm_out;
wire [31:0] iadder_out;
wire [31:0] rs_1_out;
wire [31:0] rs_2_out;
wire wr_en_integer_file_out;
wire wr_en_csr_file_out;
wire [6:0]  opcode_out;
wire [2:0]  funct3_out;
wire [6:0]  funct7_out;
wire [4:0]  rs1addr_out;
wire [4:0]  rs2addr_out;
wire [4:0]  rdaddr_out;
wire [11:0] csr_addr_out;
wire [31:7] instr_out;
wire branch_taken_out;
wire [2:0] wb_mux_sel_out;
wire [2:0] imm_type_out;
wire [2:0] csr_op_out;
wire mem_wr_req_out;
wire [3:0] alu_opcode_out;
wire [1:0] load_size_out;
wire load_unsigned_out;
wire alu_src_out;
wire iadder_src_out;
wire csr_wr_en_out;
wire rf_wr_en_out;
wire illegal_instr_out;
wire misaligned_load_out;
wire misaligned_store_out;

  wire [4:0] rd_addr_reg_out;
  wire [11:0] csr_addr_reg_out;
  wire [31:0] rs1_reg_out;
  wire [31:0] rs2_reg_out;
  wire [31:0] pc_reg_out;
  wire [31:0] pc_plus_4_reg_out;
  wire [31:0] iaddr_out_reg_out;
  wire [3:0] alu_opcode_reg_out;
  wire [1:0] load_size_reg_out;
  wire load_unsigned_reg_out;
  wire alu_src_reg_out;
  wire csr_wr_en_reg_out;
  wire rf_wr_en_reg_out;
  wire [2:0] wb_mux_sel_reg_out;
  wire [2:0] csr_op_reg_out;
  wire [31:0] imm_reg_out;
  wire [31:0] lu_output_out;
  wire [31:0] result_out;
  wire [31:0] csr_data_out;
  wire mie_out;
  wire [31:0] epc_out,trap_address_out;
  wire meie_out,mtie_out,msie_out,meip_out,mtip_out,msip_out;
  wire i_or_e_out, set_epc_out, set_cause_out;
  wire [3:0] cause_out;
  wire instret_inc_out, mie_clear_out, mie_set_out,misaligned_exception_out;
  wire [1:0] pc_src_out;
  wire flush_out;
  wire trap_taken_out;

 PC_MUX M1 (
    .rst_in(ms_riscv32_mp_rst_in),
    .pc_src_in(pc_src_out),
    .epc_in(epc_out),
    .trap_address_in(trap_address_out),
    .branch_taken_in(branch_taken_out),
    .iaddr_in(iadder_out[31:1]),
    .ahb_ready_in(ms_riscv32_mp_instr_hready_in),
    .pc_in(pc_out),
    .iaddr_out( ms_riscv32_mp_imaddr_out),
    .pc_plus_4_out(pc_plus_4_out),
    .misaligned_instr_logic_out(misaligned_instr_logic_out),
    .pc_mux_out(pc_mux_out)
  );

 msrv32_reg_block_1 M2 (.pc_mux_in(pc_mux_out),
                         .ms_risc32_mp_clk_in(ms_riscv32_mp_clk_in),
                         .ms_risc32_mp_rst_in(ms_riscv32_mp_rst_in), 
                         .pc_out(pc_out));

 msrv32_imm_generator M3 (
    .instr_in(instr_out),
    .imm_type_in(imm_type_out),
    .imm_out(imm_out)
  );
 
 msrv32_imm_adder M4 (
    .pc_in(pc_out),
    .rs_1_in(rs_1_out),
    .iadder_src_in(iadder_src_out),
    .imm_in(imm_out),
    .iadder_out(iadder_out)
  );
 msrv32_integer_file M5 (
    .ms_risc32_mp_clk_in(ms_riscv32_mp_clk_in),
    .ms_risc32_mp_rst_in(ms_riscv32_mp_rst_in),
    .rs_1_addr_in(rs1addr_out),
    .rs_2_addr_in(rs2addr_out),
    .rd_addr_in(rd_addr_reg_out),
    .rd_in(wb_mux_out),
    .wr_en_in(wr_en_integer_file_out),
    .rs_1_out(rs_1_out),
    .rs_2_out(rs_2_out)
  );
 msrv32_wr_en_generator M6 (
    .csr_wr_en_reg_in(csr_wr_en_reg_out),
    .rf_wr_en_reg_in(rf_wr_en_reg_out),
    .flush_in(flush_out),
    .wr_en_csr_file_out(wr_en_csr_file_out),
    .wr_en_integer_file(wr_en_integer_file_out)
  );
 msrv32_instruction_mux M7 (
    .flush_in(flush_out),
    .ms_riscv32_mp_instr_in(ms_riscv32_mp_instr_in),
    .opcode_out(opcode_out),
    .funct3_out(funct3_out),
    .funct7_out(funct7_out),
    .rs1addr_out(rs1addr_out),
    .rs2addr_out(rs2addr_out),
    .rdaddr_out(rdaddr_out),
    .csr_addr_out(csr_addr_out),
    .instr_out(instr_out)
  );

 msrv32_branch_unit M8 (
    .rs1_in(rs_1_out),
    .rs2_in(rs_2_out),
    .opcode_in(opcode_out[6:2]),
    .funct3_in(funct3_out),
    .branch_taken_out(branch_taken_out)
  );
  msrv32_decoder M9 (
    .trap_taken_in(trap_taken_out),
    .funct7_5_in(funct7_out[4]),
    .opcode_in(opcode_out),
    .funct3_in(funct3_out),
    .iadder_out_1_to_0_in(iadder_out[1:0]),
    .wb_mux_sel_out(wb_mux_sel_out),
    .imm_type_out(imm_type_out),
    .csr_op_out(csr_op_out),
    .mem_wr_req_out(mem_wr_req_out),
    .alu_opcode_out(alu_opcode_out),
    .load_size_out(load_size_out),
    .load_unsigned_out(load_unsigned_out),
    .alu_src_out(alu_src_out),
    .iadder_src_out(iadder_src_out),
    .csr_wr_en_out(csr_wr_en_out),
    .rf_wr_en_out(rf_wr_en_out),
    .illegal_instr_out(illegal_instr_out),
    .misaligned_load_out(misaligned_load_out),
    .misaligned_store_out(misaligned_store_out)
  );
  msrv32_reg_block_2 M10 (
    .ms_risc32_mp_clk_in(ms_riscv32_mp_clk_in),
    .ms_risc32_mp_rst_in(ms_riscv32_mp_rst_in),
    .rd_addr_in(rdaddr_out),
    .csr_addr_in(csr_addr_out),
    .rs1_in(rs_1_out),
    .rs2_in(rs_2_out),
    .pc_in(pc_out),
    .pc_plus_4_in(pc_plus_4_out),
    .branch_taken_in(branch_taken_out),
    .iadder_out_in(iadder_out),
    .alu_opcode_in(alu_opcode_out),
    .load_size_in(load_size_out),
    .load_unsigned_in(load_unsigned_out),
    .alu_src_in(alu_src_out),
    .csr_wr_en_in(csr_wr_en_out),
    .rf_wr_en_in(rf_wr_en_out),
    .wb_mux_sel_in(wb_mux_sel_out),
    .csr_op_in(csr_op_out),
    .imm_in(imm_out),
    .rd_addr_reg_out(rd_addr_reg_out),
    .csr_addr_reg_out(csr_addr_reg_out),
    .rs1_reg_out(rs1_reg_out),
    .rs2_reg_out(rs2_reg_out),
    .pc_reg_out(pc_reg_out),
    .pc_plus_4_reg_out(pc_plus_4_reg_out),
    .iadder_out_reg_out(iaddr_out_reg_out),
    .alu_opcode_reg_out(alu_opcode_reg_out),
    .load_size_reg_out(load_size_reg_out),
    .load_unsigned_reg_out(load_unsigned_reg_out),
    .alu_src_reg_out(alu_src_reg_out),
    .csr_wr_en_reg_out(csr_wr_en_reg_out),
    .rf_wr_en_reg_out(rf_wr_en_reg_out),
    .wb_mux_sel_reg_out(wb_mux_sel_reg_out),
    .csr_op_reg_out(csr_op_reg_out),
    .imm_reg_out(imm_reg_out)
  );

  msrv32_store_unit M11 (
    .funct3_in(funct3_out[1:0]),
    .iadder_in(iadder_out),
    .rs2_in(rs_2_out),
    .ahb_ready_in(ms_riscv32_mp_data_hready_in),
    .mem_wr_req_in(mem_wr_req_out),
    .ms_riscv32_mp_dmdata_out(ms_riscv32_mp_dmdata_out),
    .ms_riscv32_mp_dmaddr_out(ms_riscv32_mp_dmadder_out),
    .ms_riscv32_mp_dmwr_mask_out(ms_riscv32_mp_dmwr_mask_out),
    .ms_riscv32_mp_dmwr_req_out(ms_riscv32_mp_dmwr_req_out),
    .ahb_htrans_out(ms_riscv32_mp_data_htrans_out)
  );
  msrv32_load_unit M12 (
    .ahb_resp_in(ms_riscv32_mp_hresp_in),
    .ms_riscv32_mp_dmdata_in(ms_riscv32_mp_dmdata_in),
    .iadder_out_1_to_0_in(iaddr_out_reg_out[1:0]),
    .load_unsigned_in(load_unsigned_reg_out),
    .load_size_in(load_size_reg_out),
    .lu_output_out(lu_output_out)
  );
   msrv32_alu M13 (
    .op_1_in(rs1_reg_out),
    .op_2_in(alu_2nd_src_mux_out),
    .opcode_in(alu_opcode_reg_out),
    .result_out(result_out)
  );
  msrv32_wb_mux_sel_unit M14 (
    .wb_mux_sel_reg_in(wb_mux_sel_reg_out),
    .alu_result_in(result_out),
    .lu_output_in(lu_output_out),
    .imm_reg_in(imm_reg_out),
    .iadder_out_reg_in(iaddr_out_reg_out),
    .csr_data_in(csr_data_out),
    .pc_plus_4_reg_in(pc_plus_4_reg_out),
    .rs2_reg_in(rs2_reg_out),
    .alu_src_reg_in(alu_src_reg_out),
    .wb_mux_out(wb_mux_out),
    .alu_2nd_src_mux_out(alu_2nd_src_mux_out)
  );

 msrv32_csr_file M15 (
        .clk_in(ms_riscv32_mp_clk_in),
        .rst_in(ms_riscv32_mp_rst_in),
	.wr_en_in(wr_en_csr_file_out),
        .csr_addr_in(csr_addr_reg_out),
        .csr_op_in(csr_op_reg_out),
        .csr_uimm_in(imm_reg_out[4:0]),
        .csr_data_in(rs1_reg_out),
        .pc_in(pc_reg_out),
        .iadder_in(iaddr_out_reg_out),
        .e_irq_in(ms_riscv32_mp_eirq_in),
        .s_irq_in(ms_riscv32_mp_sirq_in),
        .t_irq_in(ms_riscv32_mp_tirq_in),
        .i_or_e_in(i_or_e_out),
        .set_cause_in(set_cause_out),
        .set_epc_in(set_epc_out),
        .instret_inc_in(instret_inc_out),
        .mie_clear_in(mie_clear_out),
        .mie_set_in(mie_set_out),
        .cause_in(cause_out),
        .real_time_in(ms_riscv32_mp_rc_in),
        .misaligned_exception_in(misaligned_exception_out),
        .csr_data_out(csr_data_out),
        .mie_out(mie_out),
        .epc_out(epc_out),
        .trap_address_out(trap_address_out),
        .meie_out(meie_out),
        .mtie_out(mtie_out),
        .msie_out(msie_out),
        .meip_out(meip_out),
        .mtip_out(mtip_out),
        .msip_out(msip_out)
    );
    msrv32_machine_control M16(
        .clk_in(ms_riscv32_mp_clk_in),
        .reset_in(ms_riscv32_mp_rst_in),
        .illegal_instr_in(illegal_instr_out), 
        .misaligned_load_in(misaligned_load_out), 
        .misaligned_store_in(misaligned_store_out), 
        .misaligned_instr_in(misaligned_instr_logic_out), 
        .opcode_6_to_2_in(opcode_out[6:2]), 
        .funct3_in(funct3_out), 
        .funct7_in(funct7_out), 
        .rs1_addr_in(rs1addr_out), 
        .rs2_addr_in(rs2addr_out), 
        .rd_addr_in(rdaddr_out), 
        .e_irq_in(ms_riscv32_mp_eirq_in), 
        .t_irq_in(ms_riscv32_mp_tirq_in), 
	.s_irq_in(ms_riscv32_mp_sirq_in),
        .mie_in(mie_out), 
        .meie_in(meie_out), 
        .mtie_in(mtie_out), 
        .msie_in(msie_out), 
        .meip_in(meip_out), 
        .mtip_in(mtip_out), 
        .msip_in(msip_out), 
        .i_or_e_out(i_or_e_out), 
        .set_epc_out(set_epc_out), 
        .set_cause_out(set_cause_out), 
        .cause_out(cause_out), 
        .instret_inc_out(instret_inc_out), 
        .mie_clear_out(mie_clear_out), 
        .mie_set_out(mie_set_out), 
        .misaligned_exception_out(misaligned_exception_out), 
        .pc_src_out(pc_src_out), 
        .flush_out(flush_out), 
        .trap_taken_out(trap_taken_out) 
    );

endmodule 
