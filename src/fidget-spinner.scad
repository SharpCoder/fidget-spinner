M_PI = 3.1415926;
$fn=300;
SPINNER_ARM = 38.6875 + 2;
BEARING_BORE = 6-.2;
BEARING_HEIGHT = 6;
BEARING_DIAMETER = 17.2;

TEST = false;

function degs(rads) = rads * 180 / M_PI;
function parametric_points(fx, fy, t0=0, t1=M_PI, delta=0.01) = [for(i = [t0:delta:t1]) [fx(i), fy(i)]];

fx = function(x) SPINNER_ARM * sin(degs(x));
fy = function(x) M_PI * x/2;

module blade(length) {
    difference() {
        polygon([
            [0,0],
            [length/4, -10],
            [length/3, -5],
            [length, fy(M_PI/2)],
            [length/3, 5],
            [length/4, 10],
            [0,0],
        ]);
    
        polygon([
            [0,0],
            [length/4 - 1, -3],
            [length/3 - 1, -1],
            [length - 1, fy(M_PI/2)],
            [length/3 - 1, 1],
            [length/4 - 1, 3],
            [0,0],
        ]);
    }
}

module arm() {
    rotate(-M_PI)
    blade(SPINNER_ARM);           
    
}

module center() {    
    circle(d=BEARING_DIAMETER + 3);
}



module debug() {
    linear_extrude(10)
    arm();   
}

module base_assembly(ASSMEBLY_THICKNESS) {
  linear_extrude(ASSMEBLY_THICKNESS + 1)
    difference() {
        union() {
            arm();
            
            rotate(120)
            arm();
            
            rotate(240)
            arm();
        }
        
        center();
    }

    linear_extrude(BEARING_HEIGHT*1.5)
    union() {
        translate([SPINNER_ARM, 0, 0])
        circle(d=BEARING_BORE);

        rotate(240)
        translate([SPINNER_ARM, 0, 0])
        circle(d=BEARING_BORE);

        rotate(120)
        translate([SPINNER_ARM, 0, 0])
        circle(d=BEARING_BORE);
    }
    
    
    color("red")
    linear_extrude(ASSMEBLY_THICKNESS + 1)
    difference() {
        center();
        circle(d=BEARING_DIAMETER);
    }
    
    
    color("red")
    linear_extrude(1)
    difference() {
        center();
        circle(d=BEARING_DIAMETER-2);
    } 
}

if (TEST == true) debug();
if (TEST == false) base_assembly(BEARING_HEIGHT);