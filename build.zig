const std = @import("std");
const builtin = @import("builtin");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "basix",
        .root_source_file = b.path("src/main.zig"),
        .target = b.graph.host,
    });
    b.installArtifact(exe);

    if (builtin.target.os.tag == .windows) {
        exe.linkLibC();
        exe.addIncludePath(.{ .cwd_relative = "espeak-ng/src/include/" });
        exe.addLibraryPath(.{ .cwd_relative = "espeak-ng/build/src/libespeak-ng/Debug/" });

        exe.linkSystemLibrary("espeak-ng");
        exe.linkSystemLibrary("msvcrt");
    } else {
        exe.linkLibC();
        exe.linkSystemLibrary("espeak-ng");
    }
}
