module top_module (input x, input y, output z);

    wire z1, z2;
    top_module_A instance1(x, y, z1);
    top_module_B instance2(x, y, z2);
    
    assign z = (z1 & z2) ^ (z1 | z2);
    
endmodule
        
module top_module_A (input x, input y, output z);

    assign z = (x^y) & x;
    
endmodule

module top_module_B ( input x, input y, output z );

    xnor(z, x, y);
    
endmodule