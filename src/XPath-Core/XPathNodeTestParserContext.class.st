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
XPathNodeTestParserContext >> handleCommentTestWith: aHandler [
	aHandler handleCommentTest
]

{ #category : #handling }
XPathNodeTestParserContext >> handleEmptyTestWith: aHandler [
	aHandler handleEmptyTest
]

{ #category : #handling }
XPathNodeTestParserContext >> handlePITestForName: aName with: aHandler [
	aHandler handlePITestForName: aName
]

{ #category : #handling }
XPathNodeTestParserContext >> handlePITestWith: aHandler [
	aHandler handlePITest
]

{ #category : #handling }
XPathNodeTestParserContext >> handleTestForLocalName: aLocalName with: aHandler [
	self subclassResponsibility
]

{ #category : #handling }
XPathNodeTestParserContext >> handleTestForName: aName with: aHandler [
	self subclassResponsibility

]

{ #category : #handling }
XPathNodeTestParserContext >> handleTestForNamespaceURI: aURI localName: aLocalName with: aHandler [
	self subclassResponsibility
]

{ #category : #handling }
XPathNodeTestParserContext >> handleTestForNamespaceURI: aURI with: aHandler [
	self subclassResponsibility
]

{ #category : #handling }
XPathNodeTestParserContext >> handleTestForPrefix: aPrefix localName: aLocalName with: aHandler [
	self subclassResponsibility
]

{ #category : #handling }
XPathNodeTestParserContext >> handleTestForPrefix: aPrefix with: aHandler [
	self subclassResponsibility
]

{ #category : #handling }
XPathNodeTestParserContext >> handleTextTestWith: aHandler [
	aHandler handleTextTest
]

{ #category : #handling }
XPathNodeTestParserContext >> handleWildcardTestWith: aHandler [
	self subclassResponsibility
]
