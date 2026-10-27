module chess_fsm (
input clk_i,
input rst_n_i,
input start_i,
input pause_i,
input buton_A_i,
input buton_B_i,
input mod_functionare,
input flag_A_i,
input flag_B_i,

output reg enable_A_o,
output reg enable_B_o,
output reg add_increment_A_o,
output reg add_increment_B_o,
output reg load_o,
output reg game_over_o
);

endmodule
reg [2:0] status;
reg [2:0] status_urmator;


localparam [2:0]
    IDLE      = 3'd0,
    START     = 3'd1,
    PLAYER_A  = 3'd2,
    PLAYER_B  = 3'd3,
    PAUSE_A   = 3'd4,
    PAUSE_B   = 3'd5,
    GAME_OVER = 3'd6;

reg [2:0] status;
reg [2:0] status_urmator;

// Registrul de stare
always @(posedge clk_i or negedge rst_n_i) begin
    if (!rst_n_i)
        status <= IDLE;
    else
        status <= status_urmator;
end

// Logica de tranzitie
always @(*) begin

    status_urmator = status;

    case (status)

        IDLE: begin
            status_urmator = START;
        end

        START: begin
            if (start_i)
                status_urmator = PLAYER_A;
        end

        PLAYER_A: begin
            if (flag_A_i)
                status_urmator = GAME_OVER;
            else if (pause_i)
                status_urmator = PAUSE_A;
            else if (buton_A_i)
                status_urmator = PLAYER_B;
        end

        PLAYER_B: begin
            if (flag_B_i)
                status_urmator = GAME_OVER;
            else if (pause_i)
                status_urmator = PAUSE_B;
            else if (buton_B_i)
                status_urmator = PLAYER_A;
        end

        PAUSE_A: begin
            if (pause_i)
                status_urmator = PLAYER_A;
        end

        PAUSE_B: begin
            if (pause_i)
                status_urmator = PLAYER_B;
        end

        GAME_OVER: begin
            status_urmator = GAME_OVER;
        end

        default: begin
            status_urmator = IDLE;
        end

    endcase

end


endmodule