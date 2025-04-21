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
<<<<<<< HEAD

        exe.addLibraryPath(std.Build.path(
            b,
            "./espeak-ng/build/src/libespeak-ng/Debug/",
        ));
=======
        exe.addLibraryPath(.{
            .cwd_relative = "./espeak-ng/build/src/libespeak-ng/Debug/",
        });
>>>>>>> e9855ab6b4da7677d97da390172a6e1568f42dc7
        exe.linkSystemLibrary("espeak-ng");
    } else {
        exe.linkLibC();
        exe.linkSystemLibrary("espeak-ng");
    }
}
