module top_module();
    
    //reg variables for driving inputs
    reg [1:0]in;
    reg out;
    
    // Design Instantiation
    andgate instance1(.in(in), .out(out));
    
    //VCD Files
   /* initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end  */
    
    //Driving Parametrs
  initial
    begin
        in <= 2'b00;
        #10;
        in <= 2'b01;
        #10;
        in <= 2'b10;
        #10;
        in <= 2'b11;
      /*  #10;
    $finish; */
    end
    
endmodule
