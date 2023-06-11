module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
        if (state == OFF)
            next_state = (j) ? ON : OFF;
        else
            next_state = (k) ? OFF : ON;
    end

    always @(posedge clk, posedge areset) begin
        if (areset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == ON) ? 1 : 0;

endmodule
