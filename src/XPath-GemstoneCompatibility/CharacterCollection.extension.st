Extension { #name : #CharacterCollection }

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> asXPath [
	^ XPath for: self
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> asXPathAttributeAxisNodeTest [
	"parse the receiver as a node test where attributes are the principal node type"
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
CharacterCollection >> asXPathFilterExpressionLocationPathRoot [
	XPathTypeException signal: 'Cannot use strings as location path roots'
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> asXPathFilterable [
	XPathTypeException signal: 'Cannot filter strings'
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> asXPathNamespaceAxisNodeTest [
	"parse the receiver as a node test where namespaces are the principal node type"
	^ (XPathNodeTestParser
		on: self
		for: XPathStringNodeTestParserHandler withNamespacePrincipalNodeType) parse
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> asXPathNodeSet [
	XPathTypeException signal: 'Cannot convert strings to node sets'
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> asXPathNodeTest [
	"parse the receiver as a node test where elements are the principal node type"
	^ (XPathNodeTestParser
		on: self
		for: XPathStringNodeTestParserHandler withElementPrincipalNodeType) parse
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> asXPathNumber [
	^ [(XPathNumberParser
			on: self
			for: XPathFloatNumberParserHandler new) parse]
		on: XPathSyntaxException
		do: [:error | Float nan]
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> asXPathString [
	^ self
]

{ #category : #'*XPath-GemstoneCompatibility' }
CharacterCollection >> asXPathUnionable [
	XPathTypeException signal: 'Cannot union strings'
]
