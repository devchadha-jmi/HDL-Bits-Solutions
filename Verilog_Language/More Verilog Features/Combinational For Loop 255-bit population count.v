module top_module( 
    input [254:0] in,
    output [7:0] out );



    // $bits(in)
    // In case the vector width is not provided in the problem statement, 
    // We use the above ommand to calculate the vector width.
    reg [7:0]counter1;
    // Counter1 needs to be updated everytime
    //Hence the value 8'b0 has been assigned to it everytime the always block executes
    always @ (*)
        begin
            counter1 = 8'b0;
            for(int i =0; i<$bits(in); i++)
                begin
                    if(in[i])
                        counter1 = counter1 + 1;
                    else
                        counter1 = counter1;
                end
        end
    assign out[7:0] = counter1[7:0];
endmodule
