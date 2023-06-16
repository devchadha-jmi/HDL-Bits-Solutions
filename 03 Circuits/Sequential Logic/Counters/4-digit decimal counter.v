module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    
    assign ena[1] = (q[3:0] == 4'd9);
    assign ena[2] = (q[7:4] == 4'd9 && q[3:0] == 4'd9);
    assign ena[3] = (q[11:8] == 4'd9 && q[7:4] == 4'd9 && q[3:0] == 4'd9);
    
    counter instance1 (clk, reset, 1'b1, q[3:0]); // This counter never has to wait for ena
    counter instance2 (clk, reset, ena[1], q[7:4]);
    counter instance3 (clk, reset, ena[2], q[11:8]);
    counter instance4 (clk, reset, ena[3], q[15:12]);

endmodule


// This counter counts single BCD digit from 0-9
module counter (input clk,
                input reset,
                input ena,
                output reg [3:0] Q);
    
    always @ (posedge clk)
        begin
            if (reset)
                Q <= 4'd0;
            else if (ena)
                begin
                    if (Q == 4'd9)
                        Q <= 4'd0;
                    else
                        Q <= Q + 4'd1;
                end
        end
endmodule
                
