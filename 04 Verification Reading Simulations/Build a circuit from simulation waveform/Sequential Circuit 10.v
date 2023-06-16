module top_module (
    input clk,
    input a,
    input b,
    output q,
    output reg state  );

    always @ (posedge clk)
        begin
            if (a == b)
                state <= a;
        end
    
    always @ (*)
        begin
            if (a == b)
                q = state;
            else
                q = ~state;
        end
endmodule
