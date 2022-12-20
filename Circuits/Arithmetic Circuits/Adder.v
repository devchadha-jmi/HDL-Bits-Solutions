module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);

    genvar i;
    wire cout[3:0];
    generate
        full_adder instance0(x[0], y[0], 0, cout[0], sum[0]);
        for(i=1; i<4; i++) begin : name_instance
            full_adder instance1(x[i], y[i], cout[i-1], cout[i], sum[i]);
        end
    endgenerate
    assign sum[4] = cout[3];
endmodule

module full_adder( 
    input a, b, cin,
    output cout, sum );
    assign{cout, sum} = a + b+ cin;
endmodule

