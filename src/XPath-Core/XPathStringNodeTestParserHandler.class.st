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
XPathStringNodeTestParserHandler >> handleEmptyTest [
	XPathSyntaxException signal: 'String arguments to axis selectors must contain node tests'
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
XPathStringNodeTestParserHandler >> handleTestForAttributeWithNamespaceURI: aURI [
	self parsingResult:
		[:node |
			node isAttribute
				and: [node namespaceURI = aURI]]
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

	name := aLocalName qualifyWithXMLPrefix: aPrefix.	
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
XPathStringNodeTestParserHandler >> handleTestForElementWithNamespaceURI: aURI [
	self parsingResult:
		[:node |
			node isElement
				and: [node namespaceURI = aURI]]
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

	name := aLocalName qualifyWithXMLPrefix: aPrefix.	
	self parsingResult:
		[:node |
			node isElement
				and: [node name = name]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForNamespaceWithAnyName [
	self parsingResult: [:node | node isNamespace]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForNamespaceWithLocalName: aLocalName [
	self parsingResult:
		[:node |
			node isNamespace
				and: [node localName = aLocalName]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForNamespaceWithName: aName [
	self parsingResult:
		[:node |
			node isNamespace
				and: [node name = aName]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForNamespaceWithNamespaceURI: aURI [
	self parsingResult:
		[:node |
			node isNamespace
				and: [node namespaceURI = aURI]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForNamespaceWithNamespaceURI: aURI localName: aLocalName [
	self parsingResult:
		[:node |
			node isNamespace
				and: [node localName = aLocalName
					and: [node namespaceURI = aURI]]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForNamespaceWithPrefix: aPrefix [
	self parsingResult:
		[:node |
			node isNamespace
				and: [node prefix = aPrefix]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForNamespaceWithPrefix: aPrefix localName: aLocalName [
	| name |

	name := aLocalName qualifyWithXMLPrefix: aPrefix.	
	self parsingResult:
		[:node |
			node isNamespace
				and: [node name = name]]
]

{ #category : #handling }
XPathStringNodeTestParserHandler >> handleTestForPIWithAnyName [
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
XPathStringNodeTestParserHandler >> handleTestForTextType [
	self parsingResult: [:node | node isStringNode]
]
