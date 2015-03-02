Extension { #name : #String }

{ #category : #'*XPath-Core' }
String >> //!= anObject [
	^ anObject xPathNotEqualsString: self
]

{ #category : #'*XPath-Core' }
String >> //* anObject [
	^ self asXPathNumber * anObject asXPathNumber
]

{ #category : #'*XPath-Core' }
String >> //+ anObject [
	^ self asXPathNumber + anObject asXPathNumber
]

{ #category : #'*XPath-Core' }
String >> //- anObject [
	^ self asXPathNumber - anObject asXPathNumber
]

{ #category : #'*XPath-Core' }
String >> /// anObject [
	^ self asXPathNumber / anObject asXPathNumber
]

{ #category : #'*XPath-Core' }
String >> //< anObject [
	^ anObject xPathGreaterThanString: self
]

{ #category : #'*XPath-Core' }
String >> //<= anObject [
	^ (anObject xPathGreaterThanString: self)
		or: [anObject xPathEqualsString: self]
]

{ #category : #'*XPath-Core' }
String >> //= anObject [
	^ anObject xPathEqualsString: self
]

{ #category : #'*XPath-Core' }
String >> //> anObject [
	^ anObject xPathLessThanString: self
]

{ #category : #'*XPath-Core' }
String >> //>= anObject [
	^ (anObject xPathLessThanString: self)
		or: [anObject xPathEqualsString: self]
]

{ #category : #'*XPath-Core' }
String >> //\\ anObject [
	^ self asXPathNumber \\ anObject asXPathNumber
]

{ #category : #'*XPath-Core' }
String >> asNodeTestBlock [
	^ (XPathNodeTestParser
		on: self
		for: XPathStringNodeTestParserHandler new) parse
]

{ #category : #'*XPath-Core' }
String >> asXPath [
	^ XPath for: self
]

{ #category : #'*XPath-Core' }
String >> asXPathBoolean [
	^ self notEmpty
]

{ #category : #'*XPath-Core' }
String >> asXPathNumber [
	^ [Float readFrom: self readStream]
		on: Error
		do: [:error | Float nan]
]

{ #category : #'*XPath-Core' }
String >> asXPathString [
	^ self
]

{ #category : #'*XPath-Core' }
String >> xPathEqualsBoolean: aBoolean [
	^ self asXPathBoolean = aBoolean
]

{ #category : #'*XPath-Core' }
String >> xPathEqualsNodeSet: aNodeSet [
	^ aNodeSet anySatisfy: [:each | self = each asXPathString]
]

{ #category : #'*XPath-Core' }
String >> xPathEqualsNumber: aNumber [
	^ self asXPathNumber = aNumber
]

{ #category : #'*XPath-Core' }
String >> xPathEqualsString: aString [
	^ self = aString
]

{ #category : #'*XPath-Core' }
String >> xPathGreaterThanBoolean: aBoolean [
	^ self asXPathNumber > aBoolean asXPathNumber
]

{ #category : #'*XPath-Core' }
String >> xPathGreaterThanNodeSet: aNodeSet [
	| number |
	
	number := self asXPathNumber.
	^ aNodeSet anySatisfy: [:each | number > each asXPathString asXPathNumber].
]

{ #category : #'*XPath-Core' }
String >> xPathGreaterThanNumber: aNumber [
	^ self asXPathNumber > aNumber
]

{ #category : #'*XPath-Core' }
String >> xPathGreaterThanString: aString [
	^ self asXPathNumber > aString asXPathNumber
]

{ #category : #'*XPath-Core' }
String >> xPathLessThanBoolean: aBoolean [
	^ self asXPathNumber < aBoolean asXPathNumber
]

{ #category : #'*XPath-Core' }
String >> xPathLessThanNodeSet: aNodeSet [
	| number |
	
	number := self asXPathNumber.
	^ aNodeSet anySatisfy: [:each | number < each asXPathString asXPathNumber].
]

{ #category : #'*XPath-Core' }
String >> xPathLessThanNumber: aNumber [
	^ self asXPathNumber < aNumber
]

{ #category : #'*XPath-Core' }
String >> xPathLessThanString: aString [
	^ self asXPathNumber < aString asXPathNumber
]

{ #category : #'*XPath-Core' }
String class >> xPathNewFrom: anObject [
	^ anObject asXPathString
]

{ #category : #'*XPath-Core' }
String >> xPathNotEqualsBoolean: aBoolean [
	^ self asXPathBoolean ~= aBoolean
]

{ #category : #'*XPath-Core' }
String >> xPathNotEqualsNodeSet: aNodeSet [
	^ aNodeSet anySatisfy: [:each | self ~= each asXPathString]
]

{ #category : #'*XPath-Core' }
String >> xPathNotEqualsNumber: aNumber [
	^ self asXPathNumber ~= aNumber
]

{ #category : #'*XPath-Core' }
String >> xPathNotEqualsString: aString [
	^ self ~= aString
]
