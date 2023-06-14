module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter [1:0] IDLE       = 2'b00,
    				FIRST_ONE  = 2'b01,
    				COMPLEMENT = 2'b10;
    
    reg [1:0] state, next_state;
    reg x_comp;
    
    always @ (*)
        begin
        	case (state)
                IDLE:       next_state <= (x) ? FIRST_ONE : IDLE;
                FIRST_ONE:  next_state <= (x) ? COMPLEMENT : FIRST_ONE;
                COMPLEMENT: next_state <= (x) ? COMPLEMENT : FIRST_ONE;
        	endcase
        end
    
    always @ (posedge clk or posedge areset)
        begin
            x_comp <= ~x;
            if (areset)
                state <= IDLE;
            else
                state <= next_state;
        end
    
    assign z = (state == FIRST_ONE) ? 1'b1 : 1'b0;

endmodule
