module edge_detector_moore (
    input  wire clk,
    input  wire reset_n,
    input  wire level,
    output reg  tick
);

    localparam S0 = 2'b00,
               S1 = 2'b01,
               S2 = 2'b10;

    reg [1:0] current_state, next_state;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    always @(*) begin
        case ({current_state, level})
            {S0, 1'b0}: next_state = S0;
            {S0, 1'b1}: next_state = S1;
            {S1, 1'b0}: next_state = S0;
            {S1, 1'b1}: next_state = S2;
            {S2, 1'b0}: next_state = S0;
            {S2, 1'b1}: next_state = S2;
            default:    next_state = S0;
        endcase
    end

    always @(*) begin
        tick = (current_state == S1) ? 1'b1 : 1'b0;
    end

endmodule
