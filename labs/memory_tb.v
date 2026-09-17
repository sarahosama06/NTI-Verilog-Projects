`timescale 1ns / 1ps

module tb_memory;

    parameter AWIDTH = 5;
    parameter DWIDTH = 8;

    reg                clk;
    reg                wr;
    reg                rd;
    reg  [AWIDTH-1:0]  addr;
    wire [DWIDTH-1:0]  data;

    reg  [DWIDTH-1:0]  data_driver;
    reg                drive_en;

    assign data = drive_en ? data_driver : {DWIDTH{1'bz}};

    memory #(
        .AWIDTH(AWIDTH),
        .DWIDTH(DWIDTH)
    ) uut (
        .clk(clk),
        .wr(wr),
        .rd(rd),
        .addr(addr),
        .data(data)
    );

    always #5 clk = ~clk;

    task write_mem(
        input [AWIDTH-1:0] w_addr,
        input [DWIDTH-1:0] w_data
    );
        begin
            @(posedge clk);
            addr        = w_addr;
            data_driver = w_data;
            drive_en    = 1'b1;
            wr          = 1'b1;
            rd          = 1'b0;
            @(posedge clk);
            wr          = 1'b0;
            drive_en    = 1'b0;
        end
    endtask

    task read_mem(
        input  [AWIDTH-1:0] r_addr,
        output [DWIDTH-1:0] r_data
    );
        begin
            @(posedge clk);
            addr     = r_addr;
            drive_en = 1'b0;
            wr       = 1'b0;
            rd       = 1'b1;
            @(posedge clk);
            r_data   = data;
            rd       = 1'b0;
        end
    endtask

    reg [DWIDTH-1:0] read_val;

    initial begin
        clk         = 0;
        wr          = 0;
        rd          = 0;
        addr        = 0;
        drive_en    = 0;
        data_driver = 0;

        #10;

        write_mem(5'd5, 8'hA5);
        read_mem(5'd5, read_val);

        write_mem(5'd10, 8'h3C);
        read_mem(5'd10, read_val);

        #20;
        $finish;
    end

endmodule
