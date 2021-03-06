dom0Mult = 1e3;

lc = .1 * 1e-3 * dom0Mult;
dc = 1; // Stands for don't care

// Needle tip
Point(5) = {.5e-3 * dom0Mult, 0, 0, .5 * lc};

// Center of radius of curvature
Point(6) = {dom0Mult * (.5e-3 - 30e-6), 0, 0, dc};

// Point of needle at small radius
Point(7) = {dom0Mult * (.5e-3 - 30e-6), dom0Mult * 30e-6, 0, .5 * lc};

// Point of needle at large radius (pesudo-bottom left of domain)
Point(8) = {0, dom0Mult * 180e-6, 0, lc};

// Needle tip edge
Circle(1) = {5, 6, 7};

// Long needle edge
Line(2) = {7, 8};

// Top left of domain (extremity point of gas phase)
Point(9) = {0, 1e-3 * dom0Mult, 0, lc};

// Center of ground plane (bottom right of domain)
Point(10) = {1.5e-3 * dom0Mult, 0, 0, lc};

// Outer bound of ground plane (top right of domain)
Point(11) = {1.5e-3 * dom0Mult, 1e-3 * dom0Mult, 0, lc};

// Axis of symmetry
Line(3) = {5, 10};

// Anode
Line(4) = {10, 11};

// Wall 1
Line(5) = {11, 9};

// Wall 2
Line(6) = {9, 8};

Line Loop(7) = {5, 6, -2, -1, 3, 4};
Plane Surface(8) = {7};

// Plasma domain
Physical Surface(0) = {8};

// Physical Cathode
Physical Line(10) = {2, 1};

// Physical Anode
Physical Line(11) = {4};

// Physical Walls
Physical Line(12) = {5, 6};

// Physical axis of symmetry
Physical Line(13) = {3};

// Field[1] = BoundaryLayer;
// Field[1].EdgesList = {3};
// Field[1].hfar = .1;
// Field[1].hwall_n = .01;
// Field[1].hwall_t = .05;
// Field[1].thickness = .2;

// Field[2] = Min;
// Field[2].FieldsList = {1};
// Background Field = 2;