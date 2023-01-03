module top_module();

    //reg signal ports
    reg clk;
    reg in;
    reg [2:0]s;
    reg out;
    
    //Design Instantiation
    q7 instance1(.clk(clk), .in(in), .s(s), .out(out));
    
    //Driving Clock
    initial begin
            clk <= 1'b0;
        end
    always begin
           #5; 
           clk <= ~clk;
        end
    
    // Driving other ports
    initial begin
        in <= 1'b0;
        s <= 3'b010;
        #10;
        s <= 3'b110;
        #10;
        in <= 1'b1;
        s <= 3'b010;
        #10;
        in <= 1'b0;
        s <= 3'b111;
        #10;
        in <= 1'b1;
        s <= 3'b000;
        #30;
        in <= 1'b0;
    end
endmodule
