`timescale 1ns / 1ps

module tb_counter;

    parameter WIDTH = 5;

    reg             clk;
    reg             rst;
    reg             load;
    reg             enab;
    reg  [WIDTH-1:0] cnt_in;
    wire [WIDTH-1:0] cnt_out;

    counter #(
        .WIDTH(WIDTH)
    ) uut (
        .clk(clk),
        .rst(rst),
        .load(load),
        .enab(enab),
        .cnt_in(cnt_in),
        .cnt_out(cnt_out)
    );

    always #5 clk = ~clk;

    initial begin
        $monitor("Time=%0t | rst=%b | load=%b | enab=%b | cnt_in=%d | cnt_out=%d", 
                 $time, rst, load, enab, cnt_in, cnt_out);

        clk    = 0;
        rst    = 1;
        load   = 0;
        enab   = 0;
        cnt_in = 0;

        #10;
        rst = 0;

        #10;
        cnt_in = 5'd15;
        load   = 1;

        #10;
        load   = 0;
        enab   = 1;

        #30;
        enab   = 0;

        #10;
        rst    = 1;

        #10;
        $finish;
    end

endmodule