module msrv32_reg_block_1_tb;

reg [31:0] pc_mux_in;
reg ms_risc32_mp_clk_in;
reg ms_risc32_mp_rst_in;
wire [31:0] pc_out;

msrv32_reg_block_1 utt ( pc_mux_in,ms_risc32_mp_clk_in,ms_risc32_mp_rst_in,pc_out);

initial
begin
ms_risc32_mp_clk_in=0;
forever #5 ms_risc32_mp_clk_in=~ms_risc32_mp_clk_in;
end

initial
begin


ms_risc32_mp_rst_in=0;pc_mux_in=32'h12345678;

#10 ms_risc32_mp_rst_in=1;pc_mux_in=32'h12345678;

#10 ms_risc32_mp_rst_in=0;pc_mux_in=32'h12345678;

#10 ms_risc32_mp_rst_in=1;pc_mux_in=32'h12345678;

#10;

#20 $finish;

$monitor("PC_OUT=%h",pc_out);
end
endmodule




