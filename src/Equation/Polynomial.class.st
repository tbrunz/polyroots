"
I represent a polynomial equation, in the form of its coefficients.

I know how to find my roots.

I could be improved by collaborating with the PolyMath library (which would allow me to use complex numbers intrinsically). 

Public API and Key Messages:

	Create a new polynomial instance and set its coefficient array.
- aPolynomial := Polynomial with: coefficientArray.
	Find the roots of the polynomial; results to 'realRoots' and 'imagRoots' arrays.
- aPolynomial findRoots.
	Set the coefficients array with the argument, then find the roots.
- aPolynomial findRoots: coefficientArray.
 
Internal Representation and Key Implementation Points.

    Instance Variables:
	coefficients:	<Array of real numbers>
	imagRoots:		<Array of real numbers>
	realRoots:		<Array of real numbers>


    Implementation Points
"
Class {
	#name : #Polynomial,
	#superclass : #Object,
	#instVars : [
		'coefficients',
		'realRoots',
		'imagRoots'
	],
	#classVars : [
		'rootFinders'
	],
	#category : #'Equation-Polynomials'
}

{ #category : #'class initialization' }
Polynomial class >> initialize [
	"Create the array of root solver messages."
	"We could do this with the Command Pattern. Or with blocks."

	rootFinders := #(
		#rootsOfDegreeZero
		#rootsOfDegreeOne
		#rootsOfDegreeTwo
		#rootsOfDegreeThree
		#rootsOfDegreeFour
		#rootsOfDegreeFivePlus
		)
]

