include <parameters.scad>

linear_extrude(BEARING_HEIGHT/2)
circle(d=BEARING_BORE);

translate([0, 0, BEARING_HEIGHT/2])
linear_extrude(0.5)
circle(d=BEARING_BORE+.5);

translate([0, 0, BEARING_HEIGHT/2 + .5])
linear_extrude(BEARING_HEIGHT/2)
circle(d=BEARING_BORE - 3 - .2);