module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    parameter [3:0] A = 4'b0000,
    				B = 4'b0001,
    				S0 = 4'b0010,
    				S1 = 4'b0011,
    				S2 = 4'b0100,
    				S3 = 4'b0101,
    				Y1 = 4'b0110,
    				Y2_A = 4'b0111,
    				Y2_B = 4'b1000,
    				G_0 = 4'b1001,
    				G_1 = 4'b1010;
    
    reg [3:0] state, next_state;
    
    always @ (*)
        begin
            case (state)
                A:  next_state <= B;
                B:  next_state <= S0;
                S0: next_state <= (x) ? S1 : S0;
                S1: next_state <= (x) ? S1 : S2;
                S2: next_state <= (x) ? Y1 : S0;
                //S3: next_state <= (x) ? Y1 : S2;
                Y1: next_state <= (y) ? Y2_A : Y2_B;
                Y2_A: next_state <= G_1;
                Y2_B: next_state <= (y) ? G_1 : G_0;
                G_0: next_state <= G_0;
                G_1: next_state <= G_1;
                default next_state <= A;
            endcase
        end
    
    always @ (posedge clk)
        begin
            if (~resetn)
                state <= A;
            else
                state <= next_state;
        end
    
    assign f = (state == B);
    assign g = /*(state == S3) || */(state == Y1) || (state == Y2_A) || (state == Y2_B) || (state == G_1);
        

endmodule
