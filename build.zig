const std = @import("std");
const builtin = @import("builtin");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "basix",
        .root_source_file = b.path("src/main.zig"),
        .target = b.graph.host,
    });
    b.installArtifact(exe);

    // use a specific e-reader, in this case ESPEAK-NG
    exe.linkLibC();
    exe.linkSystemLibrary("espeak-ng");

    const run_exe = b.addRunArtifact(exe);
    const run_step = b.step("run", "run the app");
    run_step.dependOn(&run_exe.step);
}
