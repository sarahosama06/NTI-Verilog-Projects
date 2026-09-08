module fulladdergl (
    input [1:0] a, b,
    input cin,
    output [1:0] s,
    output cout
);

wire w1_0, w2_0, w3_0;
wire w1_1, w2_1, w3_1;
wire c1;

xor(w1_0, a[0], b[0]);
and(w2_0, a[0], b[0]);
xor(s[0], w1_0, cin);
and(w3_0, w1_0, cin);
or(c1, w2_0, w3_0);

xor(w1_1, a[1], b[1]);
and(w2_1, a[1], b[1]);
xor(s[1], w1_1, c1);
and(w3_1, w1_1, c1);
or(cout, w2_1, w3_1);

endmodule


module halfadderst (
    input a, b,
    output s, c
);

assign s = a ^ b;
assign c = a & b;

endmodule


module fulladder1bit (
    input a, b, cin,
    output s, cout
);

wire w1, w2, w3;

halfadderst f1 (
    .a(a),
    .b(b),
    .s(w1),
    .c(w2)
);

halfadderst f2 (
    .a(w1),
    .b(cin),
    .s(s),
    .c(w3)
);

or(cout, w2, w3);

endmodule


module fulladderst (
    input [1:0] a, b,
    input cin,
    output [1:0] s,
    output cout
);

wire c1;

fulladder1bit f1 (
    .a(a[0]),
    .b(b[0]),
    .cin(cin),
    .s(s[0]),
    .cout(c1)
);

fulladder1bit f2 (
    .a(a[1]),
    .b(b[1]),
    .cin(c1),
    .s(s[1]),
    .cout(cout)
);

endmodule


module fulladderbh (
    input [1:0] a, b,
    input cin,
    output [1:0] s,
    output cout
);

assign {cout, s} = a + b + cin;

endmodule
