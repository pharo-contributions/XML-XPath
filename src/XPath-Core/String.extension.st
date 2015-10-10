Extension { #name : #String }

{ #category : #'*XPath-Core-private' }
String >> //!= anObject [
	^ anObject xPathNotEqualsString: self
]

{ #category : #'*XPath-Core-private' }
String >> //* anObject [
	^ self asXPathNumber * anObject asXPathNumber
]

{ #category : #'*XPath-Core-private' }
String >> //+ anObject [
	^ self asXPathNumber + anObject asXPathNumber
]

{ #category : #'*XPath-Core-private' }
String >> //- anObject [
	^ self asXPathNumber - anObject asXPathNumber
]

{ #category : #'*XPath-Core-private' }
String >> /// anObject [
	^ self asXPathNumber / anObject asXPathNumber
]

{ #category : #'*XPath-Core-private' }
String >> //< anObject [
	^ anObject xPathGreaterThanString: self
]

{ #category : #'*XPath-Core-private' }
String >> //<= anObject [
	^ (anObject xPathGreaterThanString: self)
		or: [anObject xPathEqualsString: self]
]

{ #category : #'*XPath-Core-private' }
String >> //= anObject [
	^ anObject xPathEqualsString: self
]

{ #category : #'*XPath-Core-private' }
String >> //> anObject [
	^ anObject xPathLessThanString: self
]

{ #category : #'*XPath-Core-private' }
String >> //>= anObject [
	^ (anObject xPathLessThanString: self)
		or: [anObject xPathEqualsString: self]
]

{ #category : #'*XPath-Core-private' }
String >> //? aThreeArgumentBlockOrNumber [
	XPathTypeException signal: 'Cannot filter strings'
]

{ #category : #'*XPath-Core-private' }
String >> //\\ anObject [
	^ self asXPathNumber \\ anObject asXPathNumber
]

{ #category : #'*XPath-Core-private' }
String >> asAttributeNodeTestBlock [
	"parses string as a node test to produce a node test block where attributes
	are the principal node type"
	^ (XPathNodeTestParser
		on: self
		for:
			(XPathStringNodeTestParserHandler defaultNodeTestParserContextClass:
				XPathNodeTestParserAttributeContext)) parse
]

{ #category : #'*XPath-Core-private' }
String >> asNamespaceNodeTestBlock [
	"parses string as a node test to produce a node test block where namespaces
	are the principal node type"
	^ (XPathNodeTestParser
		on: self
		for:
			(XPathStringNodeTestParserHandler defaultNodeTestParserContextClass:
				XPathNodeTestParserNamespaceContext)) parse
]

{ #category : #'*XPath-Core-private' }
String >> asNodeSetFilters [
	^ #()
]

{ #category : #'*XPath-Core-private' }
String >> asNodeTestBlock [
	"parses string as a node test to produce a node test block"
	^ (XPathNodeTestParser
		on: self
		for:
			(XPathStringNodeTestParserHandler defaultNodeTestParserContextClass:
				XPathNodeTestParserElementContext)) parse
]

{ #category : #'*XPath-Core-converting' }
String >> asXPath [
	^ XPath for: self
]

{ #category : #'*XPath-Core-converting' }
String >> asXPathBoolean [
	^ self notEmpty
]

{ #category : #'*XPath-Core-converting' }
String >> asXPathNumber [
	^ Number xPathReadFrom: self readStream
]

{ #category : #'*XPath-Core-converting' }
String >> asXPathString [
	^ self
]

{ #category : #'*XPath-Core-private' }
String >> xPathEqualsBoolean: aBoolean [
	^ self asXPathBoolean = aBoolean
]

{ #category : #'*XPath-Core-private' }
String >> xPathEqualsNodeSet: aNodeSet [
	^ aNodeSet anySatisfy: [:each | self = each stringValue]
]

{ #category : #'*XPath-Core-private' }
String >> xPathEqualsNumber: aNumber [
	^ self asXPathNumber = aNumber
]

{ #category : #'*XPath-Core-private' }
String >> xPathEqualsString: aString [
	^ self = aString
]

{ #category : #'*XPath-Core-private' }
String >> xPathGreaterThanBoolean: aBoolean [
	^ self asXPathNumber > aBoolean asXPathNumber
]

{ #category : #'*XPath-Core-private' }
String >> xPathGreaterThanNodeSet: aNodeSet [
	| number |
	
	number := self asXPathNumber.
	^ aNodeSet anySatisfy: [:each | number > each stringValue asXPathNumber].
]

{ #category : #'*XPath-Core-private' }
String >> xPathGreaterThanNumber: aNumber [
	^ self asXPathNumber > aNumber
]

{ #category : #'*XPath-Core-private' }
String >> xPathGreaterThanString: aString [
	^ self asXPathNumber > aString asXPathNumber
]

{ #category : #'*XPath-Core-private' }
String >> xPathLessThanBoolean: aBoolean [
	^ self asXPathNumber < aBoolean asXPathNumber
]

{ #category : #'*XPath-Core-private' }
String >> xPathLessThanNodeSet: aNodeSet [
	| number |
	
	number := self asXPathNumber.
	^ aNodeSet anySatisfy: [:each | number < each stringValue asXPathNumber].
]

{ #category : #'*XPath-Core-private' }
String >> xPathLessThanNumber: aNumber [
	^ self asXPathNumber < aNumber
]

{ #category : #'*XPath-Core-private' }
String >> xPathLessThanString: aString [
	^ self asXPathNumber < aString asXPathNumber
]

{ #category : #'*XPath-Core' }
String class >> xPathNewFrom: anObject [
	^ anObject asXPathString
]

{ #category : #'*XPath-Core-private' }
String >> xPathNotEqualsBoolean: aBoolean [
	^ self asXPathBoolean ~= aBoolean
]

{ #category : #'*XPath-Core-private' }
String >> xPathNotEqualsNodeSet: aNodeSet [
	^ aNodeSet anySatisfy: [:each | self ~= each stringValue]
]

{ #category : #'*XPath-Core-private' }
String >> xPathNotEqualsNumber: aNumber [
	^ self asXPathNumber ~= aNumber
]

{ #category : #'*XPath-Core-private' }
String >> xPathNotEqualsString: aString [
	^ self ~= aString
]
