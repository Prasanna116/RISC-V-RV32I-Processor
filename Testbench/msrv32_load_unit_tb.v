module msrv32_load_unit_tb;

  reg ahb_resp_in;
  reg [31:0] ms_riscv32_mp_dmdata_in;
  reg [1:0] iadder_out_1_to_0_in;
  reg load_unsigned_in;
  reg [1:0] load_size_in;
  wire [31:0] lu_output_out;

  // Instantiate the unit under test
  msrv32_load_unit uut (
    .ahb_resp_in(ahb_resp_in),
    .ms_riscv32_mp_dmdata_in(ms_riscv32_mp_dmdata_in),
    .iadder_out_1_to_0_in(iadder_out_1_to_0_in),
    .load_unsigned_in(load_unsigned_in),
    .load_size_in(load_size_in),
    .lu_output_out(lu_output_out)
  );

  // Initialize signals
  initial begin
    ahb_resp_in = 0;
    ms_riscv32_mp_dmdata_in = 0;
    iadder_out_1_to_0_in = 0;
    load_unsigned_in = 0;
    load_size_in = 0;

    // Test case 1
    ahb_resp_in = 1; // Enable the module
    ms_riscv32_mp_dmdata_in = 32'hA5A5A5A5; // Some data
    iadder_out_1_to_0_in = 2'b01; // Set your values
    load_unsigned_in = 1'b0; // Set load_unsigned_in
    load_size_in = 2'b00; // Set load_size_in

    #10; // Wait for some time
    // Check lu_output_out here
    // You can use $display or $assert to check the value
    ahb_resp_in = 0; // Enable the module
    ms_riscv32_mp_dmdata_in = 32'hA5A5A5A5; // Some data
    iadder_out_1_to_0_in = 2'b11; // Set your values
    load_unsigned_in = 1'b0; // Set load_unsigned_in
    load_size_in = 2'b00;
    #10
    // Test case 2 (and more) can be added in a similar manner
    ahb_resp_in = 0; // Enable the module
    ms_riscv32_mp_dmdata_in = 32'h34567A43; // Some data
    iadder_out_1_to_0_in = 2'b10; // Set your values
    load_unsigned_in = 1'b1; // Set load_unsigned_in
    load_size_in = 2'b00;
    #10
    ahb_resp_in = 0; // Enable the module
    ms_riscv32_mp_dmdata_in = 32'hA5A5A5A5; // Some data
    iadder_out_1_to_0_in = 2'b01; // Set your values
    load_unsigned_in = 1'b0; // Set load_unsigned_in
    load_size_in = 2'b00;
    #10
    ahb_resp_in = 0; // Enable the module
    ms_riscv32_mp_dmdata_in = 32'hA5A5A5A5; // Some data
    iadder_out_1_to_0_in = 2'b11; // Set your values
    load_unsigned_in = 1'b0; // Set load_unsigned_in
    load_size_in = 2'b11;
    #10
    ahb_resp_in = 0; // Enable the module
    ms_riscv32_mp_dmdata_in = 32'hA5A5A5A5; // Some data
    iadder_out_1_to_0_in = 2'b11; // Set your values
    load_unsigned_in = 1'b0; // Set load_unsigned_in
    load_size_in = 2'b01;
    #10
    ahb_resp_in = 0; // Enable the module
    ms_riscv32_mp_dmdata_in = 32'h234567A; // Some data
    iadder_out_1_to_0_in = 2'b00; // Set your values
    load_unsigned_in = 1'b0; // Set load_unsigned_in
    load_size_in = 2'b01;
    #10
    // Finish the simulation after all test cases
    $finish;
  end

endmodule
