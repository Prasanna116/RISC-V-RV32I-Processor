module msrv32_store_unit_tb;

  // Parameters
  reg [1:0] funct3_in;
  reg [31:0] iadder_in;
  reg [31:0] rs2_in;
  reg ahb_ready_in;
  reg mem_wr_req_in;
  
  // Outputs
  wire [31:0] ms_riscv32_mp_dmdata_out;
  wire [31:0] ms_riscv32_mp_dmaddr_out;
  wire [3:0] ms_riscv32_mp_dmwr_mask_out;
  wire ms_riscv32_mp_dmwr_req_out;
  wire [1:0] ahb_htrans_out;

  // Instantiate the module to be tested
  msrv32_store_unit uut (
    .funct3_in(funct3_in),
    .iadder_in(iadder_in),
    .rs2_in(rs2_in),
    .ahb_ready_in(ahb_ready_in),
    .mem_wr_req_in(mem_wr_req_in),
    .ms_riscv32_mp_dmdata_out(ms_riscv32_mp_dmdata_out),
    .ms_riscv32_mp_dmaddr_out(ms_riscv32_mp_dmaddr_out),
    .ms_riscv32_mp_dmwr_mask_out(ms_riscv32_mp_dmwr_mask_out),
    .ms_riscv32_mp_dmwr_req_out(ms_riscv32_mp_dmwr_req_out),
    .ahb_htrans_out(ahb_htrans_out)
  );

  // Test stimulus
  initial begin
    // Test case 1
    funct3_in = 2'b01;
    iadder_in = 32'h12345672;
    rs2_in = 32'hABCDEF01;
    ahb_ready_in = 1;
    mem_wr_req_in = 1;
    
    // Add delays for your design's response time
    #10;
    
    // Check the outputs
    if (ms_riscv32_mp_dmdata_out !== 32'h0000EF01 ||
        ms_riscv32_mp_dmaddr_out !== 32'h12345678 ||
        ms_riscv32_mp_dmwr_mask_out !== 4'h5 ||
        ms_riscv32_mp_dmwr_req_out !== 1'b1 ||
        ahb_htrans_out !== 2'b10) begin
      $display("Test case 1 failed!");
    end else begin
      $display("Test case 1 passed!");
    end

    // Test case 2
    // Add more test cases with different inputs

    $finish;
  end

endmodule

