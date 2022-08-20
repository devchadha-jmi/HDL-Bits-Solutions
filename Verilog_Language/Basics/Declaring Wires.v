`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 

    wire out_and1;
    wire out_and2;
    
    assign out_and1 = a & b;
    assign out_and2 = c & d;
    assign out      = out_and1 | out_and2;
    assign out_n    = ~(out_and1 | out_and2);
endmodule
