module top_module (
    input a,
    input b,
    input c,
    input d,
    output q );//

    assign q = a&d | a&c | b&c | b&d; // Fix me

endmodule
