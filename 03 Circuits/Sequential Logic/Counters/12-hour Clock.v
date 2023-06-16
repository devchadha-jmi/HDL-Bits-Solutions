module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);
    
    wire one_min  = (ss[7:4] == 4'd5 && ss[3:0] == 4'd9) ? 1 : 0;
    wire one_hour = (ss[7:4] == 4'd5 && ss[3:0] == 4'd9 && mm[7:4] == 4'd5 && mm[3:0] == 4'd9) ? 1 : 0;
    
    counter_sec  instance1 (clk, reset, ena, ss);
    counter_min  instance2 (clk, reset, ena, one_min, mm);
    counter_hour instance3 (clk, reset, ena, one_hour, hh);
    
        always @ (posedge clk)
        begin
            if (reset)
                pm <= 1'b0;
            else
                if (ena)
                pm <= (hh == 8'h11 && mm == 8'h59 && ss == 8'h59)? ~pm : pm;;
        end

endmodule

module counter_sec(input clk,
                   input reset,
                   input ena,
                   output reg [7:0] ss);
    
    always @ (posedge clk)
        begin
            if (reset)
                ss <= 8'd00;
            else if (ena)
                begin
                    if (ss[7:4] == 4'd5 && ss[3:0] == 4'd9)
                        ss <= 8'd00;
                    else if (ss[3:0] == 4'd9)
                        begin
                        	ss[3:0] <= 8'd0;
                            ss[7:4] <= ss[7:4] + 4'd1;
                        end
                    else
                        ss [3:0] <= ss[3:0] + 4'd1;
                end
        end 
endmodule

module counter_min(input clk,
                   input reset,
                   input ena,
                   input one_min,
                   output reg [7:0] mm
                  );
    
    always @ (posedge clk)
        begin
            if (reset)
                mm <= 8'd00;
            else if (ena)
                begin
                    if (mm == 8'd59 && one_min)
                        mm <= 8'd00;
                    else if (one_min)
                        begin
                            if (mm[7:4] == 4'd5 && mm[3:0] == 4'd9)
                                mm <= 8'd00;
                            else if (mm[3:0] == 4'd9)
                                begin
                                    mm[7:4] <= mm[7:4] + 4'd01;
                                    mm[3:0] <= 4'd0;
                                end
                        	else
                                mm[3:0] <= mm[3:0] + 4'd01;
                        end
                    else
                        mm <= mm;
                end
        end 
endmodule

module counter_hour(input clk,
                    input reset,
                    input ena,
                    input one_hour,
                    output reg [7:0] hh
                   );
    
    always @ (posedge clk)
        begin
            if (reset) begin
                hh[3:0] <= 4'd2;
                hh[7:4] <= 4'd1;
            end
            else if (ena)
                begin
                    if (hh[7:4] == 4'd1 && hh[3:0] == 4'd2 && one_hour)
                        hh <= 8'd01;
                    else if (one_hour)
                        begin
                            if (hh == 8'd12)
                                hh <= 8'd01;
                           else if (hh[3:0] == 4'd9)
                                begin
                                    hh[7:4] <= hh[7:4] + 4'd01;
                                    hh[3:0] <= 4'd0;
                                end
                        	else
                                hh[3:0] <= hh[3:0] + 4'd01;
                        end
                    else
                        hh <= hh;
                end
        end 
endmodule
