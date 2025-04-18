const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "basix",
        .root_source_file = b.path("src/main.zig"),
        .target = b.graph.host,
    });
    b.installArtifact(exe);

    exe.linkLibC();

    exe.linkSystemLibrary("espeak-ng");
	//exe.linkSystemLibrary("pcaudio");
	//exe.linkSystemLibrary("sonic");
}
