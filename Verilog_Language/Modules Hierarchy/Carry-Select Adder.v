`default_nettype none 
module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0]sum1;
    wire [15:0]sum2a;
    wire [15:0]sum2b;
    wire carry_transition;
    wire high = 1'b1;
    wire low  = 1'b0;
    
    add16 adder1 ( a[15:0], b[15:0], low, sum1[15:0], carry_transition);
    
    //Assuming the carry genrated to be 1
    add16 adder2a (a[31:16], b[31:16], high, sum2a[15:0]); 
    
    //Assuming the carry generated to be 0
    add16 adder2b (a[31:16], b[31:16], low, sum2b[15:0]);
    
    //Implementing Multiplexer
    assign sum = carry_transition ? {sum2a, sum1} : {sum2b, sum1};    
    
endmodule
