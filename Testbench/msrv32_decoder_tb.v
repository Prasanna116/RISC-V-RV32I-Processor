`timescale 1ns / 1ps

module msrv32_decoder_tb;
  reg trap_taken_in;
  reg funct7_5_in;
  reg [6:0] opcode_in;
  reg [2:0] funct3_in;
  reg [1:0] iadder_out_1_to_0_in;

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

  // Instantiate the msrv_32_decoder module
  msrv32_decoder uut (
    .trap_taken_in(trap_taken_in),
    .funct7_5_in(funct7_5_in),
    .opcode_in(opcode_in),
    .funct3_in(funct3_in),
    .iadder_out_1_to_0_in(iadder_out_1_to_0_in),
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

   
    initial begin
    // Initialize inputs
    trap_taken_in = 0;
    funct7_5_in = 1;
    opcode_in = 7'b0110011;  // Example opcode (R-type instruction)
    funct3_in = 3'b000;      // Example funct3
    iadder_out_1_to_0_in = 2'b00;  // Example iadder_out_1_to_0

    // Add more test vectors and assignments here
    #10;
    trap_taken_in = 0;
    funct7_5_in = 0;
    opcode_in = 7'b0010011;  // Example opcode (I-type instruction)
    funct3_in = 3'b000;      // Example funct3
    iadder_out_1_to_0_in = 2'b00;
    #20;
    trap_taken_in = 0;
    funct7_5_in = 0;
    opcode_in = 7'b0010011;  // Example opcode (I-type instruction)
    funct3_in = 3'b010;      // Example funct3
    iadder_out_1_to_0_in = 2'b00;
    #20;
    trap_taken_in = 0;
    funct7_5_in = 0;
    opcode_in = 7'b0010011;  // Example opcode (I-type instruction)
    funct3_in = 3'b111;      // Example funct3
    iadder_out_1_to_0_in = 2'b00;
    #20;
    trap_taken_in = 0;
    funct7_5_in = 0;
    opcode_in = 7'b1110011;  // Example opcode (SYSTEM instruction)
    funct3_in = 3'b111;      // Example funct3
    iadder_out_1_to_0_in = 2'b00;
    #20;
    trap_taken_in = 0;
    funct7_5_in = 0;
    opcode_in = 7'b1101100;  // Invalid instruction example
    funct3_in = 3'b111;      // Example funct3
    iadder_out_1_to_0_in = 2'b00;
    #20;
    // Display the results
    $monitor("wb_mux_sel_out: %b", wb_mux_sel_out);
    $monitor("imm_type_out: %b", imm_type_out);
    $monitor("csr_op_out: %b", csr_op_out);
    $monitor("mem_wr_reg_out: %b", mem_wr_req_out);
    $monitor("alu_opcode_out: %b", alu_opcode_out);
    $monitor("load_size_out: %b", load_size_out);
    $monitor("load_unsigned_out: %b", load_unsigned_out);
    $monitor("alu_src_out: %b", alu_src_out);
    $monitor("iadder_src_out: %b", iadder_src_out);
    $monitor("csr_wr_en_out: %b", csr_wr_en_out);
    $monitor("rf_wr_en_out: %b", rf_wr_en_out);
    $monitor("illegal_instr_out: %b", illegal_instr_out);
    $monitor("misaligned_load_out: %b", misaligned_load_out);
    $monitor("misaligned_store_out: %b", misaligned_store_out);

    // End simulation
    $finish;
  end

endmodule
