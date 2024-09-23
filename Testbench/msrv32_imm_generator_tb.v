module msrv32_imm_generator_tb;

reg [31:7] instr_in;
reg [2:0] imm_type_in;
wire [31:0] imm_out;

msrv32_imm_generator utt(instr_in,imm_type_in,imm_out);

initial
begin


instr_in=32'hFFFFFFFF;imm_type_in=3'b000;

#10 instr_in=32'hFFFFFFFF;imm_type_in=3'b001;

#10 instr_in=32'hFFFFFFFF;imm_type_in=3'b010;

#10 instr_in=32'hFFFFFFFF;imm_type_in=3'b011;

#10 instr_in=32'hFFFFFFFF;imm_type_in=3'b100;

#10 instr_in=32'hFFFFFFFF;imm_type_in=3'b101;

#10 instr_in=32'hFFFFFFFF;imm_type_in=3'b110;

#10 instr_in=32'hFFFFFFFF;imm_type_in=3'b111;

#20 $finish ;

$monitor( " Instr_type = %b | imm_gen= %h ",imm_type_in,imm_out);

end
endmodule 