{ #category : #'instance creation' }
Polynomial class >> with: coefficientArray [
	"Create a new polynomial with the given coefficients."	
	
	^ self new 
		coefficients: coefficientArray
]

{ #category : #accessing }
Polynomial >> coefficients [

	^ coefficients
]

{ #category : #accessing }
Polynomial >> coefficients: anObject [

	coefficients := anObject
]

{ #category : #'calculating-methods' }
Polynomial >> cubeRoot [
	"If the discriminant of a cubic is zero, it's a triple cube root."
	
	| cube root |
	cube := (coefficients at: 1) / (coefficients at: 4) .
	root := cube sign negated * (cube abs ** (1/3)) asFloat .
	
	"All three imaginary roots are already set to 0."
	"Also, the root average is also 0 -- no need to sum it."
	realRoots at: 1 put: root .
	realRoots at: 2 put: root .
	realRoots at: 3 put: root .
	
	^ 3
]

{ #category : #calculating }
Polynomial >> evaluate: abscissa [
	"Find the ordinate of the polynomial at the given abscissa."
	
	^ coefficients reverse 
		inject: 0 into: [ :sum :coeff |
			sum * abscissa + coeff ] .
]

{ #category : #calculating }
Polynomial >> findRoots [
	"Find or calculate the roots of the equation."	
	
	| degree |	
	"Require that an array of coefficients has already be set."
	(coefficients isArray and: [ coefficients isNotEmpty ])
		ifFalse: [ ^ self rootsOfNoCoefficients ] .
	
	"The equation can't exceed the size of what we can compute."	
	degree := coefficients size min: rootFinders size.
	
	"Use the polynomial's degree as an index into an array of 
	messages (method selectors) to dispatch the appropriate method."
	^ self perform: (rootFinders at: degree)
	
]

{ #category : #calculating }
Polynomial >> findRoots: anArray [ 
	"Find or calculate the roots of the equation."	
			
	coefficients := anArray .
	^ self findRoots 
	
]

{ #category : #accessing }
Polynomial >> imagRoots [

	^ imagRoots
]

{ #category : #accessing }
Polynomial >> imagRoots: anObject [

	imagRoots := anObject
]

{ #category : #'calculating-methods' }
Polynomial >> quadraticRoots: index with: py with: q with: s [
	"Solve a resulting quadratic of the quartic polynomial."
	
	| poly reals |
	poly := self class with: { py - (q / s / 4) . (2 * s) . 1 } .
	reals := poly findRoots .
	
	realRoots at: index   put: (realRoots at: index  ) + (poly realRoots at: 1) .
	realRoots at: index+1 put: (realRoots at: index+1) + (poly realRoots at: 2) .
	
	imagRoots at: index   put: (poly imagRoots at: 1) .
	imagRoots at: index+1 put: (poly imagRoots at: 2) .
	
	^ reals
]

{ #category : #accessing }
Polynomial >> realRoots [

	^ realRoots
]

{ #category : #accessing }
Polynomial >> realRoots: anObject [

	realRoots := anObject
]

{ #category : #'calculating-methods' }
Polynomial >> rootsOfDegreeFivePlus [
	"Find the roots of polynomials of degree 5 or more."
	
	^ self shouldBeImplemented 
]

{ #category : #'calculating-methods' }
Polynomial >> rootsOfDegreeFour [
	"Solve a quartic polynomial; either 4 reals, 4 imaginaries, or 2 real/2 imaginary roots."
	"Uses Ferrari's Formulas."
	
	| a b c d e p q r s t y poly reals |
	a := coefficients at: 5 .
	a = 0 ifTrue: [ self error: 'quartic must have non-zero a4!' ] .
	
	b := (coefficients at: 4) / a .
	c := (coefficients at: 3) / a .
	d := (coefficients at: 2) / a .
	e := (coefficients at: 1) / a .
	
	t := b / -4 asFloat.
	realRoots := Array with: t with: t with: t with: t .
	imagRoots := Array with: 0 with: 0 with: 0 with: 0 .
	
	p := c - (6 * t * t) .
	q := d + (2 * c * t) - (8 * t * t * t) .
	r := e + (d * t) + (c * t * t) - (3 * t * t * t * t) .
	
	poly := self class with: { 
		p / 2 * (p * p - r) - (q * q / 8) . (2 * p * p - r) . (5 / 2 * p) . 1 } .
	
	y := self selectRealRoot: poly largerThan: p / -2 .
	s := (2 * y + p) sqrt / 2 .
	
	reals :=          self quadraticRoots: 1 with: p+y with: q with: s .
	reals := reals + (self quadraticRoots: 3 with: p+y with: q with: s negated) .
	
	^ reals
]

{ #category : #'calculating-methods' }
Polynomial >> rootsOfDegreeOne [
	"Solve a linear equation (one root)."	
	
	| m b |
	m := coefficients at: 2 .
	b := coefficients at: 1 .
	m = 0 ifTrue: [ self error: 'linear equation must have non-zero a1!' ] .
	
	realRoots := Array with: b / m negated .
	imagRoots := Array with: 0 .
	
	^ 1
]

{ #category : #'calculating-methods' }
Polynomial >> rootsOfDegreeThree [
	"Solve a cubic polynomial; either 3 reals or 1 real + 2 imaginary roots."	
			
	| a b c d p q r s t discriminant |
	a := coefficients at: 4 .
	a = 0 ifTrue: [ self error: 'cubic must have non-zero a3!' ] .
	
	b := (coefficients at: 3) / a .
	c := (coefficients at: 2) / a .
	d := (coefficients at: 1) / a .
	
	t := b / -3 asFloat.
	realRoots := Array with: t with: t with: t .
	imagRoots := Array with: 0 with: 0 with: 0 .
	
	p := b * t + c .
	q := d + (c * t) - (2 * t * t * t) .
	r := q / -2 .
	s := p / -3 .
	
	"If p=0, then we have a simple x^3 + d equation."
	p =~ 0 ifTrue: [ ^ self cubeRoot ] .
	
	discriminant := (r * r) - (s * s * s) .
	^ discriminant < 0
		ifTrue: [ self rootsOfDegreeThreeAllReals: r with: s ] 
		ifFalse: [ self rootsOfDegreeThreeOneReal: r with: s discriminant: discriminant ]
]

{ #category : #'calculating-methods' }
Polynomial >> rootsOfDegreeThreeAllReals: r with: s [
	"Solve the depressed cubic with a negative descriminant."
	"Uses Viete's Formulas: cos(3t) = 4cos^3(t) - 3cos(t)"
	
	| scaleFactor argumentAngle |
	scaleFactor := 2 * s sqrt .
	argumentAngle := (2 * r / s / scaleFactor) arcCos / 3 .
	
	1 to: 3 do: [ :slice | 
		| sliceAngle |
		sliceAngle := Float pi * 2 * slice / 3 .
		sliceAngle := argumentAngle + sliceAngle .
		
		"All three imaginary roots are already set to 0."
		realRoots at: slice put: (realRoots at: slice) + (scaleFactor * sliceAngle cos) ] .
	^ 3
]

{ #category : #'calculating-methods' }
Polynomial >> rootsOfDegreeThreeOneReal: r with: s discriminant: discriminant [
	"Solve the depressed cubic with a positive discriminant."
	"Uses Cardano's Formulas, and produces only one real root."
	
	| u v |
	u := discriminant sqrt + r .
	
	u := u sign * (u abs ** (1/3)) asFloat .
	v := s / u .
	
	realRoots at: 1 put: (realRoots at: 1) + u + v .
	realRoots at: 2 put: (realRoots at: 2) - (u / 2) - (v / 2) .
	realRoots at: 3 put: (realRoots at: 2) .
	
	imagRoots at: 1 put: 0 .
	imagRoots at: 2 put: (u * 3 sqrt / 2) - (v * 3 sqrt / 2) .
	imagRoots at: 3 put: (imagRoots at: 2) negated .
	
	^ 1
]

{ #category : #'calculating-methods' }
Polynomial >> rootsOfDegreeTwo [
	"Solve a quadratic polynomial; either two real or two imaginary roots."	
			
	| a b realPart imagPart discriminant |
	a := -2 * coefficients at: 3 .
	b := coefficients at: 2 .
	a = 0 ifTrue: [ self error: 'quadratic must have non-zero a2!' ] .
	
	discriminant := (b * b) + (2 * a * coefficients at: 1) .
	realPart := b / a .
	imagPart := discriminant abs sqrt / a .
	
	discriminant < 0
		ifTrue: [ 
			realRoots := Array with: realPart with: realPart .
			imagRoots := Array with: imagPart with: imagPart negated .
			^ 0 ]
		ifFalse: [ 
			realRoots := Array with: realPart + imagPart with: realPart - imagPart .
			imagRoots := Array with: 0 with: 0 .
			^ 2 ]
	
]

{ #category : #'calculating-methods' }
Polynomial >> rootsOfDegreeZero [
	"A polynomial equation with only a constant term has no roots!"
	
	realRoots := Array with: nil with: nil .
	imagRoots := Array with: nil with: nil .
	
	^ self error: ( String streamContents: [ :stream | 
		stream 
			nextPutAll: 'Equation is a constant (';
			nextPutAll: ((coefficients at: 1) asString);
			nextPutAll: '); no roots!' ] )
]

{ #category : #'calculating-methods' }
Polynomial >> rootsOfNoCoefficients [
	"If a polynomial has an empty coefficient array, there are no roots!"	
	
	realRoots := Array with: nil with: nil .
	imagRoots := Array with: nil with: nil .
	
	^ self error: 'Polynomial equation is required!'
]

{ #category : #'calculating-methods' }
Polynomial >> selectRealRoot: poly largerThan: limit [
	"Find the roots of a polynomial, then examine the roots 
	to find a real root larger than a limit."
	
	| pureReals maxRoot |
	poly findRoots < 2 
		ifTrue: [ ^ poly realRoots at: 1 ] .
	
	"Cherry pick the elements of 'realRoots' having no imaginary part."
	"pureReals := poly realRoots withIndexSelect: [ :each :index |
		(poly imagRoots at: index) = 0 ] ."
	pureReals := poly realRoots .
	
	"Find the largest of the 3 real roots."
	"maxRoot := pureReals inject: (pureReals at: 1) into: [ :largest :each |
		largest max: each ] ."
	maxRoot := ((pureReals at: 1) max: (pureReals at: 2)) max: (pureReals at: 3) .
	
	"We need it to be larger than the limit."
	maxRoot > limit 
		ifTrue: [ ^ maxRoot ] .
		
	self error: 'Nested depressed cubic has no root larger than', limit asString
]
