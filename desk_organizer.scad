include <honeycomb.scad>
$fn = 40;

// module for round 2D square
module rsquare(l=[50, 50],r=10,rp=0) {
r = rp ? max(l*r/100/2) : r; 
s = l/2;
union(){
union(){
union(){
union(){
difference(){
difference(){
difference(){
difference(){
square(size=l, center=true);
translate([-s[0],-s[1],0]) circle(r);};
translate([-s[0],s[1],0]) circle(r);};
translate([s[0],-s[1],0]) circle(r);};
translate([s[0],s[1],0]) circle(r);};
translate([-s[0]+r,-s[1]+r,0]) circle(r);};
translate([-s[0]+r,s[1]-r,0]) circle(r);};
translate([s[0]-r,-s[1]+r,0]) circle(r);};
translate([s[0]-r,s[1]-r,0]) circle(r);};
};

module rbox(internal, external, height, r=7, rp=1, base=2) {
union(){
// base
linear_extrude(base)
rsquare(internal,r,1);
// border
linear_extrude(height)
difference(){
rsquare(external,r,rp);
rsquare(internal,r,rp);};};
};

module hbox(internal, external, height, r=7, rp=1, base=2, h_dia=4, h_thick=1) {
// hon_bor is the solid border of the honyecomb, and is set to the minimal value of the walls 
hon_bor = rp ? max(external*r/100) : r; 
wall = (external - internal) / 2
union(){
linear_extrude(height)
difference(){
difference(){
// border
difference(){
rsquare(external,r,rp);
rsquare(internal, r,rp);}
// not corners
square([external[0]*2,external[1]-hon_bor*2], center=true);}
square([external[0]-hon_bor*2,external[1]*2], center=true);};

intersection(){
// use the same box shape
rbox(internal, external, height);
// add solid corners

union(){
 // base 
 linear_extrude(base)
  rsquare(internal,r,1);
// + x
translate([0, external[1]/2+wall[1]/2, height/2])
rotate([90,0,0])
linear_extrude(wall[1]*2) {
    intersection(){
    union(){
    // centered honeycomb
    translate([-external[0]/2, -height/2, 0])
	honeycomb(external[0], height, h_dia, h_thick);
    // border
    difference(){
    rsquare([external[0],height],0);
    rsquare([external[0]-hon_bor,height-hon_bor],0);};};
    //the full base to intersect
    rsquare([external[0],height],0);
    };};
// - x
translate([0, -external[1]/2+wall[1]*3/2, height/2])
rotate([90,0,0])
linear_extrude(wall[1]*2) {
    intersection(){
    union(){
    // centered honeycomb
    translate([-external[0]/2, -height/2, 0])
	honeycomb(external[0], height, h_dia, h_thick);
    // border
    difference(){
    rsquare([external[0],height],0);
    rsquare([external[0]-hon_bor,height-hon_bor],0);};};
    //the full base to intersect
    rsquare([external[0],height],0);
    };};
// + y  
translate([external[0]/2-wall[0]*3/2, 0, height/2])
rotate([90,0,90])
linear_extrude(wall[0]*2) {
    intersection(){
    union(){
    // centered honeycomb
    translate([-external[1]/2,-height/2, 0])
	honeycomb(external[1], height, h_dia, h_thick);
    // border
    difference(){
    rsquare([external[0],height],0);
    rsquare([external[1]-hon_bor,height-hon_bor],0);};};
    //the full base to intersect
    rsquare([external[1],height],0);
    };};
// - y  
translate([-external[0]/2-wall[0]/2, 0, height/2])
rotate([90,0,90])
linear_extrude(wall[0]*2) {
    intersection(){
    union(){
    // centered honeycomb
    translate([-external[1]/2,-height/2, 0])
	honeycomb(external[1], height, h_dia, h_thick);
    // border
    difference(){
    rsquare([external[0],height],0);
    rsquare([external[1]-hon_bor,height-hon_bor],0);};};
    //the full base to intersect
    rsquare([external[1],height],0);
    };};};};};
    
};


