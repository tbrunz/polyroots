Class {
	#name : #AnalyticSolutionsTest,
	#superclass : #TestCase,
	#category : #'Equation-Tests'
}

{ #category : #tests }
AnalyticSolutionsTest >> testDegreeFour [
	"y = ax^4 + bx^3 + cx^2 + dx + e = 0"
	
	| eq |
	"Improper quartic equation."
	eq := Polynomial with: #( 5 -2 -3 1 0 ) .
	self should: [ eq findRoots ] raise: Error .
	
	"Four real, unique roots."
	eq := Polynomial with: #( 24 -14 -13 -6 1 ) .
	self assert: eq findRoots equals: 4 .
	self assert: (eq realRoots at: 4) closeTo: 3 .
	self assert: (eq realRoots at: 3) closeTo: 3 .
	self assert: (eq realRoots at: 2) closeTo: 1 .
	self assert: (eq realRoots at: 1) closeTo: -2 .

	"One real root, two complex conjugate roots."
	eq := Polynomial with: #( 9 17 10 2 ) .
	self assert: eq findRoots equals: 1 .
	self assert: (eq realRoots at: 3) closeTo: -2 .
	self assert: (eq realRoots at: 2) closeTo: -2 .
	self assert: (eq realRoots at: 1) closeTo: -1 .
	self assert: (eq imagRoots at: 3) closeTo: -0.70710678 .
	self assert: (eq imagRoots at: 2) closeTo: 0.70710678 .
	self assert: (eq imagRoots at: 1) closeTo: 0 .

	"One real root, two pure imaginary roots."
	eq := Polynomial with: #( -6 2 -3 1) .
	self assert: eq findRoots equals: 1 .
	self assert: (eq realRoots at: 3) closeTo: 0 .
	self assert: (eq realRoots at: 2) closeTo: 0 .
	self assert: (eq realRoots at: 1) closeTo: 3 .
	self assert: (eq imagRoots at: 3) closeTo: -1.41421356 .
	self assert: (eq imagRoots at: 2) closeTo: 1.41421356 .
	self assert: (eq imagRoots at: 1) closeTo: 0 .
	
	"Double real + real roots."
	eq := Polynomial with: #( 12 -8 -1 1 ) .
	self assert: eq findRoots equals: 3 .
	self assert: (eq realRoots at: 3) closeTo: 2 .
	self assert: (eq realRoots at: 2) closeTo: 2 .
	self assert: (eq realRoots at: 1) closeTo: -3 .
	
	"Triple real roots."
	eq := Polynomial with: #( 27 0 0 1 ) .
	self assert: eq findRoots equals: 3 .
	self assert: (eq realRoots at: 3) closeTo: -3 .
	self assert: (eq realRoots at: 2) closeTo: -3 .
	self assert: (eq realRoots at: 1) closeTo: -3 .
]

{ #category : #tests }
AnalyticSolutionsTest >> testDegreeOne [
	"y = mx + b = 0"
	
	| eq |
	"Improper linear equation."
	eq := Polynomial with: #( 5 0 ) .
	self should: [ eq findRoots ] raise: Error .
	
	"Positive slope, positive x."
	eq := Polynomial with: #( -6 3 ) .
	self assert: eq findRoots equals: 1 .
	self assert: (eq realRoots at: 1) equals: 2 .
	
	"Positive slope, negative x."
	eq := Polynomial with: #( 6 2 ) .
	self assert: eq findRoots equals: 1 .
	self assert: (eq realRoots at: 1) equals: 3 negated .
	
	"Negative slope, positive x."
	eq := Polynomial with: #( 9 -3 ) .
	self assert: eq findRoots equals: 1 .
	self assert: (eq realRoots at: 1) equals: 3 .
	
	"Negative slope, negative x."
	eq := Polynomial with: #( -2 -0.5 ) .
	self assert: eq findRoots equals: 1 .
	self assert: (eq realRoots at: 1) equals: 4 negated .
	
]

{ #category : #tests }
AnalyticSolutionsTest >> testDegreeThree [
	"y = ax^3 + bx^2 + cx + d = 0"
	
	| eq |
	"Improper cubic equation."
	eq := Polynomial with: #( 5 -2 -3 0 ) .
	self should: [ eq findRoots ] raise: Error .
	
	"Three real roots."
	eq := Polynomial with: #( 6 -5 -2 1 ) .
	self assert: eq findRoots equals: 3 .
	self assert: (eq realRoots at: 3) closeTo: 3 .
	self assert: (eq realRoots at: 2) closeTo: 1 .
	self assert: (eq realRoots at: 1) closeTo: -2 .

	"One real root, two complex conjugate roots."
	eq := Polynomial with: #( 9 17 10 2 ) .
	self assert: eq findRoots equals: 1 .
	self assert: (eq realRoots at: 3) closeTo: -2 .
	self assert: (eq realRoots at: 2) closeTo: -2 .
	self assert: (eq realRoots at: 1) closeTo: -1 .
	self assert: (eq imagRoots at: 3) closeTo: -0.70710678 .
	self assert: (eq imagRoots at: 2) closeTo: 0.70710678 .
	self assert: (eq imagRoots at: 1) closeTo: 0 .

	"One real root, two pure imaginary roots."
	eq := Polynomial with: #( -6 2 -3 1) .
	self assert: eq findRoots equals: 1 .
	self assert: (eq realRoots at: 3) closeTo: 0 .
	self assert: (eq realRoots at: 2) closeTo: 0 .
	self assert: (eq realRoots at: 1) closeTo: 3 .
	self assert: (eq imagRoots at: 3) closeTo: -1.41421356 .
	self assert: (eq imagRoots at: 2) closeTo: 1.41421356 .
	self assert: (eq imagRoots at: 1) closeTo: 0 .
	
	"Double real + real roots."
	eq := Polynomial with: #( 12 -8 -1 1 ) .
	self assert: eq findRoots equals: 3 .
	self assert: (eq realRoots at: 3) closeTo: 2 .
	self assert: (eq realRoots at: 2) closeTo: 2 .
	self assert: (eq realRoots at: 1) closeTo: -3 .
	
	"Triple real roots."
	eq := Polynomial with: #( 27 0 0 1 ) .
	self assert: eq findRoots equals: 3 .
	self assert: (eq realRoots at: 3) closeTo: -3 .
	self assert: (eq realRoots at: 2) closeTo: -3 .
	self assert: (eq realRoots at: 1) closeTo: -3 .
]

{ #category : #tests }
AnalyticSolutionsTest >> testDegreeTwo [
	"y = ax^2 + bx + c = 0"
			
	| eq |
	"Improper quadratic equation."
	eq := Polynomial with: #( 5 2 0 ) .
	self should: [ eq findRoots ] raise: Error .
	
	"Real roots, opens upward."
	eq := Polynomial with: #( -1 -1 1 ) .
	self assert: eq findRoots equals: 2 .
	self assert: (eq realRoots at: 2) closeTo: 1.618033988 .
	self assert: (eq realRoots at: 1) closeTo: -0.618033988 .
	
	"Real roots, opens downward."
	eq := Polynomial with: #( -3 6.7082 -3 ) .
	self assert: eq findRoots equals: 2 .
	self assert: (eq realRoots at: 2) closeTo: 0.618033988 .
	self assert: (eq realRoots at: 1) closeTo: 1.618033988 .
	
	"Imaginary roots, opens upward."
	eq := Polynomial with: #( 3 -2 2 ) .
	self assert: eq findRoots equals: 0 .
	self assert: (eq realRoots at: 2) closeTo: 0.5 .
	self assert: (eq realRoots at: 1) closeTo: 0.5 .
	self assert: (eq imagRoots at: 2) closeTo: 1.1180334 .
	self assert: (eq imagRoots at: 1) closeTo: -1.1180334 .
	
	"Imaginary roots, opens downward."
	eq := Polynomial with: #( -29 -3 -0.5 ) .
	self assert: eq findRoots equals: 0 .
	self assert: (eq realRoots at: 2) closeTo: -3 .
	self assert: (eq realRoots at: 1) closeTo: -3 .
	self assert: (eq imagRoots at: 2) closeTo: -7 .
	self assert: (eq imagRoots at: 1) closeTo: 7 .
	
	"Double real root, opens upward."
	eq := Polynomial with: #( 25 -10 1 ) .
	self assert: eq findRoots equals: 2 .
	self assert: (eq realRoots at: 2) closeTo: 5 .
	self assert: (eq realRoots at: 1) closeTo: 5 .
	
	"Double real root, opens downward."
	eq := Polynomial with: #( -18 -12 -2 ) .
	self assert: eq findRoots equals: 2 .
	self assert: (eq realRoots at: 2) closeTo: -3 .
	self assert: (eq realRoots at: 1) closeTo: -3 .
	
	"Pure imaginary roots, opens upward."
	eq := Polynomial with: #( 16 0 1 ) .
	self assert: eq findRoots equals: 0 .
	self assert: (eq realRoots at: 2) equals: 0 .
	self assert: (eq realRoots at: 1) equals: 0 .
	self assert: (eq imagRoots at: 2) closeTo: 4 .
	self assert: (eq imagRoots at: 1) closeTo: -4 .
	
	"Pure imaginary roots, opens downward."
	eq := Polynomial with: #( -3 0 -0.333333333 ) .
	self assert: eq findRoots equals: 0 .
	self assert: (eq realRoots at: 2) equals: 0 .
	self assert: (eq realRoots at: 1) equals: 0 .
	self assert: (eq imagRoots at: 2) closeTo: -3 .
	self assert: (eq imagRoots at: 1) closeTo: 3 .
]

{ #category : #tests }
AnalyticSolutionsTest >> testDegreeZero [
	"Verify that this throws an error if the polynomial is not defined."	
			
	| eq |
	"Finding roots of an 'empty' polynomial should throw an error."
	eq := Polynomial new .
	self should: [eq findRoots] raise: Error .
	
	"Finding roots of a polynomial with nonsense coefficients should throw an error."
	eq := Polynomial with: 'abc' .
	self should: [eq findRoots] raise: Error .
	
	"Finding roots of a polynomial with an empty coefficients array should throw an error."
	eq := Polynomial with: #( ) .
	self should: [eq findRoots] raise: Error .
	
]
