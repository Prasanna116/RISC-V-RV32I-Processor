module msrv32_reg_block_1(

input [31:0] pc_mux_in,
input ms_risc32_mp_clk_in,
input ms_risc32_mp_rst_in,
output reg [31:0] pc_out);

always @(posedge ms_risc32_mp_clk_in or posedge ms_risc32_mp_rst_in)
begin
if(ms_risc32_mp_rst_in)
begin
pc_out<=32'h0;
end
else
begin
pc_out<=pc_mux_in;
end
end

endmodule
