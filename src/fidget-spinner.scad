include <parameters.scad>

SPINNER_ARM = 36.9455 + .2;

fy = function(x) M_PI * x/2;

module blade_shape(width, height, length) {
    threshold = 8;
    
    difference() {
        polygon(
            concat(
                [[0, 0]],
                [[-width/2, height]],
                [[-.25, length]],
                [[0, length]],
                [[.25, length]],
                [[width/2, height]],
                [[0, 0]]
            )
        );            
        polygon(
            concat(
                [[0, 0]],
                [[-(width-threshold)/2, height]],
                [[-.25, length - 3]],
                [[0, length - 3]],
                [[.25, length - 3]],
                [[(width-threshold)/2, height]],
                [[0, 0]]
            )
        );  
    }
}

module blade(length) {
    rotate(34)
    blade_shape(width=10, height=20, length=length);
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

module arm_bearing() {
    linear_extrude(BEARING_HEIGHT*1.5+1)
    circle(d=ARM_BEARING_BORE);
    
    linear_extrude(BEARING_HEIGHT+1)
    circle(d=ARM_BEARING_BORE+1);
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
    
    color("yellow")
    union() {
        translate([SPINNER_ARM, 0, 0])
        arm_bearing();

        rotate(240)
        translate([SPINNER_ARM, 0, 0])
        arm_bearing();

        rotate(120)
        translate([SPINNER_ARM, 0, 0])
        arm_bearing();
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

base_assembly(BEARING_HEIGHT);