module top_module ( input clk, input d, output q );

    wire a_b, b_c;
    my_dff inta(.clk(clk), .d(d),   .q(a_b));
    my_dff intb(.clk(clk), .d(a_b), .q(b_c));
    my_dff intc(.clk(clk), .d(b_c), .q(q));

endmodule
