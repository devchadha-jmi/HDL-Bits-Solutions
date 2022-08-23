module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    
    genvar i;
    wire cin_storage = cin; //Temporarily store the carry for transition
    generate
        for(i = 0; i < 100; i++)
            begin : maze_daar // This is important to add - Label Identifier
            if(i == 0)
                begin
                    full_adder instance1(.a(a[0]), .b(b[0]), .cin(cin_storage), .cout(cout[0]), .sum(sum[0]));
                end
        else
            begin
                full_adder instance2(.a(a[i]), .b(b[i]), .cin(cout[i-1]), .cout(cout[i]), .sum(sum[i]));
            end
        end
    endgenerate 
                
endmodule

// Module for full Adder
module full_adder(
    input a, b,
    input cin,
    output cout,
    output sum);
    
    assign {cout, sum} = a + b + cin;

endmodule
