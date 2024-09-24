module msrv32_store_unit(
input [1:0] funct3_in,
input[31:0] iadder_in,
input [31:0] rs2_in,
input mem_wr_req_in,
input ahb_ready_in,
output reg[31:0] ms_riscv32_mp_dmdata_out,
output reg[31:0] ms_riscv32_mp_dmaddr_out,
output reg[3:0] ms_riscv32_mp_dmwr_mask_out,
output reg ms_riscv32_mp_dmwr_req_out,
output reg [1:0] ahb_htrans_out);

reg byte_out;
reg half_dout;
reg byte_wr_mask;
reg half_wr_mask;

// Data Placement in data_out
always@(*)
begin

case(iadder_in[1:0])
2'b00: byte_out<= {24'b0,rs2_in[7:0]};
2'b01: byte_out<= {16'b0,rs2_in[7:0],8'b0};
2'b10: byte_out<= {8'b0,rs2_in[7:0],16'b0};
2'b11: byte_out<= {rs2_in[7:0],24'b0};
endcase

case(iadder_in[1])
1'b0: half_dout<= {16'b0,rs2_in[15:0]};
1'b1: half_dout <= {rs2_in[15:0],16'b0};
endcase

if(ahb_ready_in)
begin
case(funct3_in[1:0])
2'b00: ms_riscv32_mp_dmdata_out<=byte_out;
2'b01: ms_riscv32_mp_dmdata_out<=half_dout;
2'b10: ms_riscv32_mp_dmdata_out<=rs2_in;
2'b11: ms_riscv32_mp_dmdata_out<=rs2_in;
default ms_riscv32_mp_dmdata_out<=32'b0;
endcase
end
else
begin
ms_riscv32_mp_dmdata_out <= 32'b0;
end
end

 // Setting wr_mask_out
always@(*)
begin

case(iadder_in[1:0])
2'b00: byte_wr_mask<= {3'b0,mem_wr_req_in};
2'b01: byte_wr_mask<= {2'b0,mem_wr_req_in,1'b0};
2'b10: byte_wr_mask<= {1'b0,mem_wr_req_in,2'b0};
2'b11: byte_wr_mask<= {mem_wr_req_in,3'b0};
endcase

case(iadder_in[1])
1'b0: half_wr_mask<= {2'b0,{2{mem_wr_req_in}}};
1'b1: half_wr_mask <= {{2{mem_wr_req_in}},2'b0};
endcase

case(funct3_in[1:0])
2'b00: ms_riscv32_mp_dmwr_mask_out<= byte_wr_mask;
2'b01: ms_riscv32_mp_dmwr_mask_out<= half_wr_mask;
2'b10: ms_riscv32_mp_dmwr_mask_out<= {4{mem_wr_req_in}};
2'b11: ms_riscv32_mp_dmwr_mask_out<= {4{mem_wr_req_in}};
endcase 
end

 // Alignment of dm_adder_out
  always @(*) begin
    ms_riscv32_mp_dmaddr_out = {iadder_in[31:2], 2'b00};
  end

  // Alignment of wr_req_out
  always @(*) begin
    ms_riscv32_mp_dmwr_req_out= mem_wr_req_in; 
  end

  // ah_htrans_out setting
  always @(*) begin
    case(funct3_in)
      2'b00:ahb_htrans_out = 2'b10;
      2'b01:ahb_htrans_out = 2'b10;
      2'b10:ahb_htrans_out = 2'b10;
      default:ahb_htrans_out = 2'b00;
   endcase

  end

endmodule