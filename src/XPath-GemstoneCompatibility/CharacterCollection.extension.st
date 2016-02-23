Extension { #name : #CharacterCollection }

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> asXPath [
	^ XPath for: self
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> asXPathAttributeNodeTestBlock [
	"parses string as a node test to produce a node test block where attributes
	are the principal node type"
	^ (XPathNodeTestParser
		on: self
		for: XPathStringNodeTestParserHandler withAttributePrincipalNodeType) parse
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> asXPathBoolean [
	^ self notEmpty
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> asXPathComparable [
	^ XPathStringComparable value: self
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> asXPathFilterable [
	XPathTypeException signal: 'Cannot filter strings'
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> asXPathLocationPathRoot [
	XPathTypeException signal: 'Cannot use strings as location path roots'
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> asXPathNamespaceNodeTestBlock [
	"parses string as a node test to produce a node test block where namespaces
	are the principal node type"
	^ (XPathNodeTestParser
		on: self
		for: XPathStringNodeTestParserHandler withNamespacePrincipalNodeType) parse
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> asXPathNodeSet [
	XPathTypeException signal: 'Cannot convert strings to node sets'
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> asXPathNodeSetFilters [
	^ #()
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> asXPathNodeTestBlock [
	"parses string as a node test to produce a node test block"
	^ (XPathNodeTestParser
		on: self
		for: XPathStringNodeTestParserHandler withElementPrincipalNodeType) parse
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
CharacterCollection >> asXPathUnionable [
	XPathTypeException signal: 'Cannot union strings'
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> hasXPathNodeSetFilters [
	^ false
]
