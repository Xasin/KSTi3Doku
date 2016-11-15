
include <Values.scad>


module stand_basic() {
	linear_extrude(height = standThickness) {
		hull() {
			for(x = [standLength/2, -standLength/2]) translate([x, standEndCircleRadius]) circle(r = standEndCircleRadius);

			difference() {
				circle(r = standConnectorRadius);
				translate([0, -standConnectorRadius]) square(standConnectorRadius*2, center=true);
			}
		}
	}
}

module stand_screws() {
	difference() {
		stand_basic();

		for(x = [-0.5, 0.5]) translate([x*standConnectingScrewDist, 9, mScrewHeadHeight]) rotate([180, 0, 0]) MScrew();
	}
}
