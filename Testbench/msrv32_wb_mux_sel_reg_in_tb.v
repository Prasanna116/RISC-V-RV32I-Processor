module msrv32_wb_mux_sel_reg_in_tb;

  reg [2:0] wb_mux_sel_reg_in;
  reg [31:0] alu_result_in;
  reg [31:0] lu_output_in;
  reg [31:0] imm_reg_in;
  reg [31:0] iadder_out_reg_in;
  reg [31:0] csr_data_in;
  reg [31:0] pc_plus_4_reg_in;
  reg [31:0] rs2_reg_in;
  reg alu_src_reg_in;
  wire [31:0] wb_mux_out;
  wire [31:0] alu_2nd_src_mux_out;

  // Instantiate the msrv_32_wb_mux_sel_unit module
  msrv32_wb_mux_sel_unit uut (
    .wb_mux_sel_reg_in(wb_mux_sel_reg_in),
    .alu_result_in(alu_result_in),
    .lu_output_in(lu_output_in),
    .imm_reg_in(imm_reg_in),
    .iadder_out_reg_in(iadder_out_reg_in),
    .csr_data_in(csr_data_in),
    .pc_plus_4_reg_in(pc_plus_4_reg_in),
    .rs2_reg_in(rs2_reg_in),
    .alu_src_reg_in(alu_src_reg_in),
    .wb_mux_out(wb_mux_out),
    .alu_2nd_src_mux_out(alu_2nd_src_mux_out)
  );

  initial begin
    // Test case 1: Test with wb_alu
    wb_mux_sel_reg_in = 3'b000; // wb_alu
    alu_result_in = 32'h12345678;
    lu_output_in = 32'habcdef01;
    imm_reg_in = 32'h87654321;
    iadder_out_reg_in = 32'hdeadbeef;
    csr_data_in = 32'hfeedface;
    pc_plus_4_reg_in = 32'hbabecafe;
    rs2_reg_in = 32'hfedcba98;
    alu_src_reg_in = 1'b0; // For rs2_reg_in
    #10; // Wait for some time
    wb_mux_sel_reg_in = 3'b101; // wb_alu
    alu_result_in = 32'h12345678;
    lu_output_in = 32'habcdef01;
    imm_reg_in = 32'h87654321;
    iadder_out_reg_in = 32'hdeadbeef;
    csr_data_in = 32'hfeedface;
    pc_plus_4_reg_in = 32'hbabecafe;
    rs2_reg_in = 32'hfedcba98;
    alu_src_reg_in = 1'b1; // For rs2_reg_in
    #10; // Wait for some time
    // Add more test cases for other values of wb_mux_sel_reg_in

    $finish; // Finish the simulation
  end

endmodule
