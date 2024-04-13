// SPDX-License-Identifier: MIT // A modularized way to hang my Akrobins. I didn't need the big metal louvered hangers available.

use <catchnhole/catchnhole.scad>;  // mmalecki - https://github.com/mmalecki/catchnhole
use <pin_connectors/pin_joints.scad>;  // tbuser - https://github.com/tbuser/pin_connectors

$fa = 1;
$fs = 0.4;

cube_l = 219.5;
cube_w = 10;
cube_h = 70;

use_mounting_holes = true;
use_connecting_holes = true;
show_all = false;
show_backplate=true;
show_pin=false;

module rail() {
    cube([(l - 10), 8, 10], center=true);
}

module backplate(l=cube_l, w=cube_w, h=cube_h, mounting_holes=use_mounting_holes) {
    difference() {
        cube([l, w, h], center = true);
        // hanger
        translate([0, -1, 30.25])
            cube([(l - 10), 8, 10], center = true);
        // mounting hole
        if (mounting_holes == true) {
            translate([(cube_l / 2 - 50), -6.75, 0])
                rotate([-90, 0, 0])
                    bolt("M5", 12, kind = "countersunk", countersink = 1);
            translate([-(cube_l / 2 - 50), -6.75, 0])
                rotate([-90, 0, 0])
                    bolt("M5", 12, kind = "countersunk", countersink = 1);
        }
        if (use_connecting_holes == true) {
            // connecting pinholes, left side
            translate([(cube_l / 2) - 5, 0, 0])
                connector_pinholes("left");
            // connecting pinholes, right side
            translate([-(cube_l / 2) + 5 , 0, 0])
                connector_pinholes("right");
        }
    }

}

module connector_pinholes(dir) {
        if (dir == "left") {
            translate([0, 0, 20])
                rotate([0, 90, 0])
                    pinhole(h=5, r=3, lh=3, lt=1, t=0.3, tight=false);
            translate([0, 0, -20])
                rotate([0, 90, 0])
                    pinhole(h=5, r=3, lh=3, lt=1, t=0.3, tight=false);
        }
        else {
            translate([0, 0, 20])
                rotate([0, -90, 0])
                    pinhole(h=5, r=3, lh=3, lt=1, t=0.3, tight=false);
            translate([0, 0, -20])
                rotate([0, -90, 0])
                    pinhole(h=5, r=3, lh=3, lt=1, t=0.3, tight=false);
        }
}

module pin() {
    pinpeg(h=10, r=3.25, lh=3, lt=1);
}




// --- Printing --- //


if (show_all == true) {
    backplate();
    rotate([0, 90, 90])
        translate([-20, -(cube_l / 2) - 0.5, -2.25])
            pin();
    rotate([0, 90, 90])
        translate([20, -(cube_l / 2) - 0.5, -2.25])
            pin();
}
else if (show_backplate == true) {
    backplate();
}
else if (show_pin == true) {  // for printing just the pin
    pin();
}

