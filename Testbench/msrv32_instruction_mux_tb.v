module msrv32_instruction_mux_tb;


  // Signals
  reg [31:0] ms_risc32_mp_instr_in;
  reg flush_in;
  wire [6:0]  opcode_out;
  wire [2:0]  funct3_out;
  wire [6:0]  funct7_out;
  wire [4:0]  rs1addr_out;
  wire [4:0]  rs2addr_out;
  wire [4:0]  rdaddr_out;
  wire [11:0] csr_addr_out;
  wire [31:7] instr_out;
  

  // Instantiate the module
  msrv32_instruction_mux UUT (
    .flush_in(flush_in),
    .ms_risc32_mp_instr_in(ms_risc32_mp_instr_in),
    .opcode_out(opcode_out),
    .funct3_out(funct3_out),
    .funct7_out(funct7_out),
    .rs1addr_out(rs1addr_out),
    .rs2addr_out(rs2addr_out),
    .rdaddr_out(rdaddr_out),
    .csr_addr_out(csr_addr_out),
    .instr_out(instr_out)
  );

  // Initializations
  initial begin
    flush_in = 0;
    ms_risc32_mp_instr_in = 32'h00001234; // You can initialize this with your test input
    // Add more test cases by changing ms_risc32_mp_instr_in value

    // Test case 1
    flush_in = 0;
    ms_risc32_mp_instr_in = 32'h00001234; // Your input value here
    #10; // Allow some time for the output to stabilize
    // Add assertion or display statements to check the outputs

    // Test case 2
    flush_in = 1;
    #10; // Allow some time for the output to stabilize
    // Add assertion or display statements to check the outputs

    // Add more test cases as needed

    // Finish simulation
    $finish;
  end

endmodule
