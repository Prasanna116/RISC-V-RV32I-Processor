module PC_MUX(rst_in,pc_src_in,epc_in,trap_address_in,branch_taken_in,iaddr_in,ahb_ready_in,pc_in,iaddr_out,pc_plus_4_out,misaligned_instr_logic_out,pc_mux_out);

input rst_in;
input [1:0] pc_src_in;
input [31:0] epc_in;
input [31:0] trap_address_in;
input branch_taken_in;
input [31:0] iaddr_in;
input [31:0] ahb_ready_in;
input [31:0] pc_in;

output reg [31:0] iaddr_out;
output reg [31:0] pc_plus_4_out;
output reg [31:0] pc_mux_out;
output reg misaligned_instr_logic_out;

reg[31:0] concat;
reg[31:0] next_pc;

always@(*)
begin
concat={iaddr_in[31:1],1'b0};
pc_plus_4_out=pc_in+32'h00000004;

if (branch_taken_in) 
begin
next_pc=concat;
end
else 
begin
next_pc=pc_plus_4_out;
end

case(pc_src_in)
2'b00: pc_mux_out=32'h0;
2'b01: pc_mux_out=epc_in;
2'b10: pc_mux_out=trap_address_in;
2'b11: pc_mux_out=next_pc;
default pc_mux_out=next_pc;
endcase

misaligned_instr_logic_out=next_pc[1]&branch_taken_in;

if(rst_in)
begin
iaddr_out<=32'h0;
end
else
begin
iaddr_out<=pc_mux_out;
end

end
endmodule

