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

    logic red, green, blue;

    logic [5:0] d;
    logic load;

    assign d = 6'b100000;
    assign load = 1'b1;

    RGB_LED u0(
        .clk    (clk),  
        .RGB_R    (red), 
        .RGB_G  (green), 
        .RGB_B   (blue)
    );

    assign RGB_R = ~red;
    assign RGB_G = ~green;
    assign RGB_B = ~blue;

endmodule
