module top_module (
    input clk,
    input w, R, E, L,
    output reg Q
);
    reg wire_mux_to_ff;
    always @ (*)
        begin
            wire_mux_to_ff <= L ? R : (E ? w : Q);
        end
    always @ (posedge clk)
        begin
            Q <= wire_mux_to_ff;
        end

endmodule
