 include <Values.scad>

 module standTube_cup_basic() {
	 difference() {
		 cylinder(r = standTubeRadius + wallThickness, h = wallThickness + standTubeConnectorHeight);
		 translate([0, 0, wallThickness]) cylinder(r = standTubeRadius, h = standTubeConnectorHeight + 1);
	 }
 }


module standTube_cup() {
	difference() {
		standTube_cup_basic();
		for(x = [-0.5, 0.5]) translate([x*standConnectingScrewDist, 0, -0.1]) cylinder(d = 3, h = 100);
	}
}
