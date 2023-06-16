module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //
    
    parameter [1:0] BYTE1 = 2'b00,
    				BYTE2 = 2'b01,
    				BYTE3 = 2'b10,
    				DONE  = 2'b11;
    
    reg [1:0] state, next_state;
    reg [7:0] byte1, byte2, byte3;
    
    always @ (*)
        begin
            case (state)
                BYTE1: next_state = (in[3]) ? BYTE2 : BYTE1;
                BYTE2: next_state = BYTE3;
                BYTE3: next_state = DONE;
                DONE : next_state = (in[3]) ? BYTE2 : BYTE1;   
            endcase
        end
    
    // State flip-flops (sequential)
    always @ (posedge clk)
        begin
            if (reset)
                state <= BYTE1;
            else
                state <= next_state;
        end
    
    always @ (posedge clk)
        begin
            case (next_state)
                BYTE2: byte1 <= in;
                BYTE3: byte2 <= in;
                DONE:  byte3 <= in;
            endcase
        end

    // Output logic
    assign done = (state == DONE);
    assign out_bytes = (state == DONE) ? {byte1, byte2, byte3} : 24'b0;

endmodule
