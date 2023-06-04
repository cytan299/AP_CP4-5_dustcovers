/*
    CP4-5_case.scad is the code to generate a dust cover for
    Astro-Physics CP4 and CP5 controllers.
    
    Copyright (C) 2023  C.Y. Tan
    Contact: cytan299@yahoo.com

    This file is part of the CP4 and CP5 dust cover distribution.

    CP4-5_case is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    CP4-5_case is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with CP4-5_case.  If not, see <http://www.gnu.org/licenses/>.

*/

$fn=100;

// inside dimensions of box
IBox_len_x = 163; // mm
IBox_len_y = 128; // mm
IBox_len_z = 20; //mm

// outside dimensions of box

Box_wall_t = 2; //mm, wall thickness

Box_len_x = IBox_len_x + 2*Box_wall_t; //mm
Box_len_y = IBox_len_y + 2*Box_wall_t; //mm
Box_len_z = IBox_len_z + 2*Box_wall_t; //mm

// partition wall y position
Box_partition_len_y = 68.2 + Box_wall_t; //mm
Box_partition_len_z = 10; //mm

// lips
Top_lip = 5; //mm

// corners

Corner_len_x = 10;
Corner_len_y = 1;
Corner_len_z = 60;

module make_box()
{
  difference(){
    difference(){
      cube([Box_len_x, Box_len_y, Box_len_z], center= false);
      translate([Box_wall_t, Box_wall_t, Box_wall_t])
        cube([IBox_len_x , IBox_len_y , IBox_len_z + 2*Box_wall_t], center=false);
    }
    // make the upper clearance hole
    translate([Box_wall_t, Box_wall_t + Top_lip, -IBox_len_z/2])    
      cube([IBox_len_x, Box_partition_len_y - Top_lip, IBox_len_z], center=false);
  }
}

module make_partition()
{
  translate([0, Box_partition_len_y, 0])
    cube([Box_len_x, Box_wall_t, Box_partition_len_z], center=false);
}

module make_flat_corners()
{
  // origin
  rotate([0,0,-45]){
  translate([-Corner_len_x/2, 0, -Corner_len_z/2])
    cube([Corner_len_x, Corner_len_y, Corner_len_z], center=false);
  }

  // top left corner
  translate([0, Box_len_y - Corner_len_y, 0]){  
    rotate([0,0,45]){
    translate([-Corner_len_x/2, 0, -Corner_len_z/2])
      cube([Corner_len_x, Corner_len_y, Corner_len_z], center=false);
    }
  }

  // top right corner
  translate([Box_len_x, Box_len_y - Corner_len_y, 0]){  
    rotate([0,0,-45]){
    translate([-Corner_len_x/2, 0, -Corner_len_z/2])
      cube([Corner_len_x, Corner_len_y, Corner_len_z], center=false);
    }
  }
  
  // bottom right corner
  translate([Box_len_x, 0, 0]){  
    rotate([0,0,45]){
    translate([-Corner_len_x/2, 0, -Corner_len_z/2])
      cube([Corner_len_x, Corner_len_y, Corner_len_z], center=false);
    }
  }  
}


union(){
 difference(){  
   make_box();
   make_flat_corners();
 }  
    make_partition();

}
