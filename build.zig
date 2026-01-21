const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "caesar",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    exe.linkLibC();

    exe.addIncludePath(.{
        .path = "libraries/raylib-5.5_win64_mingw-w64/include",
    });

    exe.addIncludePath(.{
        .path = "libraries/raygui/src",
    });

    exe.addObjectFile(.{
        .path = "libraries/raylib-5.5_win64_mingw-w64/lib/libraylib.a",
    });

    exe.linkSystemLibrary("winmm");
    exe.linkSystemLibrary("gdi32");
    exe.linkSystemLibrary("opengl32");

    b.installArtifact(exe);
}
