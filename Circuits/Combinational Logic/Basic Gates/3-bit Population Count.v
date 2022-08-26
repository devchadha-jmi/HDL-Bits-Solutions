module top_module( 
    input [2:0] in,
    output [1:0] out );

    reg [1:0]counter;
    always @ (*)
        begin
         counter = 2'b00;
            for(int i = 0; i<3 ; i++)
                begin
                if(in[i])
                    counter++;     
               else
                counter = counter;
                end
        end
    assign out = counter;
    
endmodule
