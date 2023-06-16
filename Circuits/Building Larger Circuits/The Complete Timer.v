module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
    
    parameter [3:0] S0 = 4'b0000,  // These
    				S1 = 4'b0001,  // are states
    				S2 = 4'b0010,  // for 
    				S3 = 4'b0011,  // Sequence Detection
    
    				B0 = 4'b0100,  // These
    				B1 = 4'b0101,  // are states
    				B2 = 4'b0110,  // for 
    				B3 = 4'b0111,  // Count Read
    
    				COUNT = 4'b1000, // Counting State
    				WAIT =  4'b1001; // Counting is done, waiting for acknowledgement
    
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
    
    // Data Path to implement Shift and Decrement
    wire shift_ena = (state == B0)||(state == B1)||(state == B2)||(state == B3);
    wire count_ena = (q_count == 10'd999 && state == COUNT); 
    wire done_counting = (q_des == 4'b0 && q_count == 10'd999);
    
    reg [9:0] q_count;
    reg [3:0] q_des;
    
    // count decrementer and shifter
    always @ (posedge clk)
        begin
            if (!shift_ena && !count_ena)
                q_des <= q_des;
            else if (shift_ena && !count_ena)
                q_des <= {q_des[2:0], data};
            else if (!shift_ena && count_ena)
                q_des <= q_des - 4'b1;
            else
                q_des <= q_des;
        end
    
    // 1000-counter
    always @ (posedge clk)
        begin
            if (reset)
                q_count <= 10'd0;
            else if ((state == COUNT) && (q_count < 10'd999))
                q_count <= q_count + 10'd1;
            else
                q_count <= 10'd0;
        end
    
    // State Transition
    always @ (posedge clk)
        begin
            if (reset)
                state <= S0;
            else
                state <= next_state;
        end
    
    assign done = (state == WAIT);
    assign counting = (state == COUNT);
    assign count = q_des;
    
endmodule
