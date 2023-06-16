module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );
/// we can implement it in many ways
/// Declare wires for all intermediate connections
/// or directly we can write the syntax for the obtained boolean expressions
    // First method of directly implementing the boolean expression for outputs.
 //   assign p1y = (p1a & p1b & p1c)|(p1d & p1e & p1f);
 //  assign p2y = (p2a & p2b)|(p2c & p2d);
    // Second Method is to declare wires for intermediates.
    wire a1; //and gate 1
    wire a2; //and gate 2
    wire a3; //and gate 3
    wire a4; //and gate 4
    and (a1, p1a, p1b, p1c);
    and (a2, p1d, p1e, p1f);
    and (a3, p2a, p2b);
    and (a4, p2c, p2d);
    or (p1y, a1, a2);
    or (p2y, a3, a4);
endmodule
