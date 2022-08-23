module top_module (
    input [7:0] in,
    output parity); 

    // Parity of three bits A B C = A^B^C;
    assign parity = ^in[7:0];

    
endmodule
