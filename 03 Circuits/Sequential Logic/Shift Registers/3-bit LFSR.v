module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q
    
    // R   is SW[2:0]
    // Clk is KEY[0]
    // L   is KEY[1]
    
    wire D0 = (KEY[1]) ? SW[0] : LEDR[2];
    wire D1 = (KEY[1]) ? SW[1] : LEDR[0];
    wire D2 = (KEY[1]) ? SW[2] : (LEDR[2] ^ LEDR[1]);
    
    always @ (posedge KEY[0])
        begin
            LEDR[2] <= D2;
            LEDR[1] <= D1;
            LEDR[0] <= D0;
        end
    
endmodule
    
