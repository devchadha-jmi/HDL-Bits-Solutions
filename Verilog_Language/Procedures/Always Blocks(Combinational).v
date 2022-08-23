// synthesis verilog_input_version verilog_2001
`default_nettype none    
module top_module(
    input a, 
    input b,
    output wire out_assign,
    output reg out_alwaysblock
);

    //Using Assign Statement
    assign out_assign = a & b;
    // Using Combinational Always Block
    always @ (*)
        out_alwaysblock = a & b;
 
endmodule
