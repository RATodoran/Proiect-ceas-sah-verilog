module long_press #(
    parameter TIMP = 32'd150000000  
)(
    input clk_i,
    input rst_n_i,
    input in_S,         
    output reg out_S    
);

reg [31:0] numarator;


always @(posedge clk_i or negedge rst_n_i) 
    if (~rst_n_i) 
        numarator <= 32'd0;
    else if (~in_S)
        numarator <= 32'd0; 
    else if (numarator < TIMP)
        numarator <= numarator + 1'b1; 
always @(posedge clk_i or negedge rst_n_i) begin
    if (~rst_n_i) begin
        out_S <= 1'b0;
    end else if (~in_S) begin
        out_S <= 1'b0; 
    end else if (numarator >= TIMP) begin
        out_S <= 1'b1; 
    end
end

endmodule