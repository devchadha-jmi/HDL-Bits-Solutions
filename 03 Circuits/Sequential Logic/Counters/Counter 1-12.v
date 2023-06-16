module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
);  // Okay so we would be driving c_load as 1 and 
    // load value to internal counter on every reset
    // and when the value reaches 12.
    //wire [3:0] rst_count = 4'b0001;

    count4 the_counter (clk, c_enable, c_load, c_d, Q);
    
    assign c_load = ((Q == 4'b1100 && c_enable) || reset) ? 1 : 0;
    assign c_enable = enable;
    assign c_d = (c_load) ? 4'b0001 : 4'b000;

endmodule
