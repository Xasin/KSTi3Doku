
$fs = 0.5;
$fa = 3;

// Generelle Wand-Dicke
wallThickness = 1.5;

// Positionen der verbindenden Schrauben
standConnectingScrewDist = 12;

// Größen der verbindenden Stange
standConnectorRadius = 18;
standConnectorHeight = 150;
standConnectorStabiliserScrewNum = 2;

standConnectorClipWidth = 50;
standConnectorClipSmoothing = 6;
standConnectorClipLength = 20;
standConnectorClipInShift = 0.1;

// Größen des eigentlichen Standfußes
standWidth = standConnectorRadius;
standLength = 150;
standThickness = 3;

standEndCircleRadius = 5;

// Werte der Tablet-Auflage
restBaseLength = 100;
restBaseWidth = 15;
restWallHeight = 10;
restWallThickness = 3;

restScrewPositions = [-restBaseLength/2 + 10, -standConnectingScrewDist/2, standConnectingScrewDist/2, restBaseLength/2 - 10];

// Größen der verbindenden Schrauben
mScrewHeadHeight = 2;
mNutSmallWidth = 5.5;

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

module visual_assembly() {
	stand_screws();
	translate([0, 0, standThickness + standConnectorHeight]) {
		standConnector_clip();
		rest();
	}
}

visual_assembly();