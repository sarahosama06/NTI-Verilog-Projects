module fulladdertb;

reg [1:0] atb, btb;
reg cintb;

wire [1:0] s_gl, s_st, s_bh;
wire cout_gl, cout_st, cout_bh;

fulladdergl GL (
    .a(atb),
    .b(btb),
    .cin(cintb),
    .s(s_gl),
    .cout(cout_gl)
);

fulladderst ST (
    .a(atb),
    .b(btb),
    .cin(cintb),
    .s(s_st),
    .cout(cout_st)
);

fulladderbh BH (
    .a(atb),
    .b(btb),
    .cin(cintb),
    .s(s_bh),
    .cout(cout_bh)
);

initial begin

    $monitor("Time=%0t | a=%b b=%b cin=%b | GL: s=%b cout=%b | ST: s=%b cout=%b | BH: s=%b cout=%b",
             $time, atb, btb, cintb,
             s_gl, cout_gl,
             s_st, cout_st,
             s_bh, cout_bh);

    atb = 2'b00; btb = 2'b00; cintb = 0;
    #10;

    atb = 2'b00; btb = 2'b01; cintb = 0;
    #10;

    atb = 2'b01; btb = 2'b01; cintb = 0;
    #10;

    atb = 2'b01; btb = 2'b10; cintb = 0;
    #10;

    atb = 2'b10; btb = 2'b10; cintb = 0;
    #10;

    atb = 2'b11; btb = 2'b01; cintb = 0;
    #10;

    atb = 2'b11; btb = 2'b11; cintb = 0;
    #10;

    atb = 2'b11; btb = 2'b11; cintb = 1;
    #10;

    $stop;

end

endmodule
