module msrv32_alu_tb;

  reg [31:0] op_1_in;
  reg [31:0] op_2_in;
  reg [3:0] opcode_in;
  wire [31:0] result_out;

  // Instantiate the msrv_32_alu module
  msrv32_alu uut (
    .op_1_in(op_1_in),
    .op_2_in(op_2_in),
    .opcode_in(opcode_in),
    .result_out(result_out)
  );

  initial begin
    // Test case 1: Add
    op_1_in = 5;
    op_2_in = 3;
    opcode_in = 4'b0000;  // funct3_add
    #10;  // Wait for some time
    if (result_out !== (op_1_in + op_2_in))
      $display("Test case 1 failed");

    // Test case 2: SRL
    op_1_in = 16;
    op_2_in = 3;
    opcode_in = 4'b0101;  // funct3_srlss
    #10;  // Wait for some time
    if (result_out !== (op_1_in >> op_2_in[4:0]))
      $display("Test case 2 failed");

    // Add more test cases for other operations

    $finish;  // Finish the simulation
  end

endmodule
