module top_module(
    input clk,
    input areset,  // async active-high reset to zero
    input load,
    input ena,
    input [3:0] data,
    output [3:0] q); 
    
    // Define Shift Register
    reg [3:0] shift_reg;
    
    always @(posedge clk or posedge areset)
        begin
            if(areset)
                shift_reg <= 4'b0;
            else if(load)
                shift_reg <= data;
            else if(ena)
                shift_reg <= shift_reg >> 1;
            else
                shift_reg <= shift_reg;
        end
    
    assign q = shift_reg;
endmodule
