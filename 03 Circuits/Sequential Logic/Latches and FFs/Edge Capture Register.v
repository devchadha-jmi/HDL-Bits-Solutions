module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);
    reg [31:0] intermediate;
    
    always @ (posedge clk)
        begin
            intermediate <= in;
            if (reset)
                out <= 32'b0;
            else
                begin
                    out <= out | (~in & intermediate);
                end
        end
endmodule
