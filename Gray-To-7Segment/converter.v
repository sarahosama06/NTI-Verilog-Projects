`timescale 1ns/1ps

module Gray2bin #( parameter n = 4 )(
    input  wire [n-1:0] in_g,
    output wire [n-1:0] out_b 
);

    assign out_b[n-1] = in_g[n-1];
    
    genvar i;
    generate
        for (i = n-2; i >= 0; i = i - 1) begin : g_xor_chain
            xor (out_b[i], out_b[i+1], in_g[i]);
        end
    endgenerate

endmodule

module bin2seven (
    input  wire [3:0] in_b,
    output reg  [6:0] out_s
);

    always @(*) begin
        case (in_b)
            4'b0000: out_s = 7'b0000001;
            4'b0001: out_s = 7'b1001111;
            4'b0010: out_s = 7'b0010010;
            4'b0011: out_s = 7'b0000110;
            4'b0100: out_s = 7'b1001100;
            4'b0101: out_s = 7'b0100100;
            4'b0110: out_s = 7'b0100000;
            4'b0111: out_s = 7'b0001111;
            4'b1000: out_s = 7'b0000000;
            4'b1001: out_s = 7'b0000100;
            4'b1010: out_s = 7'b0001000;
            4'b1011: out_s = 7'b1100000;
            4'b1100: out_s = 7'b0110001;
            4'b1101: out_s = 7'b1000010;
            4'b1110: out_s = 7'b0110000;
            4'b1111: out_s = 7'b0111000;
            default: out_s = 7'b1111111;
        endcase
    end

endmodule

module top #(parameter n = 4)(
    input  wire [n-1:0] in_gray,
    output wire [6:0]   out_seven
);

    wire [n-1:0] bin_net;

    Gray2bin #(.n(n)) u_gray2bin (
        .in_g(in_gray),
        .out_b(bin_net)
    );

    bin2seven u_bin2seven (
        .in_b(bin_net),
        .out_s(out_seven)
    );

endmodule
