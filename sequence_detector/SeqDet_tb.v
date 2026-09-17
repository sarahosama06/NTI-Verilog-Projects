module tb_sequence_detector;

    reg  tb_clk;
    reg  tb_rst_n;
    reg  tb_in;
    wire w_det_no_moore;
    wire w_det_o_moore;
    wire w_det_no_mealy;
    wire w_det_o_mealy;

    non_overlapping_moore uut_no_moore (
        .i_clock(tb_clk),
        .i_reset_n(tb_rst_n),
        .i_data(tb_in),
        .o_detected(w_det_no_moore)
    );

    overlapping_moore uut_o_moore (
        .i_clock(tb_clk),
        .i_reset_n(tb_rst_n),
        .i_data(tb_in),
        .o_detected(w_det_o_moore)
    );

    non_overlapping_mealy uut_no_mealy (
        .i_clock(tb_clk),
        .i_reset_n(tb_rst_n),
        .i_data(tb_in),
        .o_detected(w_det_no_mealy)
    );

    overlapping_mealy uut_o_mealy (
        .i_clock(tb_clk),
        .i_reset_n(tb_rst_n),
        .i_data(tb_in),
        .o_detected(w_det_o_mealy)
    );

    always #10 tb_clk = ~tb_clk;

    task apply_bit(input b);
        begin
            tb_in = b;
            @(negedge tb_clk);
        end
    endtask

    initial begin
        $monitor("Time=%0t | Reset=%b | Input=%b | NO_Moore=%b | O_Moore=%b | NO_Mealy=%b | O_Mealy=%b", 
                 $time, tb_rst_n, tb_in, w_det_no_moore, w_det_o_moore, w_det_no_mealy, w_det_o_mealy);
    end

    initial begin
        tb_clk   = 0;
        tb_rst_n = 0;
        tb_in    = 0;

        @(negedge tb_clk);
        tb_rst_n = 1;
        @(negedge tb_clk);

        apply_bit(1);
        apply_bit(1);
        apply_bit(0);
        apply_bit(1);
        apply_bit(0);
        apply_bit(1);
        apply_bit(1);
        apply_bit(0);
        apply_bit(1);
        apply_bit(0);
        apply_bit(1);

        #20;
        $finish;
    end

endmodule