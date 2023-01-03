module top_module (
    input [7:0] code,
    output reg [3:0] out,
    output reg valid = 1 );//

     always @(*)
         begin
             valid = 1;          //this is necessary upar 1 karne se no fayda
        case (code)
            8'h45: out = 0;
            8'h16: out = 1;
            8'h1e: out = 2;
            8'h26: out = 3;       //yaha 8'd26 tha
            8'h25: out = 4;
            8'h2e: out = 5;
            8'h36: out = 6;
            8'h3d: out = 7;
            8'h3e: out = 8;
            8'h46: out = 9;
            default: begin out = 0; valid = 0; end   //yaha default m out 0 nhi tha
        endcase
         end
endmodule
