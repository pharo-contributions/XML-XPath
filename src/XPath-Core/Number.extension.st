Extension { #name : #Number }

{ #category : #'*XPath-Core-converting' }
Number >> asXPathBoolean [
	^ (self isNaN
		or: [self isZero]) not
]

{ #category : #'*XPath-Core-converting' }
Number >> asXPathComparable [
	^ XPathNumberComparable value: self
]

{ #category : #'*XPath-Core-converting' }
Number >> asXPathFilterExpressionLocationPathRoot [
	XPathTypeException signal: 'Cannot use numbers as location path roots'
]

{ #category : #'*XPath-Core-converting' }
Number >> asXPathFilterable [
	XPathTypeException signal: 'Cannot filter numbers'
]

{ #category : #'*XPath-Core-converting' }
Number >> asXPathNodeSet [
	XPathTypeException signal: 'Cannot convert numbers to node sets'
]

{ #category : #'*XPath-Core-converting' }
Number >> asXPathNumber [
	^ self asFloat
]

{ #category : #'*XPath-Core-converting' }
Number >> asXPathString [
	"NaN is converted to the string NaN
	positive zero is converted to the string 0
	negative zero is converted to the string 0
	positive infinity is converted to the string Infinity
	negative infinity is converted to the string -Infinity"
	self isNaN
		ifTrue: [^ 'NaN'].
	self isZero
		ifTrue: [^ '0'].
	self isInfinite
		ifTrue: [
			self negative
				ifTrue: [^ '-Infinity']
				ifFalse: [^ 'Infinity']].

	"integers and floats with no fractional part must be printed as integers,
	so 1 and 1.0 are both output as '1' and -1 and -1.0 are output as '-1'"
	self fractionPart isZero
		ifTrue: [
			"#integerPart returns a float, so it can't be used"
			^ self asInteger asString]
		ifFalse: [| writeStream |
			"use asFloat to convert types like GS's DecimalFloat that don't
			have #printOn:base: (#asString works here on newer GS versions,
			but for backwards compatibility with older versions where it
			gives scientific notation, it isn't used)"
			writeStream := (String new: 10) writeStream.
			self asFloat
				printOn: writeStream
				base: 10.
			^ writeStream contents].
]

{ #category : #'*XPath-Core-converting' }
Number >> asXPathUnionable [
	XPathTypeException signal: 'Cannot union numbers'
]

{ #category : #'*XPath-Core-testing' }
Number >> hasSameXPathSignAs: aNumber [
	"#sign/#sign: do not behave consistently across Pharo/Squeak/GS"
	^ (self negative
		or: [self isXPathNegativeZero]) =
			(aNumber negative
				or: [aNumber isXPathNegativeZero])
]

{ #category : #'*XPath-Core-evaluating' }
Number >> xPathCeiling [
	(self isNaN
		or: [self isInfinite])
		ifTrue: [^ Float nan]
		ifFalse: [^ self ceiling]
]

{ #category : #'*XPath-Core-evaluating' }
Number >> xPathDivision: aDivisor [
	self isNaN
		ifTrue: [^ self].

	aDivisor isZero
		ifTrue: [
			self isZero
				ifTrue: [^ Float nan].
			"if the signs are different, the result should be negative infinity"
			(self hasSameXPathSignAs: aDivisor)
				ifTrue: [^ Float infinity]
				ifFalse: [
					"avoid #negativeInfinity for portability"
					^ Float infinity negated]].

	^ self / aDivisor.
]

{ #category : #'*XPath-Core-evaluating' }
Number >> xPathFloor [
	(self isNaN
		or: [self isInfinite])
		ifTrue: [^ Float nan]
		ifFalse: [^ self floor]
]

{ #category : #'*XPath-Core-evaluating' }
Number >> xPathModulus: aDivisor [
	| modulus |

	"XPath modulus must take the sign of the receiver unlike #// which
	takes the sign of the argument"
	modulus := self - ((self xPathDivision: aDivisor) xPathFloor * aDivisor).
	(modulus hasSameXPathSignAs: self)
		ifTrue: [^ modulus]
		ifFalse: [^ modulus negated].
]

{ #category : #'*XPath-Core-evaluating' }
Number >> xPathRounded [
	| rounded |

	(self isNaN
		or: [self isZero
			or: [self isInfinite]])
		ifTrue: [^ self].

	((rounded := (self + 0.5) xPathFloor) isZero
		and: [self negative])
		ifTrue: [^ -0.0]
		ifFalse: [^ rounded].
]
