
$fs = 0.5;
$fa = 10;

// Generelle Wand-Dicke
wallThickness = 1.5;

// Positionen der verbindenden Schrauben
standConnectingScrewDist = 12;

// Größen der verbindenden Stange
standConnectorRadius = 18;
standConnectorHeight = 150;

// Werte der Tablet-Auflage
restBaseLength = 100;
restBaseWidth = 15;
restWallHeight = 10;
restWallThickness = 3;

restScrewPositions = [-restBaseLength/2 + 10, -standConnectingScrewDist/2, standConnectingScrewDist/2, restBaseLength/2 - 10];

// Größen der verbindenden Schrauben
mScrewHeadHeight = 2;

module MScrew() {
	translate([0, 0, -99.9]) cylinder(r = 1.6, h = 100);
	cylinder(r = 3.1, h = 100);
}

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

module standConnector_basic() {
	translate([0, 0, -standConnectorHeight]) difference() {
		cylinder(r = standConnectorRadius, h = standConnectorHeight);
		
		translate([-standConnectorRadius - 0.1, -standConnectorRadius - 0.1, -0.1]) 
			cube([standConnectorRadius*2 + 0.2, standConnectorRadius + 0.1, standConnectorHeight + 0.2]);
	}
}

standConnector_basic();