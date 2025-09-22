// RGB LED controlled by shift register

module shiftreg # 
    (parameter N = 6) //page 272 of textbook
    (input logic    clk,
    input logic     reset, 
    input logic     load,
    input logic     sin,
    input logic     [N-1:0] d,
    output logic    [N-1:0] q,
    output logic    south
);  
    parameter BLINK_INTERVAL = 2000000;
    logic [$clog2(BLINK_INTERVAL) - 1:0] count = 0;

    always_ff @(posedge clk, posedge reset) begin
            if (reset) begin
                count <= 0;
                q <= 6'b100000; // Load initial pattern on reset
            end else begin
                if (count == BLINK_INTERVAL - 1) begin
                    count <= 0;
                    if (load)
                        q <= d;
                    else
                        q <= {q[N-2:0], q[N-1]}; // Rotate left
                end else begin
                    count <= count + 1;
                end
            end
        end

        assign south = q[N-1];
endmodule

module RGB_LED(
    input logic     clk,
    input logic     rst,
    input logic [5:0] q, //shift register output
    output logic    red,
    output logic    green,
    output logic    blue
);

always @(*) begin
        red = 1;
        green = 1;
        blue = 1;


    if (q[0]) begin //RED 
        red = 0;
        green = 1;
        blue = 1;
    end else if (q[1]) begin //YELLOW
        red = 0;
        green = 0;
        blue = 1;
    end else if (q[2]) begin //GREEN
        red = 1;
        green = 0;
        blue = 1;
    end else if (q[3]) begin //CYAN
        red = 1;
        green = 0;
        blue = 0;
    end else if (q[4]) begin //BLUE
        red = 1;
        green = 1;
        blue = 0;
    end else if (q[5]) begin //MAGENTA
        red = 0;
        green = 1;
        blue = 0;
    end
end
endmodule