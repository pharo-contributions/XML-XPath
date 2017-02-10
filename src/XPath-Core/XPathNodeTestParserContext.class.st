"
This is an abstract base class for node test parser contexts. Instances of subclasses are immutable and shared.
"
Class {
	#name : #XPathNodeTestParserContext,
	#superclass : #Object,
	#classInstVars : [
		'instance'
	],
	#category : #'XPath-Core-Parsers'
}

{ #category : #accessing }
XPathNodeTestParserContext class >> instance [
	^ instance
		ifNil: [instance := self basicNew initialize]
]

{ #category : #'instance creation' }
XPathNodeTestParserContext class >> new [
	"these classes are immutable and shared, so they are only initialized once"
	^ self instance
]

{ #category : #handling }
XPathNodeTestParserContext >> handleAnyNodeTestWith: aHandler [
	aHandler handleAnyNodeTest
]

{ #category : #handling }
XPathNodeTestParserContext >> handleCommentNodeTestWith: aHandler [
	aHandler handleCommentNodeTest
]

{ #category : #handling }
XPathNodeTestParserContext >> handleEmptyNodeTestWith: aHandler [
	aHandler handleEmptyNodeTest
]

{ #category : #handling }
XPathNodeTestParserContext >> handleNodeTestForLocalName: aLocalName with: aHandler [
	self subclassResponsibility
]

{ #category : #handling }
XPathNodeTestParserContext >> handleNodeTestForName: aName with: aHandler [
	self subclassResponsibility

]

{ #category : #handling }
XPathNodeTestParserContext >> handleNodeTestForNamespaceURI: aURI localName: aLocalName with: aHandler [
	self subclassResponsibility
]

{ #category : #handling }
XPathNodeTestParserContext >> handleNodeTestForNamespaceURI: aURI with: aHandler [
	self subclassResponsibility
]

{ #category : #handling }
XPathNodeTestParserContext >> handleNodeTestForPrefix: aPrefix localName: aLocalName with: aHandler [
	self subclassResponsibility
]

{ #category : #handling }
XPathNodeTestParserContext >> handleNodeTestForPrefix: aPrefix with: aHandler [
	self subclassResponsibility
]

{ #category : #handling }
XPathNodeTestParserContext >> handlePINodeTestForName: aName with: aHandler [
	aHandler handlePINodeTestForName: aName
]

{ #category : #handling }
XPathNodeTestParserContext >> handlePINodeTestWith: aHandler [
	aHandler handlePINodeTest
]

{ #category : #handling }
XPathNodeTestParserContext >> handleTextNodeTestWith: aHandler [
	aHandler handleTextNodeTest
]

{ #category : #handling }
XPathNodeTestParserContext >> handleWildcardNodeTestWith: aHandler [
	self subclassResponsibility
]
