module top_module (
    input clk,
    input a,
    output reg [3:0] q );

    always @ (posedge clk)
        begin
            if (a)
                q <= 3'b100;
            else 
                q <= (q == 3'b110) ? 3'b000 : (q + 3'b001);
        end
    
endmodule
