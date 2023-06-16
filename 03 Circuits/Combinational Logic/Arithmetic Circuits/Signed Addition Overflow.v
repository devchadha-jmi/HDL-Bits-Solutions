module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
); //
 
    //Isi ka ek question hmne copy me solve kiya h check that fir reference
    assign s = a + b;
    assign overflow = (((a[7]&b[7]&(~s[7])) | ((~a[7])&(~b[7])&s[7])) == 1'b1)?1:0;

endmodule
