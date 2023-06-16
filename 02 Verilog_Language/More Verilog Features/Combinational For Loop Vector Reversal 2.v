module top_module( 
    input [99:0] in,
    output [99:0] out
);


    reg [99:0]out_temp;
    always @ (*)
        begin
            for (int i = 0; i< 100; i++) 
                begin
                out_temp[99 - i] =  in[i];
                end
        end
    assign out[99:0] = out_temp[99:0];
endmodule
