module edge_detector_mealy (
    input  wire clk,
    input  wire reset_n,
    input  wire level,
    output reg  tick
);

    localparam S0 = 1'b0,
               S1 = 1'b1;

    reg current_state, next_state;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    always @(*) begin
        case ({current_state, level})
            {S0, 1'b0}: {next_state, tick} = {S0, 1'b0};
            {S0, 1'b1}: {next_state, tick} = {S1, 1'b1};
            {S1, 1'b0}: {next_state, tick} = {S0, 1'b0};
            {S1, 1'b1}: {next_state, tick} = {S1, 1'b0};
            default:    {next_state, tick} = {S0, 1'b0};
        endcase
    end

endmodule
