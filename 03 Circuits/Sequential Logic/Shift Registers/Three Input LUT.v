module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output reg Z ); 
    
    reg [7:0]RAM;
    
    always @ (posedge clk)
        begin
            if (enable)
                RAM <= {RAM[6:0], S};
            else
                RAM <= RAM;
        end
    
    always @ (A or B or C)
        begin
            case ({A,B,C})
                3'b000: Z <= RAM[0];
                3'b001: Z <= RAM[1];
                3'b010: Z <= RAM[2];
                3'b011: Z <= RAM[3];
                3'b100: Z <= RAM[4];
                3'b101: Z <= RAM[5];
                3'b110: Z <= RAM[6];
                3'b111: Z <= RAM[7];
                default Z <= RAM[0];
            endcase
        end

endmodule
