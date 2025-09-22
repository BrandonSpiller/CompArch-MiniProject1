`include "RGB_LED.sv"

// RGB_LED top level

module top(
    input logic     clk, 
    input logic     SW,
    input logic     BOOT, 
    output logic    RGB_R, 
    output logic    RGB_G, 
    output logic    RGB_B
);

    logic red, green, blue; //What does this line do in the example?
    logic [5:0] d;
    logic [5:0] q;
    logic load;
    logic south;

    initial begin
        d = 6'b100000;
    end

    shiftreg #(.N(6)) u0(
        .clk    (clk),
        .reset  (~BOOT),
        .load   (load),
        .sin    (1'b0),
        .d      (d),
        .q      (q),
        .south  (south)
    );

    //do I need to deifne it?
    RGB_LED u1(
        .clk    (clk), 
        .q      (q),
        .red    (red), 
        .green  (green), 
        .blue   (blue)
    );

    assign RGB_R = ~red;
    assign RGB_G = ~green;
    assign RGB_B = ~blue;

endmodule
