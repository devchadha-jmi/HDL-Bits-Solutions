module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    
    parameter [2:0] s0 = 3'b000,
    				s1 = 3'b001,
    				s2 = 3'b010,
    				s3 = 3'b011,
    				s4 = 3'b100;
    
    reg [2:0] state, next_state;
    
    always @ (*)
        begin
            case(y)
                s0: next_state <= (x) ? s1 : s0;
                s1: next_state <= (x) ? s4 : s1;
                s2: next_state <= (x) ? s1 : s2;
                s3: next_state <= (x) ? s2 : s1;
                s4: next_state <= (x) ? s4 : s3;
                default next_state <= s0;
            endcase
        end
    
    always @ (posedge clk)
        begin
             state <= next_state;
        end
    
    assign z = (y == s3)|(y == s4);
    assign Y0 = next_state[0];

endmodule
