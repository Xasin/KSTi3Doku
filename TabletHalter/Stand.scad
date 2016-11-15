
include <Values.scad>

module standConnector_basic() {
	translate([0, 0, -standConnectorHeight]) difference() {
		cylinder(r = standConnectorRadius, h = standConnectorHeight);

		translate([-standConnectorRadius - 0.1, -standConnectorRadius - 0.1, -0.1])
			cube([standConnectorRadius*2 + 0.2, standConnectorRadius + 0.1, standConnectorHeight + 0.2]);
	}
}

module standConnector_screw_cutouts() {
	for(x = [-standConnectingScrewDist/2, standConnectingScrewDist/2]) translate([x, 0, 0]) {
		translate([0, 0, -10]) cylinder(r = 1.6, h = 20);

		translate([-mNutSmallWidth/2, -3.5, -2.5/2]) cube([mNutSmallWidth, 30, 2.5]);
	}
}

module standConnector_screws() {
	difference() {
		standConnector_basic();

		translate([0, 9, -2.5/2 - wallThickness])
			standConnector_screw_cutouts();

		translate([0, 9, -standConnectorHeight + 2.5/2 + wallThickness])
			standConnector_screw_cutouts();

		standConnectorStabiliserScrewDist = standConnectorHeight/(standConnectorStabiliserScrewNum +1);

		for(z = [1:standConnectorStabiliserScrewNum])
			translate([0, wallThickness, -z * standConnectorStabiliserScrewDist]) rotate([-90, 0, 0])
		MScrew();

	}
}

module clip_shape() {
	difference() {
		offset(r = standConnectorClipSmoothing) offset(r = -standConnectorClipSmoothing) square([standConnectorClipWidth, standConnectorClipLength*2], center=true);

		translate([0, -standConnectorClipLength/2 - 0.1]) square([standConnectorClipWidth + 0.2, standConnectorClipLength + 0.2], center=true);
	}
}

module standConnector_clip() {
	difference() {
		union() {
			standConnector_screws();

			translate([standConnectorRadius - standConnectorClipInShift, 0, -standConnectorHeight/2]) rotate([0, -90, -90]) linear_extrude(height = wallThickness) clip_shape();
		}

		translate([standConnectorRadius - standConnectorClipInShift, wallThickness - 0.1, -standConnectorHeight/2 - standConnectorClipWidth/2])
		cube([standConnectorClipLength, 100, standConnectorClipWidth]);
	}
}
