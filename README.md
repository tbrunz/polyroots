# polyroots
Pharo application to solve for the roots of polynomial equations

This is a Pharo app that (so far) calculates the roots of polynomial equations 
of degree 4 or less.  

Polynomials of degree 1, 2, 3, and 4 have analytic solutions based on their 
coefficients; those of degree 5+ do not.

This started out as an exercise in Pharo, to implement Ferrari's, Cardano's, 
Viete's, and the quadratic equation to find roots analytically, and without 
using the PolyMath library (i.e., no complex number objects).

I may eventually expand it to solve polynomials of degree 5 and higher, 
and perhaps other types of equations.

This application implements one package, "Equation", which defines one class, "Polynomial". 
There is a test class to test various solution cases for each polynomial degree. 

The Wiki tab has the beginning of a tutorial based on this project.

TODO: 
- The quartic solution needs more test cases. 
- More documentation needs to be written...
- More tutorial material needs to be written.

This was coded in Pharo 9.
