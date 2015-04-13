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

{ #category : #'instance creation' }
XPathNodeTestParserContext class >> new [
	"these classes are shared immutable for efficiency"
	^ instance ifNil: [instance := self basicNew initialize]
]

{ #category : #testing }
XPathNodeTestParserContext >> canHandleTypeTests [
	^ true
]

{ #category : #handling }
XPathNodeTestParserContext >> handleEmptyTestWith: aHandler [
	aHandler handleEmptyTest
]

{ #category : #handling }
XPathNodeTestParserContext >> handleTestForAnyNameWith: aHandler [
	self subclassResponsibility
]

{ #category : #handling }
XPathNodeTestParserContext >> handleTestForAnyNodeTypeWith: aHandler [
	aHandler handleTestForAnyNodeType
]

{ #category : #handling }
XPathNodeTestParserContext >> handleTestForCommentTypeWith: aHandler [
	aHandler handleTestForCommentType
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
XPathNodeTestParserContext >> handleTestForNamespaceTypeWith: aHandler [
	aHandler handleTestForNamespaceWithAnyName
]

{ #category : #handling }
XPathNodeTestParserContext >> handleTestForNamespaceURI: aURI localName: aLocalName with: aHandler [
	self subclassResponsibility
]

{ #category : #handling }
XPathNodeTestParserContext >> handleTestForPITypeWith: aHandler [
	aHandler handleTestForPIWithAnyName
]

{ #category : #handling }
XPathNodeTestParserContext >> handleTestForPIWithName: aName with: aHandler [
	aHandler handleTestForPIWithName: aName
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
XPathNodeTestParserContext >> handleTestForTextTypeWith: aHandler [
	aHandler handleTestForTextType
]
