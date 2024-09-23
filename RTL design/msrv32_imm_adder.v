module msrv_32_imm_adder(input wire  [31:0] rs_1_in,
        		       input wire iadder_src_in,
                               input wire [31:0] imm_in,
			       input wire [31:0]pc_in,
			       output [31:0] iadder_out);


assign iadder_out = iadder_src_in ? (rs_1_in+imm_in) : (pc_in + imm_in);
endmodule 