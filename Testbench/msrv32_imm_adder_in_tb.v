module msrv_32_imm_adder_tb;
  // Inputs
  reg [31:0] rs_1_in;
  reg iadder_src_in;
  reg [31:0] imm_in;
  reg [31:0] pc_in;

  // Outputs
  wire [31:0] iadder_out;

  // Instantiate the DUT (Design Under Test)
msrv_32_imm_adder uut (
    .rs_1_in(rs_1_in),
    .iadder_src_in(iadder_src_in),
    .imm_in(imm_in),
    .pc_in(pc_in),
    .iadder_out(iadder_out)
  );

  // Test stimulus
  initial begin
    // Initialize inputs
    rs_1_in = 32'hAABBCCDD;
    iadder_src_in = 1;
    imm_in = 32'h12345678;
    pc_in = 32'h00010000;

    // Apply inputs and observe outputs
    #10 iadder_src_in = 0;
    #10 imm_in = 32'h87654321;
    #10 pc_in = 32'h00020000;

    // Add more test cases as needed...

    // Finish simulation after some time
    #100 $finish;
  

  // Display outputs
$monitor("Time=%t: rs_1_in=%h, iadder_src_in=%b, imm_in=%h, pc_in=%h, iadder_out=%h",
             $time, rs_1_in, iadder_src_in, imm_in, pc_in, iadder_out);
end

endmodule

