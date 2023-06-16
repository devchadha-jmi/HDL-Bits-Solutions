// This is not the most optimized solution
// Takes about 9 states

// Rather I would suggest to latch values of W for three cycles and commpare with 101, 110 , 011

// state diagram followed

/*
							A
                            |
                            B
                         /     \
                        P       Q
                      /   \    /  \
                   WAIT   R   T    S
                   /       \  /     \
                   B       DONE     B
                           /  \
                           P  Q
*/

module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    parameter [3:0] A = 4'b0000,
    				B = 4'b0001,
    				P = 4'b0010,
    				Q = 4'b0011,
    				R = 4'b0100,
    				S = 4'b0101,
    				T = 4'b0110,
    				WAIT = 4'b0111,
    				DONE = 4'b1000;
    
    reg [3:0] state, next_state;
    
    always @ (*)
        begin
            case(state)
                A: next_state <= (s) ? B : A;
                B: next_state <= (w) ? Q : P;
                P: next_state <= (w) ? R : WAIT;
                Q: next_state <= (w) ? S : T;
                R: next_state <= (w) ? DONE : B;
                S: next_state <= (w) ? B : DONE;
                T: next_state <= (w) ? DONE : B;
                WAIT: next_state <= B;
                DONE: next_state <= (w) ? Q : P;  
            endcase
        end
    
    always @ (posedge clk)
        begin
            if (reset)
                state <= A;
            else
                state <= next_state;    
        end
    
    assign z = (state == DONE);

endmodule
