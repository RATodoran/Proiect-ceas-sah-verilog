module chess_timer #(
)(
input clk_i,
input rst_n_i,
input impuls_i,
input mod_functionare,
input [31:0] timp_initial,
input [7:0] increment_i,
input load_i,
input enable_A_i,
input enable_B_i,
input add_increment_A_i,
input add_increment_B_i,
output reg [31:0] timp_A_o,
output reg [31:0] timp_B_o,
output flag_o
);

reg loaded_reg;

// logica pentru timp a
always @(posedge clk_i or negedge rst_n_i)
	if(~rst_n_i) 
		timp_A_o <=32'b0;
		else if(load_i) 
				timp_A_o <= timp_initial;
			else if(add_increment_A_i && mod_functionare)
					timp_A_o <= {24'b0, increment_i} ;
				else if (impuls_i && enable_A_i && (timp_A_o >0)) 
						timp_A_o <=timp_A_o -1;
						
// logica pentru timp b	
always @(posedge clk_i or negedge rst_n_i)
	if(~rst_n_i) 
		timp_B_o <=32'b0;
		else if(load_i) 
				timp_B_o <= timp_initial;
			else if(add_increment_B_i && mod_functionare)
					timp_B_o <= {24'b0, increment_i} ;
				else if (impuls_i && enable_B_i && (timp_B_o >0)) 
						timp_B_o <=timp_B_o -1;
						
						
assign flag_o = (timp_A_o ==0) || (timp_B_o ==0);
 
endmodule