module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
    // Segment that deals with chain of d_ffs
    wire [7:0]a_b;
    wire [7:0]b_c;
    wire [7:0]q0_q;
    my_dff8 inta(.clk(clk), .d(d),   .q(a_b));
    my_dff8 intb(.clk(clk), .d(a_b), .q(b_c));
    my_dff8 intc(.clk(clk), .d(b_c), .q(q0_q));
    
    // Segment that deals with the multiplexer
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;
    reg [7:0]q0;
    always @ (*)
        begin
            case (sel) 
                S0: 
                    q0 = d;
                S1: 
                    q0 = a_b;
                S2: 
                    q0 = b_c;
                S3: 
                    q0 = q0_q;
            endcase
        end
    assign q = q0;
    
endmodule
