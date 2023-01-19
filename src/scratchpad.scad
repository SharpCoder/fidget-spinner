include <parameters.scad>;

function degs(rads) = (rads * 180) / M_PI;

function parametric_points(fx, fy, t0=0, t1=M_PI, delta=0.01) 
= [for(i = [t0:delta:t1]) [fx(i), fy(i)]];


fx = function(x) x;
fy = function(x) -cos(degs(x+M_PI))*5 + 5;

module blade(width, height, length) {
    threshold = 4;
    
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



blade(width=6, height=3, length=20);