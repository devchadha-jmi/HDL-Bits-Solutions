module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    reg [1:0] state, next_state;
    parameter A = 2'b01, B = 2'b10;
    
    always @ (*)
        begin
            case (state)
                A : next_state <= (x) ? B : A;
                B : next_state <= B;
            endcase
        end
    
    always @ (posedge clk or posedge areset)
        begin
            if (areset)
                state <= A;
            else
                state <= next_state;
        end
    
    assign z = (state[0] && x) || (state[1] && ~x);

endmodule
