"
A handler for node tests that occur in string arguments to the axis selectors defined in the ""enumerating - axis"" category of XMLNode and subclasses. It converts them to node test blocks.
"
Class {
	#name : #XPathStringNodeTestParserHandler,
	#superclass : #XPathNodeTestParserHandler,
	#instVars : [
		'defaultNodeTestParserContextClass'
	],
	#category : #'XPath-Core-Parsers'
}

{ #category : #'instance creation' }
XPathStringNodeTestParserHandler class >> withAttributePrincipalNodeType [
	^ self new defaultNodeTestParserContextClass: XPathNodeTestParserAttributeContext
]

{ #category : #'instance creation' }
XPathStringNodeTestParserHandler class >> withElementPrincipalNodeType [
	^ self new defaultNodeTestParserContextClass: XPathNodeTestParserElementContext
]

{ #category : #'instance creation' }
XPathStringNodeTestParserHandler class >> withNamespacePrincipalNodeType [
	^ self new defaultNodeTestParserContextClass: XPathNodeTestParserNamespaceContext
]

{ #category : #accessing }
XPathStringNodeTestParserHandler >> defaultNodeTestParserContextClass [
	^ defaultNodeTestParserContextClass
]

{ #category : #accessing }
XPathStringNodeTestParserHandler >> defaultNodeTestParserContextClass: aClass [
	defaultNodeTestParserContextClass := aClass
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleAnyNodeTest [
	self parsingResult: [:node | true]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleAttributeTest [
	self parsingResult: [:node | node isAttribute]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleAttributeTestForLocalName: aLocalName [
	self parsingResult:
		[:node |
			node isAttribute
				and: [node localName = aLocalName]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleAttributeTestForName: aName [
	self parsingResult:
		[:node |
			node isAttribute
				and: [node name = aName]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleAttributeTestForNamespaceURI: aURI [
	self parsingResult:
		[:node |
			node isAttribute
				and: [node namespaceURI = aURI]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleAttributeTestForNamespaceURI: aURI localName: aLocalName [
	self parsingResult:
		[:node |
			node isAttribute
				and: [node localName = aLocalName
					and: [node namespaceURI = aURI]]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleAttributeTestForPrefix: aPrefix [
	self parsingResult:
		[:node |
			node isAttribute
				and: [node prefix = aPrefix]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleAttributeTestForPrefix: aPrefix localName: aLocalName [
	| name |

	name := aLocalName qualifyWithXMLPrefix: aPrefix.	
	self parsingResult:
		[:node |
			node isAttribute
				and: [node name = name]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleCommentTest [
	self parsingResult: [:node | node isComment]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleElementTest [
	self parsingResult: [:node | node isElement]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleElementTestForLocalName: aLocalName [
	self parsingResult:
		[:node |
			node isElement
				and: [node localName = aLocalName]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleElementTestForName: aName [
	self parsingResult:
		[:node |
			node isElement
				and: [node name = aName]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleElementTestForNamespaceURI: aURI [
	self parsingResult:
		[:node |
			node isElement
				and: [node namespaceURI = aURI]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleElementTestForNamespaceURI: aURI localName: aLocalName [
	self parsingResult:
		[:node |
			node isElement
				and: [node localName = aLocalName
					and: [node namespaceURI = aURI]]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleElementTestForPrefix: aPrefix [
	self parsingResult:
		[:node |
			node isElement
				and: [node prefix = aPrefix]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleElementTestForPrefix: aPrefix localName: aLocalName [
	| name |

	name := aLocalName qualifyWithXMLPrefix: aPrefix.	
	self parsingResult:
		[:node |
			node isElement
				and: [node name = name]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleEmptyTest [
	XPathSyntaxException signal: 'String arguments to axis selectors must contain node tests'
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleNamespaceTest [
	self parsingResult: [:node | node isNamespace]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleNamespaceTestForLocalName: aLocalName [
	self parsingResult:
		[:node |
			node isNamespace
				and: [node localName = aLocalName]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleNamespaceTestForName: aName [
	self parsingResult:
		[:node |
			node isNamespace
				and: [node name = aName]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleNamespaceTestForNamespaceURI: aURI [
	self parsingResult:
		[:node |
			node isNamespace
				and: [node namespaceURI = aURI]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleNamespaceTestForNamespaceURI: aURI localName: aLocalName [
	self parsingResult:
		[:node |
			node isNamespace
				and: [node localName = aLocalName
					and: [node namespaceURI = aURI]]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleNamespaceTestForPrefix: aPrefix [
	self parsingResult:
		[:node |
			node isNamespace
				and: [node prefix = aPrefix]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleNamespaceTestForPrefix: aPrefix localName: aLocalName [
	| name |

	name := aLocalName qualifyWithXMLPrefix: aPrefix.	
	self parsingResult:
		[:node |
			node isNamespace
				and: [node name = name]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handlePITest [
	self parsingResult: [:node | node isPI]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handlePITestForName: aName [
	self parsingResult:
		[:node |
			node isPI
				and: [node target = aName]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTextTest [
	self parsingResult: [:node | node isStringNode]
]
