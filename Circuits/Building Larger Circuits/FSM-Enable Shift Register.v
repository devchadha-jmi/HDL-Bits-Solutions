module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    
    parameter [1:0] IDLE = 2'b00, // This is state where output is zero
    				S1 = 2'b01,   // This state is taken whenever Reset is asserted
    				S2 = 2'b10;   // This state is taken when Reset is deasserted and counter is initiated
    
    reg [1:0] state, next_state;
    
    always @ (*)
        begin
            case(state)
                IDLE: next_state <= (reset) ? S1 : IDLE;
                S1: next_state <= (reset) ? S1 : S2;
                S2: next_state <= (reset) ? S1 : (~reset && counter == 2'b10) ? IDLE : S2;
            endcase
        end
    
    // Counter
    reg [1:0] counter;
    always @ (posedge clk)
        begin
            if(state == S2)
            	counter <= counter + 2'b1;
            else
                counter <= 2'b0;
        end
    
    // State Transition
    always @ (posedge clk)
        begin
            state <= next_state;
        end
    
    assign shift_ena = (state == S1)||(state == S2);

endmodule
