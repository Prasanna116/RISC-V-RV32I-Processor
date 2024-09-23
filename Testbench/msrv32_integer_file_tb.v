module msrv32_integer_file_tb;

reg ms_risc32_mp_clk_in;
reg ms_risc32_mp_rst_in;
reg [4:0] rs_1_addr_in;
reg [4:0] rs_2_addr_in;
reg [4:0] rd_addr_in;
reg [31:0] rd_in;
reg wr_en_in;

wire [31:0] rs_1_out;
wire [31:0] rs_2_out;

// Instantiate the msrv32_integer_file module
msrv32_integer_file utt (
    .ms_risc32_mp_clk_in(ms_risc32_mp_clk_in),
    .ms_risc32_mp_rst_in(ms_risc32_mp_rst_in),
    .rs_1_addr_in(rs_1_addr_in),
    .rs_2_addr_in(rs_2_addr_in),
    .rd_addr_in(rd_addr_in),
    .rd_in(rd_in),
    .wr_en_in(wr_en_in),
    .rs_1_out(rs_1_out),
    .rs_2_out(rs_2_out)
);

// Clock generation
initial begin
    ms_risc32_mp_clk_in = 0;
    forever #5 ms_risc32_mp_clk_in = ~ms_risc32_mp_clk_in;
end

// Test procedure
initial begin
    // Monitor signal values
    $monitor("Time = %t: rs_1_out = %h, rs_2_out = %h", $time, rs_1_out, rs_2_out);

    // Apply reset
    ms_risc32_mp_rst_in = 1;
    wr_en_in = 0;
    rs_1_addr_in = 0;
    rs_2_addr_in = 0;
    rd_addr_in = 0;
    rd_in = 0;
    #15;  // Wait for reset to propagate

    // Deassert reset and perform write operations
    ms_risc32_mp_rst_in = 0;

    // Write 5 to register 1
    wr_en_in = 1;
    rd_addr_in = 1;
    rd_in = 32'h00000005;
    #10;  // Wait for one clock cycle

    // Write 6 to register 2
    wr_en_in = 1;
    rd_addr_in = 2;
    rd_in = 32'h00000006;
    #10;  // Wait for one clock cycle

    // Perform read operations (disable write first)
    wr_en_in = 0;
    rs_1_addr_in = 1;  // Read from register 1
    rs_2_addr_in = 2;  // Read from register 2
    #10;  // Wait for one clock cycle to see the read result

    // End simulation
    $finish;
end

endmodule
