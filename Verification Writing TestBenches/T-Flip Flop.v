module top_module ();

    //reg input variables
    reg clk;
    reg reset;
    reg t;
    
    //wire output variable
    wire q;
    
    //Design Instantiation
    tff instance1(.clk(clk), .reset(reset), .t(t), .q(q));
    
    //Clk
     initial begin
            clk <= 1'b0;
        end
    always begin
           #5; 
           clk <= ~clk;
        end
    
    // Driving Parameters
    initial
        begin
            
    reset = 1;
    t = 1;
    #15;
    reset = 0;
        end
    
endmodule
