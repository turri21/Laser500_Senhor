module dac #(parameter C_bits = 16)
(
	input wire clk_i,
	input wire res_n_i,
	input wire [C_bits-1:0] dac_i,
	output wire dac_o
);

reg [C_bits-1:0] sigma;
reg [C_bits-1:0] dac;

always @(posedge clk_i or negedge res_n_i) begin
	if (!res_n_i) begin
		sigma <= 0;
		dac <= 0;
	end else begin
		sigma <= sigma + dac_i;
		dac <= sigma[C_bits-1] ? {1'b1, {C_bits-1{1'b0}}} : {1'b0, {C_bits-1{1'b0}}};
	end
end

assign dac_o = dac[C_bits-1];

endmodule 