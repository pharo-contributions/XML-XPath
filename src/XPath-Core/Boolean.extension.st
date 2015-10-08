Extension { #name : #Boolean }

{ #category : #'*XPath-Core-private' }
Boolean >> //!= anObject [
	^ anObject xPathNotEqualsBoolean: self
]

{ #category : #'*XPath-Core-private' }
Boolean >> //* anObject [
	^ self asXPathNumber * anObject asXPathNumber
]

{ #category : #'*XPath-Core-private' }
Boolean >> //+ anObject [
	^ self asXPathNumber + anObject asXPathNumber
]

{ #category : #'*XPath-Core-private' }
Boolean >> //- anObject [
	^ self asXPathNumber - anObject asXPathNumber
]

{ #category : #'*XPath-Core-private' }
Boolean >> /// anObject [
	^ self asXPathNumber / anObject asXPathNumber
]

{ #category : #'*XPath-Core-private' }
Boolean >> //< anObject [
	^ anObject xPathGreaterThanBoolean: self
]

{ #category : #'*XPath-Core-private' }
Boolean >> //<= anObject [
	^ (anObject xPathGreaterThanBoolean: self)
		or: [anObject xPathEqualsBoolean: self]
]

{ #category : #'*XPath-Core-private' }
Boolean >> //= anObject [
	^ anObject xPathEqualsBoolean: self
]

{ #category : #'*XPath-Core-private' }
Boolean >> //> anObject [
	^ anObject xPathLessThanBoolean: self
]

{ #category : #'*XPath-Core-private' }
Boolean >> //>= anObject [
	^ (anObject xPathLessThanBoolean: self)
		or: [anObject xPathEqualsBoolean: self]
]

{ #category : #'*XPath-Core-private' }
Boolean >> //? aThreeArgumentBlockOrNumber [
	XPathTypeException signal: 'Cannot filter booleans'
]

{ #category : #'*XPath-Core-private' }
Boolean >> //\\ anObject [
	^ self asXPathNumber \\ anObject asXPathNumber
]

{ #category : #'*XPath-Core-converting' }
Boolean >> asXPathBoolean [
	^ self
]

{ #category : #'*XPath-Core-converting' }
Boolean >> asXPathNumber [
	"Gemstone has TrueClass/FalseClass instead of True/False subclasses,
	so this is implemented in the superclass for portability"
	^ self
		ifTrue: [1.0]
		ifFalse: [0.0]
]

{ #category : #'*XPath-Core-converting' }
Boolean >> asXPathString [
	"Gemstone has TrueClass/FalseClass instead of True/False subclasses,
	so this is implemented in the superclass for portability"
	^ self
		ifTrue: ['true']
		ifFalse: ['false']
]

{ #category : #'*XPath-Core-private' }
Boolean >> xPathEqualsBoolean: aBoolean [
	^ self = aBoolean
]

{ #category : #'*XPath-Core-private' }
Boolean >> xPathEqualsNodeSet: aNodeSet [
	^ self = aNodeSet asXPathBoolean
]

{ #category : #'*XPath-Core-private' }
Boolean >> xPathEqualsNumber: aNumber [
	^ self = aNumber asXPathBoolean
]

{ #category : #'*XPath-Core-private' }
Boolean >> xPathEqualsString: aString [
	^ self = aString asXPathBoolean
]

{ #category : #'*XPath-Core-private' }
Boolean >> xPathGreaterThanBoolean: aBoolean [
	^ self asXPathNumber > aBoolean asXPathNumber
]

{ #category : #'*XPath-Core-private' }
Boolean >> xPathGreaterThanNodeSet: aNodeSet [
	^ self asXPathNumber > aNodeSet asXPathBoolean asXPathNumber
]

{ #category : #'*XPath-Core-private' }
Boolean >> xPathGreaterThanNumber: aNumber [
	^ self asXPathNumber > aNumber asXPathNumber
]

{ #category : #'*XPath-Core-private' }
Boolean >> xPathGreaterThanString: aString [
	^ self asXPathNumber > aString asXPathNumber
]

{ #category : #'*XPath-Core-private' }
Boolean >> xPathLessThanBoolean: aBoolean [
	^ self asXPathNumber < aBoolean asXPathNumber
]

{ #category : #'*XPath-Core-private' }
Boolean >> xPathLessThanNodeSet: aNodeSet [
	^ self asXPathNumber < aNodeSet asXPathBoolean asXPathNumber
]

{ #category : #'*XPath-Core-private' }
Boolean >> xPathLessThanNumber: aNumber [
	^ self asXPathNumber < aNumber asXPathNumber
]

{ #category : #'*XPath-Core-private' }
Boolean >> xPathLessThanString: aString [
	^ self asXPathNumber < aString asXPathNumber
]

{ #category : #'*XPath-Core' }
Boolean class >> xPathNewFrom: anObject [
	^ anObject asXPathBoolean
]

{ #category : #'*XPath-Core-private' }
Boolean >> xPathNotEqualsBoolean: aBoolean [
	^ self ~= aBoolean
]

{ #category : #'*XPath-Core-private' }
Boolean >> xPathNotEqualsNodeSet: aNodeSet [
	^ self ~= aNodeSet asXPathBoolean
]

{ #category : #'*XPath-Core-private' }
Boolean >> xPathNotEqualsNumber: aNumber [
	^ self ~= aNumber asXPathBoolean
]

{ #category : #'*XPath-Core-private' }
Boolean >> xPathNotEqualsString: aString [
	^ self ~= aString asXPathBoolean
]
