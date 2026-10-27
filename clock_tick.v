module clock_tick #(
parameter PARAMETRU_TIMP = 35
)(
input clk_i,
input rst_n_i,
output reg impuls_o
);

reg [31:0] numarator;
always @(posedge clk_i or negedge rst_n_i )
	if(~rst_n_i) numarator <=32'd0;
		else if(numarator == PARAMETRU_TIMP-1)
				numarator <= 32'd0;
				else numarator <=numarator + 1;

always @(posedge clk_i or negedge rst_n_i )
	if(~rst_n_i) impuls_o <=1'b0;
		else if(numarator == PARAMETRU_TIMP-1) 
				impuls_o <=1'b1;
				else impuls_o <=1'b0;
endmodule 