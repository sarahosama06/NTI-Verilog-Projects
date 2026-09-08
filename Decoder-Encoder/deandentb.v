module tb ;
    reg [1:0] in_dec;
    wire [3:0] y_dec;

    reg [3:0] in_enc;
    wire [1:0] y_enc;

decoder #(2) D (
    .in(in_dec),
    .y(y_dec)
);

encoder #(2) E (
    .in(in_enc),
    .y(y_enc)
);

initial begin

    $monitor("DEC: in=%b y=%b | ENC: in=%b y=%b",
             in_dec, y_dec,
             in_enc, y_enc);

    in_dec = 2'b00;
    in_enc = 4'b0001;
    #10;

    in_dec = 2'b01;
    in_enc = 4'b0010;
    #10;

    in_dec = 2'b10;
    in_enc = 4'b0100;
    #10;

    in_dec = 2'b11;
    in_enc = 4'b1000;
    #10;

    $finish;

end

endmodule
