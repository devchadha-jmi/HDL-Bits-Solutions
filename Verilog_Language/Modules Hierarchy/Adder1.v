module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0]sum1; 
    wire [15:0]sum2;
    wire cin_transition;
    add16 adder1(.a(a[15:0]), .b(b[15:0]), .sum(sum1), .cout(cin_transition));
    add16 adder2(.a(a[31:16]), .b(b[31:16]), .sum(sum2), .cin(cin_transition));
    assign sum = {sum2, sum1}; 
    
endmodule
