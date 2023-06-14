module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    
    parameter [1:0] s0 = 2'b00,
    				s1 = 2'b01,
    				s2 = 2'b10;
    
    reg [1:0] state, next_state;
    
    always @ (*)
        begin
            case (state)
                s0: next_state <= (x) ? s1 : s0;
                s1: next_state <= (x) ? s1 : s2;
                s2: next_state <= (x) ? s1 : s0;
            endcase
        end
    
    always @ (posedge clk or negedge aresetn)
        begin
            if (~aresetn)
                state <= s0;
            else
                state <= next_state;
        end
    
    assign z = (state == s2 && x);

endmodule
