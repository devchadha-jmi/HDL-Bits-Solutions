// synthesis verilog_input_version verilog_2001
module top_module (
    input [7:0] in,
    output reg [2:0] pos  );

    always @ (*)
        casez (in [7:0])
            8'bzzzzzzz1 :
                pos = 3'b000;
            8'bzzzzzz1z :
                pos = 3'b001;
            8'bzzzzz1zz :
                pos = 3'b010;
            8'bzzzz1zzz :
                pos = 3'b011;
            8'bzzz1zzzz :
                pos = 3'b100;
            8'bzz1zzzzz :
                pos = 3'b101;
            8'bz1zzzzzz :
                pos = 3'b110;
            8'b1zzzzzzz :
                pos = 3'b111;
            default :
                pos = 3'b000;
        endcase
endmodule
