module top_module (
    input clk,
    input [7:0] d,
    output [7:0] q
);
    reg [7:0]out_temp;
    always @ (posedge clk)
        begin
            out_temp <= d;
        end
    assign q = out_temp;
    

endmodule
