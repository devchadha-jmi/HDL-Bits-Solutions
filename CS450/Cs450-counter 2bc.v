module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);
    parameter [1:0] Weak_Not_Taken   = 2'b01,
    				Strong_Not_Taken = 2'b00,
    				Weak_Taken       = 2'b10,
    				Strong_Taken     = 2'b11;
    
    reg [1:0] counter;
    
    always @ (posedge clk or posedge areset)
        begin
            if (areset)
                counter <= Weak_Not_Taken;
            else if (train_valid == 0)
                counter <= counter;
            else if (train_valid == 1 && train_taken == 0 && counter > 2'b00)
                counter <= counter - 2'b1;
            else if (train_valid == 1 && train_taken == 0 && counter == 2'b00)
                counter <= Strong_Not_Taken;
            else if (train_valid == 1 && train_taken == 1 && counter < 2'b11)
                counter <= counter + 2'b1;
            else if (train_valid == 1 && train_taken == 1 && counter == 2'b00)
                counter <= Strong_Taken;
            else
                counter <= counter;
        end
    
    assign state = counter;

endmodule
