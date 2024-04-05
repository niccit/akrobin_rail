// SPDX-License-Identifier: MIT

// A modularized way to hang my Akrobins. I didn't need the big metal louvered hangers available.

use <catchnhole/catchnhole.scad>;  // mmalecki - https://github.com/mmalecki/catchnhole
include <JointSCAD/dist/JointSCAD.scad>;

$fa = 1;
$fs = 0.4;

cube_l = 219;
cube_w = 10;
cube_h = 70;

show_mounting = true;

module rail() {
    cube([(l - 10), 8, 10], center=true);
}

module backplate(l=cube_l, w=cube_w, h=cube_h, show=show_mounting) {
    union() {
        difference() {
            cube([l, w, h], center=true);
            // hanger
            translate([0, -1, 30.25])
                cube([(l - 10), 8, 10], center=true);
            translate([0, -1, -30.25])
                cube([(l - 10), 8, 10], center=true);
            if (show == true) {
                // mounting holes
                translate([60, -6.75, 0])
                    rotate([-90, 0, 0])
                        bolt("M5", 12, kind = "countersunk", countersink = 1);
                translate([-60, -6.75, 0])
                    rotate([-90, 0, 0])
                        bolt("M5", 12, kind = "countersunk", countersink = 1);
            }
        }
        translate([118 - 0.001, -5, 15])
            connector_left();
        translate([-103 - 0.001, -5, 15])
            connector_right();
    }
}

module connector_left(l=10, w=cube_w, h=50) {
    translate([-6, 5, 11])
        cube([10, cube_w, 18], center=true);
    translate([-6, 5, -43])
        cube([10, cube_w, 14], center=true);
    rotate([0, 90, 90])
        dovetailJointA([35, 15, 10], 3);
}

module connector_right() {
    rotate([0, 90, 90])
    dovetailJointB([35, 15, 10], 3);
}

// --- Printing --- //

backplate();

// uncomment to see how the two fit together
// translate([-(cube_l / 2) - 116.5, 0, 0])
//     backplate();

