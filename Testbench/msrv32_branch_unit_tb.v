module msrv32_branch_unit_tb;

reg [31:0] rs1;
reg [31:0] rs2;
reg [6:2] opcode_in;
reg [2:0] funct3_in;
wire branch_taken_out;

msrv32_branch_unit utt(rs1,rs2,opcode_in,funct3_in,branch_taken_out);

initial
begin

rs1=1;rs2=2;opcode_in=5'b11000;funct3_in=3'b100;

#10 rs1=2;rs2=1;opcode_in=5'b11000;funct3_in=3'b001;

#10 rs1=1;rs2=2;opcode_in=5'b11011;

#10 rs1=1;rs2=2;opcode_in=5'b11001;

end
endmodule 