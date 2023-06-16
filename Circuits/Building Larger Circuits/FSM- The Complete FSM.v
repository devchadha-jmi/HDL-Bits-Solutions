module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
    
    parameter [3:0] S0 = 4'b0000,
    				S1 = 4'b0001,
    				S2 = 4'b0010,
    				S3 = 4'b0011,
    				B0 = 4'b0100,
    				B1 = 4'b0101,
    				B2 = 4'b0110,
    				B3 = 4'b0111,
    				COUNT = 4'b1000,
    				WAIT = 4'b1001;
    
    reg [3:0] state, next_state;
    
    always @ (*)
        begin
            case(state)
                S0: next_state <= (data) ? S1 : S0;
                S1: next_state <= (data) ? S2 : S0;
                S2: next_state <= (data) ? S2 : S3;
                S3: next_state <= (data) ? B0 : S0;
                B0: next_state <= B1;
                B1: next_state <= B2;
                B2: next_state <= B3;
                B3: next_state <= COUNT;
                COUNT: next_state <= (done_counting) ? WAIT : COUNT;
                WAIT: next_state <= (ack) ? S0 : WAIT;
                default next_state <= S0;
            endcase
        end
    
    always @ (posedge clk)
        begin
            if (reset)
                state <= S0;
            else
                state <= next_state;
        end
    
    assign shift_ena = (state == B0)||(state == B1)||(state == B2)||(state == B3);
    assign counting = (state == COUNT);
    assign done = (state == WAIT);

endmodule
