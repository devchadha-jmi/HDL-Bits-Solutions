module top_module(
    input clk,
    input in,
    input areset,
    output out); //
    
    parameter A = 2'b00,
    		  B = 2'b01,
    		  C = 2'b10,
    		  D = 2'b11;
    
    reg [1:0] state, next_state;

    // State transition logic
    always @ (*)
        begin
            case (state)
                A : next_state <= (in) ? B : A; 
                B : next_state <= (in) ? B : C; 
                C : next_state <= (in) ? D : A; 
                D : next_state <= (in) ? B : C; 
            endcase
        end

    // State flip-flops with asynchronous reset
    always @ (posedge clk or posedge areset)
        begin
            if (areset)
                state <= A;
            else
                state <= next_state;
        end

    // Output logic
    assign out = (state == D) ? 1'b1 : 1'b0;

endmodule
