// synthesis verilog_input_version verilog_2001
module top_module(
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output wire out_assign,
    output reg out_always   ); 

     wire c = sel_b1 & sel_b2;
    // Method 1 Using Assign Statements
    assign out_assign = c ? b : a;
    
    // Method 2 Using Combinational Always Block
    always @ (*)
        begin
            if(c)
              out_always = b;
            else 
              out_always = a; 
        end
endmodule
