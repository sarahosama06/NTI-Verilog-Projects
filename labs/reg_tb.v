`timescale 1ns / 1ps

module tb_register;

    parameter WIDTH = 8;

    reg             clk;
    reg             rst;
    reg             load;
    reg  [WIDTH-1:0] data_in;
    wire [WIDTH-1:0] data_out;

    register #(
        .WIDTH(WIDTH)
    ) uut (
        .clk(clk),
        .rst(rst),
        .load(load),
        .data_in(data_in),
        .data_out(data_out)
    );

    always #5 clk = ~clk;

    initial begin
        $monitor("Time=%0t | rst=%b | load=%b | data_in=8'h%h | data_out=8'h%h", 
                 $time, rst, load, data_in, data_out);

        clk     = 0;
        rst     = 1;
        load    = 0;
        data_in = 8'h00;

        #10;
        rst = 0;

        #10;
        data_in = 8'hA5;
        load    = 1;

        #10;
        load    = 0;
        data_in = 8'hFF;

        #20;
        rst     = 1;

        #10;
        $finish;
    end

endmodule