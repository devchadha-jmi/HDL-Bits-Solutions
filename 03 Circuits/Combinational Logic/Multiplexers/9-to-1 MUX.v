module top_module( 
    input [15:0] a, b, c, d, e, f, g, h, i,
    input [3:0] sel,
    output [15:0] out );

    always @ (*)
        begin
            case(sel)
                4'b0000:
                    out[15:0] = a[15:0];
                4'b0001:
                    out[15:0] = b[15:0];
                4'b0010:
                    out[15:0] = c[15:0];
                4'b0011:
                    out[15:0] = d[15:0];
                4'b0100:
                    out[15:0] = e[15:0];
                4'b0101:
                    out[15:0] = f[15:0];
                4'b0110:
                    out[15:0] = g[15:0];
                4'b0111:
                    out[15:0] = h[15:0];
                4'b1000:
                    out[15:0] = i[15:0];
                default:
                    out[15:0] = 16'b1111111111111111;
            endcase
        end
                
endmodule
