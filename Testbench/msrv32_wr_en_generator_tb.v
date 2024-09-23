module msrv_32_wr_en_generator_tb;

  // Inputs
  reg flush_in;
  reg rf_wr_en_reg_in;
  reg csr_wr_en_reg_in;

  // Outputs
  wire wr_en_integer_file_out;
  wire wr_en_csr_file_out;

  // Instantiate the module under test
  msrv_32_wr_en_generator uut (
    .flush_in(flush_in),
    .rf_wr_en_reg_in(rf_wr_en_reg_in),
    .csr_wr_en_reg_in(csr_wr_en_reg_in),
    .wr_en_integer_file_out(wr_en_integer_file_out),
    .wr_en_csr_file_out(wr_en_csr_file_out)
  );

  // Stimulus
  initial begin
    // Initialize inputs
    flush_in = 0;
    rf_wr_en_reg_in = 1;
    csr_wr_en_reg_in = 0;

    // Apply stimulus
    #10 flush_in = 1;
    #10 flush_in = 0;
    #10 rf_wr_en_reg_in = 0;
    #10 csr_wr_en_reg_in = 1;

    // Add more test cases as needed

    // Terminate simulation
    $finish;
  end

  // Add waveform dumping or other verification checks if desired

endmodule
