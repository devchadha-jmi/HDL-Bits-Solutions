module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // State Definition
    parameter [1:0] IDLE 	= 2'b00,  // Wait for start bit
    				DATA_RX = 2'b01,  // Once start bit is recieved jump to this state
    								  // count till 8 and check for Stop bit
    				DONE	= 2'b10,  // If Stop bit is recieved jump to this state
    								  // else jump tio ideal state
    				WAIT    = 2'b11;  // Wait here if Stop bit is not recieved
    
    reg [1:0] state, next_state;
    reg [3:0] counter;  // I dont know why HDL Bits is not supporting reg counters :-(
    
    always @ (*)
        begin
            case (state)
                IDLE: 	 next_state <= (~in) ? DATA_RX : IDLE;
                DATA_RX: next_state <= (counter == 4'b1000 && in) ? DONE : (counter == 4'b1000 && ~in) ? WAIT : DATA_RX;
                DONE: 	 next_state <= (~in) ? DATA_RX : IDLE;
                WAIT:    next_state <= (in) ? IDLE: WAIT;
            endcase
          end
    
    always @ (posedge clk)
        begin
            if (reset)
            	counter <= 0;
            else if (state == DATA_RX)
                counter <= counter + 4'b1;
            else
                counter <= 0;
        end
    
    always @ (posedge clk)
        begin
            if (reset)
                state <= IDLE;
            else
                state <= next_state;
        end
    
    assign done = (state == DONE);

    // New: Datapath to latch input bits.
    reg OUT_BIT;
    always @ (posedge clk)
        begin
            if (state == DATA_RX) begin
            OUT_BIT <= in;
            out_byte <= {OUT_BIT, out_byte[7:1]};
            end
            else
                out_byte <= out_byte;
        end

endmodule
