module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);//  

    parameter A=0, B=1; 
    reg state, next_state;

    always @(*) begin   // This is a combinational always bloc
        if (state == B)
            begin
        		if (in)
           		 	next_state <= B;
        		else
            		next_state <= A;
            end
        
        else
            begin
        		if (in)
           		 	next_state <= A;
        		else
            		next_state <= B;
            end 
    end

    always @(posedge clk or posedge areset) begin    // This is a sequential always block
        if (areset)
            state <= B;
        else
        	state <= next_state;
    end

    // Output logic
    assign out = (state == A) ? 0 : 1;

endmodule
