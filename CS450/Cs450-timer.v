module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
    reg [9:0]count;
    always @ (posedge clk)
        begin
            if(load)
                begin
                	count <= data;
                end
            else if (~load && count != 10'b0)
                begin
                	count <= count - 10'b1;
        		end
            else if (count == 10'b0)
                begin
                    count <= count;
                end
        end
    
    assign tc = (count == 10'b0);

endmodule
