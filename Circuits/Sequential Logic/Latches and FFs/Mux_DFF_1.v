module top_module (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);
    
    reg wire_from_mux_to_dff;
    
    always @ (*)
        begin
            if(L)
               wire_from_mux_to_dff <= r_in;
            else
               wire_from_mux_to_dff <= q_in;
        end
    always @ (posedge clk)
        begin
            Q <= wire_from_mux_to_dff;
        end
    

endmodule