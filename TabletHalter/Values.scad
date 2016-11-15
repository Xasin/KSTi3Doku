
$fs = 0.5;
$fa = 3;

// Generelle Wand-Dicke
wallThickness = 1.5;

// Positionen der verbindenden Schrauben
standConnectingScrewDist = 10;

// Größen der verbindenden Stange
standConnectorRadius = 18;
standTubeRadius = standConnectorRadius / 2;
standTubeConnectorHeight = 23;

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
