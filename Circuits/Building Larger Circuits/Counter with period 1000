module top_module (
    input clk,
    input reset,
    output reg [9:0] q);
    
    always @ (posedge clk)
        begin
            if (reset)
                q <= 10'd0;
            else if (q < 10'd999)
                q <= q + 10'd1;
            else
                q <= 10'd0;
        end

endmodule
