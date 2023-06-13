// I Quit
module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    
    parameter [2:0] LEFT = 3'b000,
    				RIGHT = 3'b001,
                    DIG_L = 3'b010,
    				DIG_R = 3'b011,
    				FALL_L = 3'b100,
    				FALL_R = 3'b101,
    				SPLAT = 3'b110;
    
    reg [2:0] state, next_state;
    int counter;
    
    always @ (*)
        begin
        	case (state)
                LEFT:  next_state <= (~ground) ? FALL_L : (dig) ? DIG_L : (bump_left)  ? RIGHT : LEFT;
                RIGHT: next_state <= (~ground) ? FALL_R : (dig) ? DIG_R : (bump_right) ? LEFT : RIGHT;
                DIG_L: next_state <= (~ground) ? FALL_L : DIG_L;
                DIG_R: next_state <= (~ground) ? FALL_R : DIG_R;
                FALL_L: next_state <= (~ground) ? FALL_L : (counter > 19) ? SPLAT : LEFT;
                    //(ground && (counter != 5'b10100)) ? LEFT  : (ground && (counter >= 5'b10100)) ? SPLAT : FALL_L;
                FALL_R: next_state <= (~ground) ? FALL_R : (counter > 19) ? SPLAT : RIGHT;
                    //(ground && (counter != 5'b10100)) ? RIGHT : (ground && (counter >= 5'b10100)) ? SPLAT : FALL_R;
                SPLAT: next_state <= SPLAT;   
            endcase
        end
    
    always @ (posedge clk or posedge areset)
        begin
            if (areset) begin
                state <= LEFT;
                counter <= 0;
            end
            else
                begin
                	state <= next_state;
                    if ((state == FALL_L) || (state == FALL_R))
                		counter <= counter + 1;
                    else if (counter > 20)
                		counter <= 20;
            		else
               		    counter <= 0; 
                end
        end
     
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FALL_L || state == FALL_R);
    assign digging = (state == DIG_L || state == DIG_R);
    
endmodule
