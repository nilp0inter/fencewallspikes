module BasicSpike(spikeheight, spikebase, basewidth, basethickness) {
    cube(size=[basewidth, basewidth, basethickness], center=true);
    cylinder(spikeheight, spikebase, 0, false);
}

module Spike(spikeheight, spikebase, basewidth, basethickness) {
    intersection() {
        BasicSpike(spikeheight, spikebase, basewidth, basethickness);
        cube(size=[basewidth, basewidth, spikeheight*2], center=true);
    }
}

module HollowSpike(spikeheight, spikebase, basewidth, basethickness) {
    
    difference() {
        Spike(spikeheight, spikebase, basewidth, basethickness);
        translate([0, 0, -basethickness]) cylinder(spikeheight, spikebase, 0, false);
   }
    
}

module RandomFence(xspikes, yspikes, squarewidth, spikebase, minspike, maxspike, basethickness, seed) {
    spikesheight=rands(minspike, maxspike, xspikes*(yspikes+1)+1, seed);
    union() {
        for(x=[0:xspikes]) {
            for(y=[0:yspikes]){
                translate([x*squarewidth, y*squarewidth, 0]) Spike(spikesheight[x*yspikes+y], spikebase, squarewidth, basethickness);
            }
        }
    }
}

module Fence(width, length, block, minh, maxh, base, ratio=2.2) {
    difference() {
        RandomFence(width/block, length/block, block, block/ratio, minh, maxh, base, 42);
        union() {
            for(x=[-1:width/block]) {
                for(y=[-1:length/block]) {
                    translate([block/2+x*block, block/2+y*block, 0]) cube(size=[block/2, block/2, maxh], center=true);
                }
            }
        }
  
    }
}

//HollowSpike(1.7, .8, 3, .1);
//RandomFence(60, 34, 10, 5, 10, 20, 1, 42);


Fence(200, 170, 10, 10, 20, 2, 1.5);


