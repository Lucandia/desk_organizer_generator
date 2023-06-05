/*
 * Desk Organizer Generator library
 * License: Creative Commons - Non Commercial - Share Alike License 4.0 (CC BY-NC-SA 4.0)
 * Copyright: Luca Monari 2023
 * URL: https://github.com/lmonari5/desk_organizer_generator.git
 
The program uses the honeycomb library from Gael Lafond, from https://www.thingiverse.com/thing:2484395.

Add a normal block with:
```
rbox(SIZE_INT, SIZE_EXT, HEIGHT, r=R, rp=true, base=BASE_THICK);
```
where:
- SIZE_INT is the internal dimension array ([x,y])
- SIZE_EXT is the internal dimension array ([x,y], usually is calculated as SIZE_INT + [X_WALL\*2, Y_WALL\*2])
- HEIGHT is the height of the block
- R is the radius of the curvature of the square perimeter corners (default: 7)
- rp is a boolean value: it false the program interprets R as a value in mm, if true consider R as the percentage over the length of the square side (default: true)
- BASE_THICK is the thickness of the base (default: 2)

Add a honeycomb block with:
```
hbox(SIZE_INT, SIZE_EXT, HEIGHT, r=R, rp=true, base=BASE_THICK, h_dia=H_DIA, h_thick=H_THICK) ;
```
where:
- SIZE_INT is the internal dimension array ([x,y])
- SIZE_EXT is the internal dimension array ([x,y], usually is calculated as SIZE_INT + [X_WALL\*2, Y_WALL\*2])
- HEIGHT is the height of the block
- R is the radius of the curvature of the square perimeter corners (default: 7)
- rp is a boolean value: it false the program interprets R as a value in mm, if true consider R as the percentage over the length of the square side (default: true)
- BASE_THICK is the thickness of the base (default: 2)
- H_DIA is the honeycomb diameter (default: 4)
- H_THICK is the honeycomb line thickness (default: 1)
*/

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

module rhex(l=50,r=10,rp=1) {
r = rp ? max(l*r/100/2) : r; 
if (r) {
ipo = l/(2*cos(30));
hull(){
for (i = [0 : 5] ){
    rotate([0,0,60*i])translate([ipo-r/cos(30),0,0])circle(r);
};};
}
else {
hull(){
square([l/(cos(30)*2),l],center=true);
rotate([0,0,120])square([l/(cos(30)*2),l],center=true);
rotate([0,0,240])square([l/(cos(30)*2),l],center=true);
};
};
};


module rbox(internal, external, height, r=7, rp=1, base=2) {
union(){
// base
linear_extrude(base)
rsquare(internal,r,rp);
// border
linear_extrude(height)
difference(){
rsquare(external,r,rp);
rsquare(internal,r,rp);};};
};

module hbox(internal, external, height, r=7, rp=1, base=2) {
union(){
// base
linear_extrude(base)
rhex(internal,r, rp);
// border
linear_extrude(height)
difference(){
rhex(external,r,rp);
rhex(internal,r,rp);};};
};


module rhbox(internal, external, height, r=7, rp=1, base=2, h_dia=4, h_thick=1) {
// hon_bor is the solid border of the honyecomb, and is set to the minimal value of the walls 
hon_bor = rp ? max(external*r/100) : r; 
wall = (external - internal) / 2;
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


module hhbox(internal, external, height, r=7, rp=1, base=2, h_dia=4, h_thick=1) {
// hon_bor is the solid border of the honyecomb, and is set to the minimal value of the walls 
hon_bor = rp ? max(external*r/100) : r; 
wall = (external - internal) / 2;
ipo_e = external/(2*cos(30));
intersection(){
// use the same box shape
hbox(internal, external, height);
// add solid corners
union(){
// add border
linear_extrude(height)
difference(){
rhex(external,r);
square([external/(cos(30)*2)-hon_bor*2,external],center=true);
rotate([0,0,120])square([external/(cos(30)*2)-hon_bor*2,external],center=true);
rotate([0,0,240])square([external/(cos(30)*2)-hon_bor*2,external],center=true);
};
union(){
 // base 
 linear_extrude(base)
  rhex(internal,r);
for (i = [0 : 5] ){
rotate([0,0,60*i]){
// + x
translate([0, external/2+wall/2, height/2])
rotate([90,0,0])
linear_extrude(wall*2) {
    intersection(){
    union(){
    // centered honeycomb
    translate([-ipo_e/2, -height/2, 0])
	honeycomb(ipo_e, height, h_dia, h_thick);
    // border
    difference(){
    rsquare([ipo_e,height],0);
    rsquare([ipo_e-hon_bor,height-hon_bor],0);};};
    //the full base to intersect
    rsquare([ipo_e,height],0);
    };};};};};};};
 };
