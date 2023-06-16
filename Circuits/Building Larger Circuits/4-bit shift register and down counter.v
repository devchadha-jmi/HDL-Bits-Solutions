module top_module (
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output [3:0] q);
    
    reg [3:0] q_des;
    
    always @ (posedge clk)
        begin
            if (!shift_ena && !count_ena)
                q_des <= q_des;
            else if (shift_ena && !count_ena)
                q_des <= {q_des[2:0], data};
            else if (!shift_ena && count_ena)
                q_des <= q_des - 4'b1;
            else
                q_des <= q_des;
        end
    
    assign q = q_des;

endmodule
