Extension { #name : #Number }

{ #category : #'*XPath-Core' }
Number >> //!= anObject [
	^ anObject xPathNotEqualsNumber: self
]

{ #category : #'*XPath-Core' }
Number >> //* anObject [
	^ self asXPathNumber * anObject asXPathNumber
]

{ #category : #'*XPath-Core' }
Number >> //+ anObject [
	^ self asXPathNumber + anObject asXPathNumber
]

{ #category : #'*XPath-Core' }
Number >> //- anObject [
	^ self asXPathNumber - anObject asXPathNumber
]

{ #category : #'*XPath-Core' }
Number >> /// anObject [
	^ self asXPathNumber / anObject asXPathNumber
]

{ #category : #'*XPath-Core' }
Number >> //< anObject [
	^ anObject xPathGreaterThanNumber: self
]

{ #category : #'*XPath-Core' }
Number >> //<= anObject [
	^ (anObject xPathGreaterThanNumber: self)
		or: [anObject xPathEqualsNumber: self]
]

{ #category : #'*XPath-Core' }
Number >> //= anObject [
	^ anObject xPathEqualsNumber: self
]

{ #category : #'*XPath-Core' }
Number >> //> anObject [
	^ anObject xPathLessThanNumber: self
]

{ #category : #'*XPath-Core' }
Number >> //>= anObject [
	^ (anObject xPathLessThanNumber: self)
		or: [anObject xPathEqualsNumber: self]
]

{ #category : #'*XPath-Core' }
Number >> //\\ anObject [
	^ self asXPathNumber \\ anObject asXPathNumber
]

{ #category : #'*XPath-Core' }
Number >> asXPathBoolean [
	^ (self isZero or: [self isNaN]) not
]

{ #category : #'*XPath-Core' }
Number >> asXPathNumber [
	^ self asFloat
]

{ #category : #'*XPath-Core' }
Number >> asXPathString [
	self isNaN
		ifTrue: [^ 'NaN'].
	self isZero
		ifTrue: [^ '0'].
	self isInfinite
		ifTrue: [
			self < 0
				ifTrue: [^ '-Infinity']
				ifFalse: [^ 'Infinity']]
		ifFalse: [| stream |
			"printString does not return decimal strings on Gemstone"
			stream := (String new: 10) writeStream.
			self
				printOn: stream
				base: 10.
			^ stream contents].
]

{ #category : #'*XPath-Core' }
Number >> xPathEqualsBoolean: aBoolean [
	^ self asXPathBoolean = aBoolean
]

{ #category : #'*XPath-Core' }
Number >> xPathEqualsNodeSet: aNodeSet [
	^ aNodeSet anySatisfy: [:each | self = each asXPathString asXPathNumber]
]

{ #category : #'*XPath-Core' }
Number >> xPathEqualsNumber: aNumber [
	^ self = aNumber
]

{ #category : #'*XPath-Core' }
Number >> xPathEqualsString: aString [
	^ self = aString asXPathNumber
]

{ #category : #'*XPath-Core' }
Number >> xPathGreaterThanBoolean: aBoolean [
	^ self > aBoolean asXPathNumber
]

{ #category : #'*XPath-Core' }
Number >> xPathGreaterThanNodeSet: aNodeSet [
	^ aNodeSet anySatisfy: [:each | self > each asXPathString asXPathNumber]
]

{ #category : #'*XPath-Core' }
Number >> xPathGreaterThanNumber: aNumber [
	^ self > aNumber
]

{ #category : #'*XPath-Core' }
Number >> xPathGreaterThanString: aString [
	^ self > aString asXPathNumber
]

{ #category : #'*XPath-Core' }
Number >> xPathLessThanBoolean: aBoolean [
	^ self < aBoolean asXPathNumber
]

{ #category : #'*XPath-Core' }
Number >> xPathLessThanNodeSet: aNodeSet [
	^ aNodeSet anySatisfy: [:each | self < each asXPathString asXPathNumber]
]

{ #category : #'*XPath-Core' }
Number >> xPathLessThanNumber: aNumber [
	^ self < aNumber
]

{ #category : #'*XPath-Core' }
Number >> xPathLessThanString: aString [
	^ self < aString asXPathNumber
]

{ #category : #'*XPath-Core' }
Number class >> xPathNewFrom: anObject [
	^ anObject asXPathNumber
]

{ #category : #'*XPath-Core' }
Number >> xPathNotEqualsBoolean: aBoolean [
	^ self asXPathBoolean ~= aBoolean
]

{ #category : #'*XPath-Core' }
Number >> xPathNotEqualsNodeSet: aNodeSet [
	^ aNodeSet anySatisfy: [:each | self ~= each asXPathString asXPathNumber]
]

{ #category : #'*XPath-Core' }
Number >> xPathNotEqualsNumber: aNumber [
	^ self ~= aNumber
]

{ #category : #'*XPath-Core' }
Number >> xPathNotEqualsString: aString [
	^ self ~= aString asXPathNumber
]
