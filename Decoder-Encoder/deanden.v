module decoder #(parameter n = 2) (
    input [n-1:0] in,
    output reg [(2**n)-1:0] y
);

integer i;

always @(*) begin
    y = 0;

    for (i = 0; i < 2**n; i = i+1) begin
        if (in == i)
            y[i] = 1;
    end
end

endmodule


module encoder #(parameter n = 2) (
    input [(2**n)-1:0] in,
    output reg [n-1:0] y
);

integer i;

always @(*) begin
    y = 0;

    for (i = 0; i < 2**n; i= i+1 ) begin
        if (in[i] == 1)
            y = i;
    end
end

endmodule
