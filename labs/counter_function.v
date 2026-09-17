module counter #(
    parameter WIDTH = 5
)(
    input  wire             clk,
    input  wire             rst,
    input  wire             load,
    input  wire             enab,
    input  wire [WIDTH-1:0] cnt_in,
    output reg  [WIDTH-1:0] cnt_out
);

    function [WIDTH-1:0] next_count;
        input rst_in;
        input load_in;
        input enab_in;
        input [WIDTH-1:0] current_cnt;
        input [WIDTH-1:0] in_cnt;
        begin
            if (rst_in)
                next_count = {WIDTH{1'b0}};
            else if (load_in)
                next_count = in_cnt;
            else if (enab_in)
                next_count = current_cnt + 1'b1;
            else
                next_count = current_cnt;
        end
    endfunction

    always @(posedge clk) begin
        cnt_out <= next_count(rst, load, enab, cnt_out, cnt_in);
    end

endmodule
