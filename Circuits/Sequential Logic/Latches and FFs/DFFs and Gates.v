module top_module (
    input clk,
    input x,
    output z
); 
    reg Q0 = 1'b0;
    reg Q1 = 1'b0;
    reg Q2 = 1'b0;
    
    always @ (posedge clk)
        begin
            Q0 <=  Q0 ^ x;
            Q1 <= ~Q1 & x;
            Q2 <= ~Q2 | x;
        end
    
    nor(z, Q0, Q1, Q2);
        
endmodule
