module BTN_IN(
    input CLOCK_50,
    input [3:0] BIN,
    output reg [2:0] BOUT
);

reg [20:0] cnt;
wire en40hz = (cnt == 1250000-1);

always @(posedge CLOCK_50, posedge BIN[3]) begin
    if(BIN[3])
        cnt <= 21'b0;
    else if(en40hz)
        cnt <= 21'b0;
    else
        cnt <= cnt+21'b1;
end

reg [2:0] ff1, ff2;

always @(posedge CLOCK_50, posedge BIN[3]) begin
    if(BIN[3]) begin
        ff2 <= 3'b0;
        ff1 <= 3'b0;
    end
    else if(en40hz) begin
        ff2 <= ff1;
        ff1 <= BIN[2:0];
    end
end

wire [2:0] temp = ~ff1&ff2&{3{en40hz}};

always @(posedge CLOCK_50, posedge BIN[3]) begin
    if(BIN[3])
        BOUT <= 3'b0;
    else
        BOUT <= temp;
end

endmodule


