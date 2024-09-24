module msrv32_reg_block_2_tb;
  // Testbench inputs
  reg ms_risc32_mp_clk_in;
  reg ms_risc32_mp_rst_in;
  reg [6:0] rd_addr_in;
  reg [6:0] csr_addr_in;
  reg signed [6:0] rs1_in;
  reg signed [6:0] rs2_in;
  reg [6:0] pc_in;
  reg [6:0] pc_plus_4_in;
  reg branch_taken_in;
  reg [6:0] iadder_out_in;
  reg [6:0] alu_opcode_in;
  reg [6:0] load_size_in;
  reg [6:0] load_unsigned_in;
  reg [6:0] alu_src_in;
  reg [6:0] csr_wr_en_in;
  reg [6:0] rf_wr_en_in;
  reg [6:0] wb_mux_sel_in;
  reg [6:0] csr_op_in;
  reg signed [6:0] imm_in;

  // Testbench outputs
  wire [6:0] rd_addr_reg_out;
  wire [6:0] csr_addr_reg_out;
  wire signed [6:0] rs1_reg_out;
  wire [6:0] rs2_reg_out;
  wire [6:0] pc_reg_out;
  wire [6:0] pc_plus_4_reg_out;
  wire [31:0] iadder_out_reg_out;
  wire [6:0] alu_opcode_reg_out;
  wire [6:0] load_size_reg_out;
  wire [6:0] load_unsigned_reg_out;
  wire [6:0] alu_src_reg_out;
  wire [6:0] csr_wr_en_reg_out;
  wire [6:0] rf_wr_en_reg_out;
  wire [6:0] wb_mux_sel_reg_out;
  wire [6:0] csr_op_reg_out;
  wire signed [6:0] imm_reg_out;

  // Instantiate the msrv32_reg_block_2 module
  msrv32_reg_block_2 uut (
    .ms_risc32_mp_clk_in(ms_risc32_mp_clk_in),
    .ms_risc32_mp_rst_in(ms_risc32_mp_rst_in),
    .rd_addr_in(rd_addr_in),
    .csr_addr_in(csr_addr_in),
    .rs1_in(rs1_in),
    .rs2_in(rs2_in),
    .pc_in(pc_in),
    .pc_plus_4_in(pc_plus_4_in),
    .branch_taken_in(branch_taken_in),
    .iadder_out_in(iadder_out_in),
    .alu_opcode_in(alu_opcode_in),
    .load_size_in(load_size_in),
    .load_unsigned_in(load_unsigned_in),
    .alu_src_in(alu_src_in),
    .csr_wr_en_in(csr_wr_en_in),
    .rf_wr_en_in(rf_wr_en_in),
    .wb_mux_sel_in(wb_mux_sel_in),
    .csr_op_in(csr_op_in),
    .imm_in(imm_in),
    .rd_addr_reg_out(rd_addr_reg_out),
    .csr_addr_reg_out(csr_addr_reg_out),
    .rs1_reg_out(rs1_reg_out),
    .rs2_reg_out(rs2_reg_out),
    .pc_reg_out(pc_reg_out),
    .pc_plus_4_reg_out(pc_plus_4_reg_out),
    .iadder_out_reg_out(iadder_out_reg_out),
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

  // Clock generation
  initial begin
    ms_risc32_mp_clk_in = 0;
    forever #10 ms_risc32_mp_clk_in = ~ms_risc32_mp_clk_in;  // 10-time unit period clock
  end

  // Simulation
  initial begin
    // Initialize all inputs
    ms_risc32_mp_rst_in = 1;  // Start with reset
    rd_addr_in = 0;
    csr_addr_in = 0;
    rs1_in = 0;
    rs2_in = 0;
    pc_in = 0;
    pc_plus_4_in = 0;
    branch_taken_in = 0;
    iadder_out_in = 0;
    alu_opcode_in = 0;
    load_size_in = 0;
    load_unsigned_in = 0;
    alu_src_in = 0;
    csr_wr_en_in = 0;
    rf_wr_en_in = 0;
    wb_mux_sel_in = 0;
    csr_op_in = 0;
    imm_in = 0;

    // Hold reset for a few cycles
    #15 ms_risc32_mp_rst_in = 0;

    // Test case 1: Normal operation
    rd_addr_in = 7'b0000011;
    csr_addr_in = 7'b0000100;
    rs1_in = 7'b0000010;
    rs2_in = 7'b0000101;
    pc_in = 7'b0000110;
    pc_plus_4_in = 7'b0000111;
    iadder_out_in = 7'b0001000;
    alu_opcode_in = 7'b0001001;
    load_size_in = 7'b0001010;
    load_unsigned_in = 7'b0001011;
    alu_src_in = 7'b0001100;
    csr_wr_en_in = 7'b0001101;
    rf_wr_en_in = 7'b0001110;
    wb_mux_sel_in = 7'b0001111;
    csr_op_in = 7'b0010000;
    imm_in = 7'b0010001;

    #20;

    // Test case 2: Branch taken (iadder_out_reg_out should become 0)
    branch_taken_in = 1;
    iadder_out_in = 7'b0010010;
    #20 branch_taken_in = 0;  // Return branch_taken_in to normal

    // Test case 3: Reset condition again
    ms_risc32_mp_rst_in = 1;
    #10 ms_risc32_mp_rst_in = 0;  // De-assert reset

    #20;

    // End the simulation
    $finish;
  end

  // Monitor the outputs
  initial begin
    $monitor("Time=%0t, rd_addr_reg_out=%b, csr_addr_reg_out=%b, rs1_reg_out=%b, rs2_reg_out=%b, pc_reg_out=%b, pc_plus_4_reg_out=%b, iadder_out_reg_out=%b, alu_opcode_reg_out=%b, load_size_reg_out=%b, load_unsigned_reg_out=%b, alu_src_reg_out=%b, csr_wr_en_reg_out=%b, rf_wr_en_reg_out=%b, wb_mux_sel_reg_out=%b, csr_op_reg_out=%b, imm_reg_out=%b", 
      $time, rd_addr_reg_out, csr_addr_reg_out, rs1_reg_out, rs2_reg_out, pc_reg_out, pc_plus_4_reg_out, iadder_out_reg_out, alu_opcode_reg_out, load_size_reg_out, load_unsigned_reg_out, alu_src_reg_out, csr_wr_en_reg_out, rf_wr_en_reg_out, wb_mux_sel_reg_out, csr_op_reg_out, imm_reg_out);
  end

endmodule

