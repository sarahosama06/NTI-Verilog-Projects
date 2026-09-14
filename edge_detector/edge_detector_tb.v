`timescale 1ns/1ps

module tb_edge_detectors;

    reg clk;
    reg reset_n;
    reg level;

    wire tick_moore;
    wire tick_mealy;

    edge_detector_moore uut_moore (
        .clk(clk),
        .reset_n(reset_n),
        .level(level),
        .tick(tick_moore)
    );

    edge_detector_mealy uut_mealy (
        .clk(clk),
        .reset_n(reset_n),
        .level(level),
        .tick(tick_mealy)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset_n = 0;
        level = 0;

        #12 reset_n = 1;

        #8  level = 1;
        #30 level = 0;

        #20 level = 1;
        #20 level = 0;

        #20 $finish;
    end

    initial begin
        $monitor("Time=%0t | clk=%b | level=%b | tick_moore=%b | tick_mealy=%b", $time, clk, level, tick_moore, tick_mealy);
    end

endmodule
