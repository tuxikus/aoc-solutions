const std = @import("std");

const input =
    \\162,817,812
    \\57,618,57
    \\906,360,560
    \\592,479,940
    \\352,342,300
    \\466,668,158
    \\542,29,236
    \\431,825,988
    \\739,650,466
    \\52,470,668
    \\216,146,977
    \\819,987,18
    \\117,168,530
    \\805,96,715
    \\346,949,466
    \\970,615,88
    \\941,993,340
    \\862,61,35
    \\984,92,344
    \\425,690,689
;

const JunctionBox = struct {
    x: i32,
    y: i32,
    z: i32,
};

fn parseInput(in: []const u8, arr: []JunctionBox) !void {
    var it = std.mem.splitScalar(u8, in, '\n');
    var c: usize = 0;
    while (it.next()) |x| {
        var elemIter: i32 = 0;
        var localX: i32 = 0;
        var localY: i32 = 0;
        var localZ: i32 = 0;

        var lineIt = std.mem.splitScalar(u8, x, ',');
        while (lineIt.next()) |y| {
            switch (elemIter) {
                0 => localX = try std.fmt.parseInt(i32, y, 10),
                1 => localY = try std.fmt.parseInt(i32, y, 10),
                2 => localZ = try std.fmt.parseInt(i32, y, 10),
                else => {},
            }
            elemIter += 1;

            std.debug.print("Element: {s}\n", .{y});
        }
        arr[c] = JunctionBox{
            .x = localX,
            .y = localY,
            .z = localZ,
        };
        c += 1;
    }
}

fn calculateDistance(a: JunctionBox, b: JunctionBox) i32 {
    return std.math.absInt(a.x - b.x) + std.math.absInt(a.y - b.y) + std.math.absInt(a.z - b.z);
}

pub fn main() !void {
    var junctionBoxes: [20]JunctionBox = undefined;
    var connectedBoxes: [100][20]JunctionBox = undefined;

    try parseInput(input, &junctionBoxes);
    var i: usize = 0;
    for (junctionBoxes) |jb| {
        var shortestDistance: i32 = 1000000;
        var shortestDistanceIndex: usize = 0;
        for (junctionBoxes) |jb2| {
            if (calculateDistance(jb, jb2) < shortestDistance) {
                shortestDistance = calculateDistance(jb, jb2);
                shortestDistanceIndex = i;
            }
        }
        i += 1;
    }
}
