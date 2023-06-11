module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q ); 
    
    reg [512:-1] current_state;
    assign current_state[-1]  = 1'b0;
    assign current_state[512] = 1'b0;
    
    always @ (load or current_state)
        begin
            if (load)
                current_state[511:0] <= data;
            else
                current_state[511:0] <= q[511:0];   
        end
    
    genvar i;
    generate 
        for(i = 0; i<512; i=i+1)
        	begin : Label
                dff_with_xor dut (clk, current_state[i-1], current_state[i+1], load, data[i], q[i]);
        	end
    endgenerate
    
endmodule

module dff_with_xor(input clk,
                    input a,
                    input b,
                    input load,
                    input data,
                    output reg dout
                   );
    
    always @ (posedge clk)
        begin
            if (load)
                dout <= data;
            else
            	dout <= a^b;
        end
    
endmodule
