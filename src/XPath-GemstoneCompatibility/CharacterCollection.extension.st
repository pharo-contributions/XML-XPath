Extension { #name : #CharacterCollection }

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> //!= anObject [
	^ anObject xPathNotEqualsString: self
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> //* anObject [
	^ self asXPathNumber * anObject asXPathNumber
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> //+ anObject [
	^ self asXPathNumber + anObject asXPathNumber
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> //- anObject [
	^ self asXPathNumber - anObject asXPathNumber
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> /// anObject [
	^ self asXPathNumber / anObject asXPathNumber
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> //< anObject [
	^ anObject xPathGreaterThanString: self
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> //<= anObject [
	^ (anObject xPathGreaterThanString: self)
		or: [anObject xPathEqualsString: self]
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> //= anObject [
	^ anObject xPathEqualsString: self
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> //> anObject [
	^ anObject xPathLessThanString: self
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> //>= anObject [
	^ (anObject xPathLessThanString: self)
		or: [anObject xPathEqualsString: self]
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> //\\ anObject [
	^ self asXPathNumber \\ anObject asXPathNumber
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> asNodeTestBlock [
	^ (XPathNodeTestParser
		on: self
		for: XPathStringNodeTestParserHandler new) parse
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> asXPath [
	^ XPath for: self
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> asXPathBoolean [
	^ self notEmpty
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> asXPathNumber [
	^ Number xPathReadFrom: self readStream
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> asXPathString [
	^ self
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> xPathEqualsBoolean: aBoolean [
	^ self asXPathBoolean = aBoolean
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> xPathEqualsNodeSet: aNodeSet [
	^ aNodeSet anySatisfy: [:each | self = each asXPathString]
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> xPathEqualsNumber: aNumber [
	^ self asXPathNumber = aNumber
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> xPathEqualsString: aString [
	^ self = aString
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> xPathGreaterThanBoolean: aBoolean [
	^ self asXPathNumber > aBoolean asXPathNumber
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> xPathGreaterThanNodeSet: aNodeSet [
	| number |
	
	number := self asXPathNumber.
	^ aNodeSet anySatisfy: [:each | number > each asXPathString asXPathNumber].
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> xPathGreaterThanNumber: aNumber [
	^ self asXPathNumber > aNumber
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> xPathGreaterThanString: aString [
	^ self asXPathNumber > aString asXPathNumber
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> xPathLessThanBoolean: aBoolean [
	^ self asXPathNumber < aBoolean asXPathNumber
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> xPathLessThanNodeSet: aNodeSet [
	| number |
	
	number := self asXPathNumber.
	^ aNodeSet anySatisfy: [:each | number < each asXPathString asXPathNumber].
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> xPathLessThanNumber: aNumber [
	^ self asXPathNumber < aNumber
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> xPathLessThanString: aString [
	^ self asXPathNumber < aString asXPathNumber
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> xPathNotEqualsBoolean: aBoolean [
	^ self asXPathBoolean ~= aBoolean
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> xPathNotEqualsNodeSet: aNodeSet [
	^ aNodeSet anySatisfy: [:each | self ~= each asXPathString]
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> xPathNotEqualsNumber: aNumber [
	^ self asXPathNumber ~= aNumber
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> xPathNotEqualsString: aString [
	^ self ~= aString
]
