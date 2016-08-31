module updown_counter(
    input CLOCK_50,
    input [3:0] SW,
    output reg [6:0] HEX2
);

wire reset, down, up;
BTN_IN BTN_IN(CLOCK_50, SW, {reset, down, up});

reg [3:0] udcnt;
always @(posedge CLOCK_50, posedge SW[3]) begin
    if(SW[3])
        udcnt <= 4'h0;
    else if(reset)
        udcnt <= 4'h0;
    else if(up)
        udcnt <= udcnt+4'h1;
    else if(down)
        udcnt <= udcnt-4'h1;
end

always @* begin
    case(udcnt)
        4'h0:    HEX2 = 7'b1000000;
        4'h1:    HEX2 = 7'b1111001;
        4'h2:    HEX2 = 7'b0100100;
        4'h3:    HEX2 = 7'b0110000;
        4'h4:    HEX2 = 7'b0011001;
        4'h5:    HEX2 = 7'b0010010;
        4'h6:    HEX2 = 7'b0000010;
        4'h7:    HEX2 = 7'b1011000;
        4'h8:    HEX2 = 7'b0000000;
        4'h9:    HEX2 = 7'b0010000;
        4'ha:    HEX2 = 7'b0001000;
        4'hb:    HEX2 = 7'b0000011;
        4'hc:    HEX2 = 7'b1000110;
        4'hd:    HEX2 = 7'b0100001;
        4'he:    HEX2 = 7'b0000110;
        4'hf:    HEX2 = 7'b0001110;
        default: HEX2 = 7'bxxxxxxx;
    endcase
end

endmodule
