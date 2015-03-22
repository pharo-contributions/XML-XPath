"
This is an abstract base class for node tests parser contexts.
"
Class {
	#name : #XPathNodeTestParserContext,
	#superclass : #Object,
	#classInstVars : [
		'instance'
	],
	#category : #'XPath-Core-Parsers'
}

{ #category : #'instance creation' }
XPathNodeTestParserContext class >> new [
	"these classes are shared immutable for efficiency"
	^ instance ifNil: [instance := self basicNew initialize]
]

{ #category : #handling }
XPathNodeTestParserContext >> handleEmptyTestWith: aHandler [
	self subclassResponsibility
]

{ #category : #handling }
XPathNodeTestParserContext >> handleTestForAnyNameWith: aHandler [
	self subclassResponsibility
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
XPathNodeTestParserContext >> handleTestForPrefix: aPrefix localName: aLocalName with: aHandler [
	self subclassResponsibility
]

{ #category : #handling }
XPathNodeTestParserContext >> handleTestForPrefix: aPrefix with: aHandler [
	self subclassResponsibility
]

{ #category : #testing }
XPathNodeTestParserContext >> isTypeTestParserContext [
	self subclassResponsibility
]
