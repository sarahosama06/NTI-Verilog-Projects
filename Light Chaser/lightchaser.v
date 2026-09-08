module clk_divider #(
    parameter IN_FREQ  = 50e6,
    parameter OUT_FREQ = 8
)(
    input      in_clk,
    input      reset,
    output reg out_clk
);

    localparam MAX_VALUE = (IN_FREQ / (2 * OUT_FREQ)) - 1;

    reg [21:0] counter;

    always @(posedge in_clk or negedge reset) begin
        if (!reset) begin
            counter <= 0;
            out_clk <= 0;
        end
        else if (counter == MAX_VALUE) begin
            counter <= 0;
            out_clk <= ~out_clk;
        end
        else begin
            counter <= counter + 1'b1;
        end
    end 

endmodule

module shift_register #(
    parameter N_BITS = 10
)(
    input              clk,
    input              reset,
    input              hold,
    output reg [N_BITS-1:0] shift_out
);

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            shift_out <= {1'b1, {(N_BITS-1){1'b0}}};
        end
        else if (!hold) begin
            shift_out <= shift_out;
        end
        else begin
            shift_out <= {shift_out[0], shift_out[N_BITS-1:1]};
        end
    end

endmodule

module light_chaser_top #(
    parameter IN_FREQ  = 50e6,
    parameter OUT_FREQ = 8,
    parameter N_BITS   = 10
)(
    input               in_clk,
    input               reset,
    input               hold,
    output [N_BITS-1:0] shift_out
);

wire slow_clk;

clk_divider #(
        .IN_FREQ(IN_FREQ),
        .OUT_FREQ(OUT_FREQ)
    ) u_clk_divider (
        .in_clk(in_clk),
        .reset(reset),
        .out_clk(slow_clk)
    );

shift_register #(
        .N_BITS(N_BITS)
    ) u_shift_register (
        .clk(slow_clk),
        .reset(reset),
        .hold(hold),
        .shift_out(shift_out)
);

endmodule