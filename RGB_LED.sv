// RGB LED controlled by shift register

module shiftreg # (parameter N = 6) //page 272 of textbook
    (input logic    clk,
    input logic     reset, load,
    input logic     sin,
    input logic     [N-1:0] d,
    output logic    [N-1:0] q,
    output logic    south
);

always_ff @(posedge clk, posedge reset)
    if (reset) 
        q <= 0;
    else if (load) 
        q <= d;
    //looping shift register
    else 
        q <= {q[N-2:0], q[N-1]};

    assign south = q[N-1];
endmodule

module RGB_LED(
    input logic     clk,
    input logic     rst,
    input logic [5:0] q, //shift register output
    output logic    RGB_R,
    output logic    RGB_G,
    output logic    RGB_B,
);
endmodule

always_comb begin
        RGB_R = 1;
        RGB_G = 1;
        RGB_B = 1;

    if (q[0]) begin //RED 
        RGB_R = 0;
        RGB_G = 1;
        RGB_B = 1;
    end else if (q[1]) begin //YELLOW
        RGB_R = 0;
        RGB_G = 0;
        RGB_B = 1;
    end else if (q[2]) begin //GREEN
        RGB_R = 1;
        RGB_G = 0;
        RGB_B = 1;
    end else if (q[3]) begin //CYAN
        RGB_R = 1;
        RGB_G = 0;
        RGB_B = 0;
    end else if (q[4]) begin //BLUE
        RGB_R = 1;
        RGB_G = 1;
        RGB_B = 0;
    end else if (q[5]) begin //MAGENTA
        RGB_R = 0;
        RGB_G = 1;
        RGB_B = 0;
    end
end
