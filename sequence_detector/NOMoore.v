module non_overlapping_moore (
    input  i_clock,
    input  i_reset_n,
    input  i_data,
    output reg o_detected
);

    parameter ST_IDLE  = 3'd0,
              ST_BIT1  = 3'd1,
              ST_BIT2  = 3'd2,
              ST_BIT3  = 3'd3,
              ST_BIT4  = 3'd4,
              ST_BIT5  = 3'd5,
              ST_MATCH = 3'd6;

    reg [2:0] state_reg, state_next;

    always @(posedge i_clock or negedge i_reset_n) begin
        if (!i_reset_n)
            state_reg <= ST_IDLE;
        else
            state_reg <= state_next;
    end

    always @(*) begin
        case (state_reg)
            ST_IDLE:  state_next = i_data ? ST_BIT1 : ST_IDLE;
            ST_BIT1:  state_next = i_data ? ST_BIT2 : ST_IDLE;
            ST_BIT2:  state_next = i_data ? ST_BIT2 : ST_BIT3;
            ST_BIT3:  state_next = i_data ? ST_BIT4 : ST_IDLE;
            ST_BIT4:  state_next = i_data ? ST_BIT2 : ST_BIT5;
            ST_BIT5:  state_next = i_data ? ST_MATCH : ST_IDLE;
            ST_MATCH: state_next = i_data ? ST_BIT1 : ST_IDLE;
            default:  state_next = ST_IDLE;
        endcase
    end

    always @(*) begin
        o_detected = (state_reg == ST_MATCH);
    end

endmodule