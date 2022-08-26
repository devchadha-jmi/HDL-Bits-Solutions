module top_module( 
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different );

   /* wire [4:0] in_modified = {in[0], in};
    always @ (*)
        begin
            for(int i = 0; i<3; i++)
                out_both[i] = (in[i] == in[i+1] == 1) ? 1'b1 : 1'b0;
            for(int j = 3; j>0; j--)
                out_any[j] = (in[j] == in[j-1] == 1) ? 1'b1 : 1'b0;
            for(int k = 0; k<4; k++)
                out_different[k] = (in_modified[k] == in_modified[k+1] == 1) ? 1'b1 : 1'b0;
        end
    assign out_both[2] = ((in[3] & in[2]) == 1)? 1'b1 : 1'b0;
    assign out_both[1] = ((in[2] & in[1]) == 1)? 1'b1 : 1'b0;
    assign out_both[0] = ((in[1] & in[0]) == 1)? 1'b1 : 1'b0; */
    
    // This question is just awesome
    assign out_both      = in[2:0] & in[3:1];//here bits of input vector is shifted right 
    									//and bitwise and is performed to obtain the required output
    assign out_any       = in[3:1] | in[2:0];
    assign out_different = in ^ {in[0],in[3:1]};
    
endmodule
