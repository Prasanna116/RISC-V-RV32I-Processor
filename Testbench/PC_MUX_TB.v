module PC_MUX_TB;

reg rst_in;
reg [1:0] pc_src_in;
reg [31:0] epc_in;
reg [31:0] trap_address_in;
reg branch_taken_in;
reg [31:0] iaddr_in;
reg [31:0] ahb_ready_in;
reg [31:0] pc_in;

wire [31:0] iaddr_out;
wire [31:0] pc_plus_4_out;
wire [31:0] pc_mux_out;
wire misaligned_instr_logic_out;



 // Instantiate the PC_MUX module
 PC_MUX uut (
    .rst_in(rst_in),
    .pc_src_in(pc_src_in),
    .epc_in(epc_in),
    .trap_address_in(trap_address_in),
    .branch_taken_in(branch_taken_in),
    .iaddr_in(iaddr_in),
    .ahb_ready_in(ahb_ready_in),
    .pc_in(pc_in),
    .iaddr_out(iaddr_out),
    .pc_plus_4_out(pc_plus_4_out),
    .pc_mux_out(pc_mux_out),
    .misaligned_instr_logic_out(misaligned_instr_logic_out) );

 // Test vectors
  reg [5:0] test_vector = 0;
  reg done = 0;

  // Testbench initialization
  initial begin
    // Apply stimulus based on the test vectors
    repeat (6) begin
      case (test_vector)
        0: begin
          // Test Case 1: No branch taken, default PC source
          rst_in = 0;
          pc_src_in = 2'b00;
          epc_in = 32'hAABBCCDD;
          trap_address_in = 32'h11223344;
          branch_taken_in = 0;
          iaddr_in = 32'h11223344;
          ahb_ready_in = 1;
          pc_in = 32'h12345678;
        end
        1: begin
          // Test Case 2: Branch taken, default PC source
          rst_in = 0;
          pc_src_in = 2'b01;
          epc_in = 32'hACBEFC5D;
          trap_address_in = 32'h11223344;
          branch_taken_in = 0;
          iaddr_in = 32'h11223344;
          ahb_ready_in = 1;
          pc_in = 32'h12345678;
        end
        2: begin
          // Test Case 3: Branch taken, epic_in as PC source
          rst_in = 0;
          pc_src_in = 2'b10;
          epc_in = 32'hACBEFC5D;
          trap_address_in = 32'h11223344;
          branch_taken_in = 1;
          iaddr_in = 32'h11223344;
          ahb_ready_in = 1;
          pc_in = 32'h12345678;
        end
        3: begin
          // Test Case 4: Branch taken, trap_address_in as PC source
          rst_in = 0;
          pc_src_in = 2'b10;
          epc_in = 32'hACBEFC5D;
          trap_address_in = 32'h11223344;
          branch_taken_in = 1;
          iaddr_in = 32'h56789ABC;
          ahb_ready_in = 0;
          pc_in = 32'h12345348;
        end
        4: begin
          // Test Case 5: No branch taken, ahb_ready_in asserted
          rst_in = 0;
          pc_src_in = 2'b11;
          epc_in = 32'hACBEFC5D;
          trap_address_in = 32'h11223344;
          branch_taken_in = 0;
          iaddr_in = 32'h56789ABC;
          ahb_ready_in = 0;
          pc_in = 32'h12345678;
        end
        5: begin
          // Test Case 6: No branch taken, ahb_ready_in deasserted
          rst_in = 1;
          pc_src_in = 2'b11;
          epc_in = 32'hACBEFC5D;
          trap_address_in = 32'h11223344;
          branch_taken_in = 0;
          iaddr_in = 32'h56789ABC;
          ahb_ready_in = 0;
          pc_in = 32'h12345678;
        end
      endcase
 #10;
      
// Increment the test vector
test_vector = test_vector + 1;
      
// Check if all test vectors have been executed
if (test_vector == 6) 
begin
done = 1;
end
end

// Finish simulation
$finish;
end

// Monitor the outputs
always @(*) begin
// Display or check the outputs as needed
$display("Test Vector %d: iaddr_out = %h, pc_plus_4_out = %h, misaligned_instr_logic_out = %b, pc_mux_out = %h",
test_vector, iaddr_out, pc_plus_4_out, misaligned_instr_logic_out, pc_mux_out);
    
// Add more output monitoring or checking logic here
end

endmodule
