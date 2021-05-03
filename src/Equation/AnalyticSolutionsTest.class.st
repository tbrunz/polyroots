Class {
	#name : #AnalyticSolutionsTest,
	#superclass : #TestCase,
	#category : #'Equation-Tests'
}

{ #category : #tests }
AnalyticSolutionsTest >> testDegreeFourWithComplexRoots [
	"y = ax^4 + bx^3 + cx^2 + dx + e = 0"
	
	| eq |
	"Two real, two complex roots."
	eq := Polynomial with: #( 300 -128 -11 -2 1 ) .
	self assert: eq findRoots equals: 2 .
	self assert: (eq realRoots at: 4) closeTo: 6 .
	self assert: (eq realRoots at: 3) closeTo: 2 .
	self assert: (eq realRoots at: 2) closeTo: -3 .
	self assert: (eq realRoots at: 1) closeTo: -3 .
	self assert: (eq imagRoots at: 2) closeTo: 4 .
	self assert: (eq imagRoots at: 1) closeTo: -4 .
	
	"Four complex roots."
	eq := Polynomial with: #( 306 54 43 6 1 ) .
	self assert: eq findRoots equals: 0 .
	self assert: (eq realRoots at: 4) closeTo: 0 .
	self assert: (eq realRoots at: 3) closeTo: 0 .
	self assert: (eq realRoots at: 2) closeTo: -3 .
	self assert: (eq realRoots at: 1) closeTo: -3 .
	self assert: (eq imagRoots at: 4) closeTo: 3 .
	self assert: (eq imagRoots at: 3) closeTo: -3 .
	self assert: (eq imagRoots at: 2) closeTo: 5 .
	self assert: (eq imagRoots at: 1) closeTo: -5 .
]

{ #category : #tests }
AnalyticSolutionsTest >> testDegreeFourWithRealRoots [
	"y = ax^4 + bx^3 + cx^2 + dx + e = 0"
	
	| eq |
	"Four real, unique roots, biquadratic, opens upward."
	eq := Polynomial with: #( 24 -14 -13 2 1 ) .
	self assert: eq findRoots equals: 4 .
	self assert: (eq realRoots at: 4) closeTo: 3 .
	self assert: (eq realRoots at: 3) closeTo: -2 .
	self assert: (eq realRoots at: 2) closeTo: 1 .
	self assert: (eq realRoots at: 1) closeTo: -4 .
	
	"Four real, unique roots, biquadratic, opens downward."
	eq := Polynomial with: #( -630 -456 204 24 -6 ) .
	self assert: eq findRoots equals: 4 .
	self assert: (eq realRoots at: 4) closeTo: 3 .
	self assert: (eq realRoots at: 3) closeTo: -2 .
	self assert: (eq realRoots at: 2) closeTo: 1 .
	self assert: (eq realRoots at: 1) closeTo: -4 .
]

{ #category : #tests }
AnalyticSolutionsTest >> testDegreeOne [
	"y = mx + b = 0"
	
	| eq |
	"Positive slope, positive x."
	eq := Polynomial with: #( -6 3 ) .
	self assert: eq findRoots equals: 1 .
	self assert: (eq realRoots at: 1) equals: 2 .
	
	"Positive slope, negative x."
	eq := Polynomial with: #( 6 2 ) .
	self assert: eq findRoots equals: 1 .
	self assert: (eq realRoots at: 1) equals: -3 .
	
	"Negative slope, positive x."
	eq := Polynomial with: #( 9 -3 ) .
	self assert: eq findRoots equals: 1 .
	self assert: (eq realRoots at: 1) equals: 3 .
	
	"Negative slope, negative x."
	eq := Polynomial with: #( -2 -0.5 ) .
	self assert: eq findRoots equals: 1 .
	self assert: (eq realRoots at: 1) equals: -4 .
	
]

{ #category : #tests }
AnalyticSolutionsTest >> testDegreeThreeWithComplexRoots [
	"y = ax^3 + bx^2 + cx + d = 0"
	
	| eq |
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
]

{ #category : #tests }
AnalyticSolutionsTest >> testDegreeThreeWithRealRoots [
	"y = ax^3 + bx^2 + cx + d = 0"
	
	| eq |
	"Three real roots."
	eq := Polynomial with: #( 6 -5 -2 1 ) .
	self assert: eq findRoots equals: 3 .
	self assert: (eq realRoots at: 3) closeTo: 3 .
	self assert: (eq realRoots at: 2) closeTo: 1 .
	self assert: (eq realRoots at: 1) closeTo: -2 .
	
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
AnalyticSolutionsTest >> testDegreeTwoWithComplexRoots [
	"y = ax^2 + bx + c = 0"
			
	| eq |
	"Complex roots, opens upward."
	eq := Polynomial with: #( 3 -2 2 ) .
	self assert: eq findRoots equals: 0 .
	self assert: (eq realRoots at: 2) closeTo: 0.5 .
	self assert: (eq realRoots at: 1) closeTo: 0.5 .
	self assert: (eq imagRoots at: 2) closeTo: 1.1180334 .
	self assert: (eq imagRoots at: 1) closeTo: -1.1180334 .
	
	"Complex roots, opens downward."
	eq := Polynomial with: #( -29 -3 -0.5 ) .
	self assert: eq findRoots equals: 0 .
	self assert: (eq realRoots at: 2) closeTo: -3 .
	self assert: (eq realRoots at: 1) closeTo: -3 .
	self assert: (eq imagRoots at: 2) closeTo: -7 .
	self assert: (eq imagRoots at: 1) closeTo: 7 .
]

{ #category : #tests }
AnalyticSolutionsTest >> testDegreeTwoWithDoubleRealRoots [
	"y = ax^2 + bx + c = 0"
			
	| eq |
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
]

{ #category : #tests }
AnalyticSolutionsTest >> testDegreeTwoWithImaginaryRoots [
	"y = ax^2 + bx + c = 0"
			
	| eq |
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
AnalyticSolutionsTest >> testDegreeTwoWithRealRoots [
	"y = ax^2 + bx + c = 0"
			
	| eq |
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

{ #category : #tests }
AnalyticSolutionsTest >> testImproperCoefficients [
	"Verify that this throws an error if the polynomial is not defined."	
			
	| eq |
	"Improper linear equation."
	eq := Polynomial with: #( 5 0 ) .
	self should: [ eq findRoots ] raise: Error .
	
	"Improper quadratic equation."
	eq := Polynomial with: #( 5 2 0 ) .
	self should: [ eq findRoots ] raise: Error .
	
	"Improper cubic equation."
	eq := Polynomial with: #( 5 -2 -3 0 ) .
	self should: [ eq findRoots ] raise: Error .
	
	"Improper quartic equation."
	eq := Polynomial with: #( 5 -2 -3 1 0 ) .
	self should: [ eq findRoots ] raise: Error .
	
	"Improper degree 5 equation."
	eq := Polynomial with: #( 7 5 -2 -3 1 0 ) .
	self should: [ eq findRoots ] raise: Error .
	
	"Improper degree 5+ equation."
	eq := Polynomial with: #( 3 7 5 -2 -3 1 0 ) .
	self should: [ eq findRoots ] raise: Error .
	
	
]
