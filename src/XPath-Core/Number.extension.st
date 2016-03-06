Extension { #name : #Number }

{ #category : #'*XPath-Core-converting' }
Number >> asXPathBoolean [
	^ (self isZero or: [self isNaN]) not
]

{ #category : #'*XPath-Core-converting' }
Number >> asXPathComparable [
	^ XPathNumberComparable value: self
]

{ #category : #'*XPath-Core-converting' }
Number >> asXPathFilterable [
	XPathTypeException signal: 'Cannot filter numbers'
]

{ #category : #'*XPath-Core-converting' }
Number >> asXPathLocationPathRoot [
	XPathTypeException signal: 'Cannot use numbers as location path roots'
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
	self isNaN
		ifTrue: [^ 'NaN'].
	self isZero
		ifTrue: [^ '0'].
	self isInfinite
		ifTrue: [
			self < 0
				ifTrue: [^ '-Infinity']
				ifFalse: [^ 'Infinity']].

	"printOn:base: can correctly print BinaryFloats in decimal notation
	on GS (asString uses scientific), but printOn:base: can't be used with
	integers because it shows the 10r radix, and printOn:base:showRadix:
	can't be used either because floats don't understand it, so integers
	and floats are handled separately"
	self isInteger
		ifTrue: [^ self asString]
		ifFalse: [| writeStream |
			writeStream := (String new: 10) writeStream.
			"use asFloat to convert types like GS's DecimalFloat that don't
			have printOn:base:"
			self asFloat
				printOn: writeStream
				base: 10.
			^ writeStream contents].
]

{ #category : #'*XPath-Core-converting' }
Number >> asXPathUnionable [
	XPathTypeException signal: 'Cannot union numbers'
]

{ #category : #'*XPath-Core' }
Number class >> xPathNewFrom: anObject [
	^ anObject asXPathNumber
]

{ #category : #'*XPath-Core' }
Number class >> xPathReadFrom: aStream [
	| number |

	aStream xPathSkipSeparators.
	[number := Float readFrom: aStream]
		on: Error
		do: [:error | ^ Float nan].
	
	aStream xPathSkipSeparators.
	aStream atEnd
		ifFalse: [^ Float nan].

	^ number.
]
