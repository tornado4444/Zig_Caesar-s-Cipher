const std = @import("std");

fn caesarChar(c: u8, key: i8) u8 {
    if (c >= 'A' and c <= 'Z') {
        const v = @as(i8, @intCast(c - 'A'));
        return 'A' + @as(u8, @intCast(@mod(v + key, 26)));
    }
    if (c >= 'a' and c <= 'z') {
        const v = @as(i8, @intCast(c - 'a'));
        return 'a' + @as(u8, @intCast(@mod(v + key, 26)));
    }
    return c;
}

fn caesar(text: []const u8, key: i8, out: []u8) usize {
    var i: usize = 0;
    while (i < text.len) : (i += 1) {
        out[i] = caesarChar(text[i], key);
    }
    out[i] = 0;
    return i;
}

const rl = @cImport({
    @cInclude("raylib.h");
});

pub fn main() void {
    rl.InitWindow(800, 450, "Caesar Cipher (FINAL)");
    rl.SetTargetFPS(60);

    var input: [256]u8 = [_]u8{0} ** 256;
    var output: [256]u8 = [_]u8{0} ** 256;

    var len: usize = 0;
    var key: i8 = 3;
    var encrypt = true;

    while (!rl.WindowShouldClose()) {
        const ch = rl.GetCharPressed();
        if (ch >= 32 and ch <= 126 and len < 255) {
            input[len] = @as(u8, @intCast(ch));
            len += 1;
            input[len] = 0;
        }

        if (rl.IsKeyPressed(rl.KEY_BACKSPACE) and len > 0) {
            len -= 1;
            input[len] = 0;
        }

        if (rl.IsKeyPressed(rl.KEY_TAB)) {
            encrypt = !encrypt;
        }

        if (rl.IsKeyPressed(rl.KEY_ENTER)) {
            _ = caesar(
                input[0..len],
                if (encrypt) key else -key,
                &output,
            );
        }

        if (rl.IsKeyPressed(rl.KEY_ONE)) key = 1;
        if (rl.IsKeyPressed(rl.KEY_TWO)) key = 2;
        if (rl.IsKeyPressed(rl.KEY_THREE)) key = 3;
        if (rl.IsKeyPressed(rl.KEY_FOUR)) key = 4;
        if (rl.IsKeyPressed(rl.KEY_FIVE)) key = 5;
        if (rl.IsKeyPressed(rl.KEY_SIX)) key = 6;
        if (rl.IsKeyPressed(rl.KEY_SEVEN)) key = 7;
        if (rl.IsKeyPressed(rl.KEY_EIGHT)) key = 8;
        if (rl.IsKeyPressed(rl.KEY_NINE)) key = 9;

        const input_cstr: [*:0]const u8 = input[0..len :0];
        const output_len = std.mem.indexOfScalar(u8, &output, 0) orelse 0;
        const output_cstr: [*:0]const u8 = output[0..output_len :0];

        rl.BeginDrawing();
        rl.ClearBackground(rl.RAYWHITE);

        rl.DrawText("INPUT:", 20, 20, 20, rl.BLACK);
        rl.DrawText(input_cstr, 20, 50, 20, rl.DARKBLUE);

        rl.DrawText("RESULT:", 20, 100, 20, rl.BLACK);
        rl.DrawText(output_cstr, 20, 130, 20, rl.DARKGREEN);

        rl.DrawText(
            if (encrypt) "MODE: ENCRYPT (Tab)" else "MODE: DECRYPT (Tab)",
            20,
            180,
            20,
            rl.MAROON,
        );

        var buf: [32]u8 = undefined;
        const written = std.fmt.bufPrint(&buf, "KEY: {d}", .{key}) catch buf[0..0];
        buf[written.len] = 0;
        const buf_cstr: [*:0]const u8 = buf[0..written.len :0];

        rl.DrawText(buf_cstr, 20, 210, 20, rl.BLACK);
        rl.DrawText("Type text | Enter = run | 1-9 = key", 20, 260, 18, rl.GRAY);

        rl.EndDrawing();
    }

    rl.CloseWindow();
}
