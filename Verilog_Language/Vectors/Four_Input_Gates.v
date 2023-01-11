module top_module( 
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    // & in[3:0]
    // | in[3:0]
    // ^ in[3:0]
    and(out_and, in[3], in[2], in[1], in[0]);
    or(out_or, in[3], in[2], in[1], in[0]);
    xor(out_xor, in[3], in[2], in[1], in[0]);
    
endmodule
