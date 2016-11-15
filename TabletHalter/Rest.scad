
include <Values.scad>

module rest() {
	restBaseThickness = wallThickness + mScrewHeadHeight;
	restTotalHeight = restBaseThickness + restWallHeight;
	restTotalWidth = restBaseWidth + restWallThickness;

	difference() {
		translate([-restBaseLength/2, 0, 0])
			cube([restBaseLength, restTotalWidth, restTotalHeight]);

		translate([-(restBaseLength/2 + 0.1), -0.1, restBaseThickness]) cube([restBaseLength + 0.2, restBaseWidth + 0.2, 100]);

		for(x = restScrewPositions) translate([x, 9, wallThickness])
			MScrew();
	}
}
