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
	self parsingResult:
		[:node |
			node isPrincipalNode
				and: [node name isEmpty]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForAnyName [
	self parsingResult: [:node | node isPrincipalNode]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForAnyNodeType [
	self parsingResult: [:node | true]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForAttributeWithAnyName [
	self parsingResult: [:node | node isAttribute]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForAttributeWithLocalName: aLocalName [
	self parsingResult:
		[:node |
			node isAttribute
				and: [node localName = aLocalName]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForAttributeWithName: aName [
	self parsingResult:
		[:node |
			node isAttribute
				and: [node name = aName]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForAttributeWithNamespaceURI: aURI localName: aLocalName [
	self parsingResult:
		[:node |
			node isAttribute
				and: [node localName = aLocalName
					and: [node namespaceURI = aURI]]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForAttributeWithPrefix: aPrefix [
	self parsingResult:
		[:node |
			node isAttribute
				and: [node prefix = aPrefix]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForAttributeWithPrefix: aPrefix localName: aLocalName [
	| name |

	name := aLocalName qualifyWithPrefix: aPrefix.	
	self parsingResult:
		[:node |
			node isAttribute
				and: [node name = name]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForCommentType [
	self parsingResult: [:node | node isComment]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForElementWithAnyName [
	self parsingResult: [:node | node isElement]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForElementWithLocalName: aLocalName [
	self parsingResult:
		[:node |
			node isElement
				and: [node localName = aLocalName]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForElementWithName: aName [
	self parsingResult:
		[:node |
			node isElement
				and: [node name = aName]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForElementWithNamespaceURI: aURI localName: aLocalName [
	self parsingResult:
		[:node |
			node isElement
				and: [node localName = aLocalName
					and: [node namespaceURI = aURI]]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForElementWithPrefix: aPrefix [
	self parsingResult:
		[:node |
			node isElement
				and: [node prefix = aPrefix]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForElementWithPrefix: aPrefix localName: aLocalName [
	| name |

	name := aLocalName qualifyWithPrefix: aPrefix.	
	self parsingResult:
		[:node |
			node isElement
				and: [node name = name]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForLocalName: aLocalName [
	self parsingResult:
		[:node |
			node isPrincipalNode
				and: [node localName = aLocalName]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForName: aName [
	self parsingResult:
		[:node |
			node isPrincipalNode
				and: [node name = aName]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForNamespaceType [
	self parsingResult: [:node | node isNamespace]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForNamespaceURI: aURI localName: aLocalName [
	self parsingResult:
		[:node |
			node isPrincipalNode
				and: [node localName = aLocalName
					and: [node namespaceURI = aURI]]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForPIType [
	self parsingResult: [:node | node isPI]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForPIWithName: aName [
	self parsingResult:
		[:node |
			node isPI
				and: [node target = aName]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForPrefix: aPrefix [
	self parsingResult:
		[:node |
			node isPrincipalNode
				and: [node prefix = aPrefix]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForPrefix: aPrefix localName: aLocalName [
	| name |

	name := aLocalName qualifyWithPrefix: aPrefix.	
	self parsingResult:
		[:node |
			node isPrincipalNode
				and: [node name = name]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForTextType [
	self parsingResult: [:node | node isStringNode]
]
