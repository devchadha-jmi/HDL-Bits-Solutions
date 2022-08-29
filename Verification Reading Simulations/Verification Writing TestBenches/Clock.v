module top_module ( );

    reg clk;
    initial 
        begin
            clk <= 1'b0;
        end
    always
        begin
           #5; 
           clk <= ~clk;
        end
    dut instance1(.clk(clk));
endmodule
