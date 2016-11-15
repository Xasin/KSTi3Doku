
include <Values.scad>

use <Stand.scad>
use <Base.scad>
use <Rest.scad>
use <AlternateStand.scad>


module visual_assembly() {
	stand_screws();
	translate([0, 0, standThickness + standConnectorHeight]) {
		standConnector_clip();
		rest();
	}
}

standTube_cup();
