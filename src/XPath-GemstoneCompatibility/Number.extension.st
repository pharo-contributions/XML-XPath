Extension { #name : #Number }

{ #category : #'*XPath-GemstoneCompatibility' }
Number >> isXPathNegativeZero [
	"use #asFloat to convert non-floats and DecimalFloats that don't
	understand #signBit before testing it"
	^ self isZero
		and: [self asFloat signBit = 1]
]

{ #category : #'*XPath-GemstoneCompatibility' }
Number >> isXPathPositiveZero [
	"see the #isXPathNegativeZero comment"
	^ self isZero
		and: [self asFloat signBit isZero]
]
