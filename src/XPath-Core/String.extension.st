Extension { #name : #String }

{ #category : #'*XPath-Core-converting' }
String >> asXPath [
	^ XPath for: self
]

{ #category : #'*XPath-Core-converting' }
String >> asXPathAttributeNodeTestBlock [
	"parses string as a node test to produce a node test block where attributes
	are the principal node type"
	^ (XPathNodeTestParser
		on: self
		for: XPathStringNodeTestParserHandler withAttributePrincipalNodeType) parse
]

{ #category : #'*XPath-Core-converting' }
String >> asXPathBoolean [
	^ self notEmpty
]

{ #category : #'*XPath-Core-converting' }
String >> asXPathComparable [
	^ XPathStringComparable value: self
]

{ #category : #'*XPath-Core-converting' }
String >> asXPathFilterable [
	XPathTypeException signal: 'Cannot filter strings'
]

{ #category : #'*XPath-Core-converting' }
String >> asXPathLocationPathRoot [
	XPathTypeException signal: 'Cannot use strings as location path roots'
]

{ #category : #'*XPath-Core-converting' }
String >> asXPathNamespaceNodeTestBlock [
	"parses string as a node test to produce a node test block where namespaces
	are the principal node type"
	^ (XPathNodeTestParser
		on: self
		for: XPathStringNodeTestParserHandler withNamespacePrincipalNodeType) parse
]

{ #category : #'*XPath-Core-converting' }
String >> asXPathNodeSet [
	XPathTypeException signal: 'Cannot convert strings to node sets'
]

{ #category : #'*XPath-Core-converting' }
String >> asXPathNodeSetFilters [
	^ #()
]

{ #category : #'*XPath-Core-converting' }
String >> asXPathNodeTestBlock [
	"parses string as a node test to produce a node test block"
	^ (XPathNodeTestParser
		on: self
		for: XPathStringNodeTestParserHandler withElementPrincipalNodeType) parse
]

{ #category : #'*XPath-Core-converting' }
String >> asXPathNumber [
	^ Number xPathReadFrom: self readStream
]

{ #category : #'*XPath-Core-converting' }
String >> asXPathString [
	^ self
]

{ #category : #'*XPath-Core-converting' }
String >> asXPathUnionable [
	XPathTypeException signal: 'Cannot union strings'
]

{ #category : #'*XPath-Core-testing' }
String >> hasXPathNodeSetFilters [
	^ false
]

{ #category : #'*XPath-Core' }
String class >> xPathNewFrom: anObject [
	^ anObject asXPathString
]
