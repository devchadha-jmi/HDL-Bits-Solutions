module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); /*Connect the R inputs to the SW switches,
	clk to KEY[0],
	E to KEY[1],
	L to KEY[2], and
	w to KEY[3].
	Connect the outputs to the red lights LEDR[3:0].*/

    MUXDFF instance1 (KEY[0], KEY[1], SW[3], KEY[2], KEY[3],  LEDR[3]);
    MUXDFF instance2 (KEY[0], KEY[1], SW[2], KEY[2], LEDR[3], LEDR[2]);
    MUXDFF instance3 (KEY[0], KEY[1], SW[1], KEY[2], LEDR[2], LEDR[1]);
    MUXDFF instance4 (KEY[0], KEY[1], SW[0], KEY[2], LEDR[1], LEDR[0]);
    
endmodule

module MUXDFF (input clk,
               input E,
               input R,
               input L,
               input W,
               output reg Q);
    
    always @ (posedge clk)
        begin
            Q <= (L) ? R : (E) ? W : Q;
        end
    
endmodule
