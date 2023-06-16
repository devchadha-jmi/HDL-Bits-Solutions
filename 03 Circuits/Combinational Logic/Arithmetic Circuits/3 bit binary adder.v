module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );

    genvar i;
    generate
        full_adder instance0(a[0], b[0], cin, cout[0], sum[0]);
        for(i=1; i<3; i++) begin : name_instance
            full_adder instance1(a[i], b[i], cout[i-1], cout[i], sum[i]);
        end
    endgenerate
endmodule

module full_adder( 
    input a, b, cin,
    output cout, sum );
    assign{cout, sum} = a + b+ cin;
endmodule
