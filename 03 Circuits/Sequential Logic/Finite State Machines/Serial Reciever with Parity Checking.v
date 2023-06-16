module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //
    
    parameter [2:0] IDLE = 3'b000,      // Wait for start bit 
    				DATA_RX = 3'b001,   // Once start bit is recieved jump to this state
    								    // count till 9 perform parity and Stop bit check
    				DONE = 3'b010,      // Parity test passed and stop bit recieved
    				NOT_DONE = 3'b011,  // Parity test failed and stop bit recieved
    				WAIT = 3'b100;      // Parity test don't care and stop bit not recieved
    
    reg [2:0] state, next_state;
    reg [3:0] counter;
    // Counter to count till 9
    always @ (posedge clk)
        begin
            if (reset)
            	counter <= 0;
            else if (state == DATA_RX)
                counter <= counter + 4'b1;
            else
                counter <= 0;
        end
    
    // Generate block that instantiates parity checking module at the DATA_RX state 
    wire odd;
    parity p1 (clk, ~(state == DATA_RX), in, odd);
    
    // State change logic
    always @ (*)
        begin
            case (state)
                IDLE: 	  next_state <= (~in) ? DATA_RX : IDLE;
                DATA_RX:  next_state <= ((counter == 4'b1001 && in) && (odd)) ? DONE : ((counter == 4'b1001 && in) && (~odd)) ? NOT_DONE : (counter == 4'b1001 && ~in) ? WAIT : DATA_RX;
                DONE: 	  next_state <= (~in) ? DATA_RX : IDLE;
                NOT_DONE: next_state <= (~in) ? DATA_RX : IDLE;
                WAIT: 	  next_state <= (in) ? IDLE: WAIT;
            endcase
        end

    // State transition logic
    always @ (posedge clk)
        begin
            if (reset)
                state <= IDLE;
            else
                state <= next_state;
        end
    
    //Datapath to latch input bits.
    reg OUT_BIT;
    always @ (posedge clk)
        begin
            if (state == DATA_RX && counter < 4'b1001) begin
            	OUT_BIT <= in;
            	out_byte <= {OUT_BIT, out_byte[7:1]};
            end
            else
                out_byte <= out_byte;
        end
    
    assign done = (state == DONE);

endmodule