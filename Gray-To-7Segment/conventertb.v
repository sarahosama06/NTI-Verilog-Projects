`timescale 1ns/1ps

module top_tb;

    parameter n = 4;

    reg  [n-1:0] tb_in_gray;
    wire [6:0]   tb_out_seven;

    top #(.n(n)) uut (
        .in_gray(tb_in_gray),
        .out_seven(tb_out_seven)
    );

    integer k;

    initial begin
             $monitor("Time = %0t | Gray Input = %b | Seven-Segment Output = %b", $time, tb_in_gray, tb_out_seven);

        tb_in_gray = 0;
        #10;

        for (k = 0; k < 16; k = k + 1) begin
            tb_in_gray = k;
            #10;
        end

        $finish;
    end

endmodule
