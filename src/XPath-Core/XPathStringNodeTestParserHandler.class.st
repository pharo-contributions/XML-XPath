"
A handler for node tests that occur in string arguments to the abbreviated axis selectors. It converts them to node test blocks.
"
Class {
	#name : #XPathStringNodeTestParserHandler,
	#superclass : #XPathNodeTestParserHandler,
	#category : #'XPath-Core-Parsers'
}

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleEmptyTest [
	self errorExpected: 'XPath node test'
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForAnyLocalNameAfterPrefix: aPrefix [
	self parsingResult:
		[:node |
			node isPrincipalNode
				and: [node prefix = aPrefix]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForAnyName [
	self parsingResult: [:node | node isPrincipalNode]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForAnyPrefixBeforeLocalName: aLocalName [
	self parsingResult:
		[:node |
			node isPrincipalNode
				and: [node localName = aLocalName]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForCommentType [
	self parsingResult: [:node | node isComment]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForLocalName: aLocalName [
	self parsingResult:
		[:node |
			node isPrincipalNode
				and: [node localName = aLocalName]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForNamespaceURI: aNamespaceUri localName: aLocalName [
	self parsingResult:
		[:node |
			node isPrincipalNode
				and: [node namespaceURI = aNamespaceUri
					and: [node localName = aLocalName]]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForNodeType [
	self parsingResult: [:node | true]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForPIType: aName [
	aName isEmpty
		ifTrue: [self parsingResult: [:node | node isPI]]
		ifFalse: [
			self parsingResult:
				[:node |
					node isPI
						and: [node target = aName]]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForPrefix: aPrefix localName: aLocalName [
	self parsingResult:
		[:node |
			node isPrincipalNode
				and: [node localName = aLocalName
					and: [node prefix = aPrefix]]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForTextType [
	self parsingResult: [:node | node isStringNode]
]
