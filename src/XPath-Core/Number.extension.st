Extension { #name : #Number }

{ #category : #'*XPath-Core-private' }
Number >> //!= anObject [
	^ anObject xPathNotEqualsNumber: self
]

{ #category : #'*XPath-Core-private' }
Number >> //* anObject [
	^ self asXPathNumber * anObject asXPathNumber
]

{ #category : #'*XPath-Core-private' }
Number >> //+ anObject [
	^ self asXPathNumber + anObject asXPathNumber
]

{ #category : #'*XPath-Core-private' }
Number >> //- anObject [
	^ self asXPathNumber - anObject asXPathNumber
]

{ #category : #'*XPath-Core-private' }
Number >> /// anObject [
	^ self asXPathNumber / anObject asXPathNumber
]

{ #category : #'*XPath-Core-private' }
Number >> //< anObject [
	^ anObject xPathGreaterThanNumber: self
]

{ #category : #'*XPath-Core-private' }
Number >> //<= anObject [
	^ (anObject xPathGreaterThanNumber: self)
		or: [anObject xPathEqualsNumber: self]
]

{ #category : #'*XPath-Core-private' }
Number >> //= anObject [
	^ anObject xPathEqualsNumber: self
]

{ #category : #'*XPath-Core-private' }
Number >> //> anObject [
	^ anObject xPathLessThanNumber: self
]

{ #category : #'*XPath-Core-private' }
Number >> //>= anObject [
	^ (anObject xPathLessThanNumber: self)
		or: [anObject xPathEqualsNumber: self]
]

{ #category : #'*XPath-Core-private' }
Number >> //\\ anObject [
	^ self asXPathNumber \\ anObject asXPathNumber
]

{ #category : #'*XPath-Core-converting' }
Number >> asXPathBoolean [
	^ (self isZero or: [self isNaN]) not
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
	"overridden in gemstone version to use greaseString"
	^ self printString.
]

{ #category : #'*XPath-Core-private' }
Number >> xPathEqualsBoolean: aBoolean [
	^ self asXPathBoolean = aBoolean
]

{ #category : #'*XPath-Core-private' }
Number >> xPathEqualsNodeSet: aNodeSet [
	^ aNodeSet anySatisfy: [:each | self = each stringValue asXPathNumber]
]

{ #category : #'*XPath-Core-private' }
Number >> xPathEqualsNumber: aNumber [
	^ self = aNumber
]

{ #category : #'*XPath-Core-private' }
Number >> xPathEqualsString: aString [
	^ self = aString asXPathNumber
]

{ #category : #'*XPath-Core-private' }
Number >> xPathGreaterThanBoolean: aBoolean [
	^ self > aBoolean asXPathNumber
]

{ #category : #'*XPath-Core-private' }
Number >> xPathGreaterThanNodeSet: aNodeSet [
	^ aNodeSet anySatisfy: [:each | self > each stringValue asXPathNumber]
]

{ #category : #'*XPath-Core-private' }
Number >> xPathGreaterThanNumber: aNumber [
	^ self > aNumber
]

{ #category : #'*XPath-Core-private' }
Number >> xPathGreaterThanString: aString [
	^ self > aString asXPathNumber
]

{ #category : #'*XPath-Core-private' }
Number >> xPathLessThanBoolean: aBoolean [
	^ self < aBoolean asXPathNumber
]

{ #category : #'*XPath-Core-private' }
Number >> xPathLessThanNodeSet: aNodeSet [
	^ aNodeSet anySatisfy: [:each | self < each stringValue asXPathNumber]
]

{ #category : #'*XPath-Core-private' }
Number >> xPathLessThanNumber: aNumber [
	^ self < aNumber
]

{ #category : #'*XPath-Core-private' }
Number >> xPathLessThanString: aString [
	^ self < aString asXPathNumber
]

{ #category : #'*XPath-Core' }
Number class >> xPathNewFrom: anObject [
	^ anObject asXPathNumber
]

{ #category : #'*XPath-Core-private' }
Number >> xPathNotEqualsBoolean: aBoolean [
	^ self asXPathBoolean ~= aBoolean
]

{ #category : #'*XPath-Core-private' }
Number >> xPathNotEqualsNodeSet: aNodeSet [
	^ aNodeSet anySatisfy: [:each | self ~= each stringValue asXPathNumber]
]

{ #category : #'*XPath-Core-private' }
Number >> xPathNotEqualsNumber: aNumber [
	^ self ~= aNumber
]

{ #category : #'*XPath-Core-private' }
Number >> xPathNotEqualsString: aString [
	^ self ~= aString asXPathNumber
]
