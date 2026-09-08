`timescale 1ns / 1ps

module tb_light_chaser;

    reg        in_clk;
    reg        reset;
    reg        hold;
    wire [9:0] shift_out;

    light_chaser_top #(
        .IN_FREQ(10),
        .OUT_FREQ(1),
        .N_BITS(10)
    ) dut (
        .in_clk(in_clk),
        .reset(reset),
        .hold(hold),
        .shift_out(shift_out)
    );

    always #10 in_clk = ~in_clk;

    initial begin
        $monitor("Time = %0t | reset = %b | counter = %0d | slow_clk = %b | shift_out = %b | hold = %b", 
                 $time, reset, dut.u_clk_divider.counter, dut.slow_clk, shift_out, hold);

        in_clk = 0;
        reset  = 0;
        hold   = 1;
        #25;

        reset = 1;
        #200;

        hold = 0;
        #100;

        hold = 1;
        #200;

        $finish;
    end

endmodule
