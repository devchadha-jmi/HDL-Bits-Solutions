module top_module (
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input [3:0] e,
    output reg [3:0] q );

    always @ (*)
        begin
            if (c == 4'b0000)
                q = b[3:0];
            else if (c == 4'b0001)
                q = e[3:0];
            else if (c == 4'b0010)
                q = a[3:0];
            else if (c == 4'b0011)
                q = d[3:0];
            else
                q = 4'b1111;
        end
    
            
endmodule
