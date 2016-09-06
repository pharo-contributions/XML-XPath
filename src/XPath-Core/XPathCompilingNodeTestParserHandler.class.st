"
A handler used by the expression parser for parsing node tests that are part of location path steps.
"
Class {
	#name : #XPathCompilingNodeTestParserHandler,
	#superclass : #XPathNodeTestParserHandler,
	#instVars : [
		'currentAxis',
		'expressionParserHandler'
	],
	#category : #'XPath-Core-Compilation'
}

{ #category : #'instance creation' }
XPathCompilingNodeTestParserHandler class >> currentAxis: anAxis expressionParserHandler: anExpressionParserHandler [
	^ self new
		setCurrentAxis: anAxis
		expressionParserHandler: anExpressionParserHandler
]

{ #category : #accessing }
XPathCompilingNodeTestParserHandler >> defaultNodeTestParserContextClass [
	^ currentAxis defaultNodeTestParserContextClass
]

{ #category : #handling }
XPathCompilingNodeTestParserHandler >> handleEmptyTest [
	self parsingResult: false
]

{ #category : #handling }
XPathCompilingNodeTestParserHandler >> handleStartParsing [
	self parsingResult: false
]

{ #category : #handling }
XPathCompilingNodeTestParserHandler >> handleTestForAnyNodeType [
	self startNodeTest.
	expressionParserHandler handleTestForAnyNodeType.
]

{ #category : #handling }
XPathCompilingNodeTestParserHandler >> handleTestForAttributeWithAnyName [
	self startNodeTest.
	expressionParserHandler handleTestForAttributeWithAnyName.
]

{ #category : #handling }
XPathCompilingNodeTestParserHandler >> handleTestForAttributeWithLocalName: aLocalName [
	self startNodeTest.
	expressionParserHandler handleTestForAttributeWithLocalName: aLocalName.
]

{ #category : #handling }
XPathCompilingNodeTestParserHandler >> handleTestForAttributeWithName: aName [
	self startNodeTest.
	expressionParserHandler handleTestForAttributeWithName: aName.
]

{ #category : #handling }
XPathCompilingNodeTestParserHandler >> handleTestForAttributeWithNamespaceURI: aURI [
	self startNodeTest.
	expressionParserHandler handleTestForAttributeWithNamespaceURI: aURI.
]

{ #category : #handling }
XPathCompilingNodeTestParserHandler >> handleTestForAttributeWithNamespaceURI: aURI localName: aLocalName [
	self startNodeTest.
	expressionParserHandler
		handleTestForAttributeWithNamespaceURI: aURI
		localName: aLocalName.
]

{ #category : #handling }
XPathCompilingNodeTestParserHandler >> handleTestForAttributeWithPrefix: aPrefix [
	self startNodeTest.
	expressionParserHandler handleTestForAttributeWithPrefix: aPrefix.
]

{ #category : #handling }
XPathCompilingNodeTestParserHandler >> handleTestForAttributeWithPrefix: aPrefix localName: aLocalName [
	self startNodeTest.
	expressionParserHandler
		handleTestForAttributeWithPrefix: aPrefix
		localName: aLocalName.
]

{ #category : #handling }
XPathCompilingNodeTestParserHandler >> handleTestForCommentType [
	self startNodeTest.
	expressionParserHandler handleTestForCommentType.
]

{ #category : #handling }
XPathCompilingNodeTestParserHandler >> handleTestForElementWithAnyName [
	self startNodeTest.
	expressionParserHandler handleTestForElementWithAnyName.
]

{ #category : #handling }
XPathCompilingNodeTestParserHandler >> handleTestForElementWithLocalName: aLocalName [
	self startNodeTest.
	expressionParserHandler handleTestForElementWithLocalName: aLocalName.
]

{ #category : #handling }
XPathCompilingNodeTestParserHandler >> handleTestForElementWithName: aName [
	self startNodeTest.
	expressionParserHandler handleTestForElementWithName: aName.
]

{ #category : #handling }
XPathCompilingNodeTestParserHandler >> handleTestForElementWithNamespaceURI: aURI [
	self startNodeTest.
	expressionParserHandler handleTestForElementWithNamespaceURI: aURI.
]

{ #category : #handling }
XPathCompilingNodeTestParserHandler >> handleTestForElementWithNamespaceURI: aURI localName: aLocalName [
	self startNodeTest.
	expressionParserHandler
		handleTestForElementWithNamespaceURI: aURI
		localName: aLocalName.
]

{ #category : #handling }
XPathCompilingNodeTestParserHandler >> handleTestForElementWithPrefix: aPrefix [
	self startNodeTest.
	expressionParserHandler handleTestForElementWithPrefix: aPrefix.
]

{ #category : #handling }
XPathCompilingNodeTestParserHandler >> handleTestForElementWithPrefix: aPrefix localName: aLocalName [
	self startNodeTest.
	expressionParserHandler
		handleTestForElementWithPrefix: aPrefix
		localName: aLocalName.
]

{ #category : #handling }
XPathCompilingNodeTestParserHandler >> handleTestForNamespaceWithAnyName [
	self startNodeTest.
	expressionParserHandler handleTestForNamespaceWithAnyName.
]

{ #category : #handling }
XPathCompilingNodeTestParserHandler >> handleTestForNamespaceWithLocalName: aLocalName [
	self startNodeTest.
	expressionParserHandler handleTestForNamespaceWithLocalName: aLocalName.
]

{ #category : #handling }
XPathCompilingNodeTestParserHandler >> handleTestForNamespaceWithName: aName [
	self startNodeTest.
	expressionParserHandler handleTestForNamespaceWithName: aName.
]

{ #category : #handling }
XPathCompilingNodeTestParserHandler >> handleTestForNamespaceWithNamespaceURI: aURI [
	self startNodeTest.
	expressionParserHandler handleTestForNamespaceWithNamespaceURI: aURI.
]

{ #category : #handling }
XPathCompilingNodeTestParserHandler >> handleTestForNamespaceWithNamespaceURI: aURI localName: aLocalName [
	self startNodeTest.
	expressionParserHandler
		handleTestForNamespaceWithNamespaceURI: aURI
		localName: aLocalName.
]

{ #category : #handling }
XPathCompilingNodeTestParserHandler >> handleTestForNamespaceWithPrefix: aPrefix [
	self startNodeTest.
	expressionParserHandler handleTestForNamespaceWithPrefix: aPrefix.
]

{ #category : #handling }
XPathCompilingNodeTestParserHandler >> handleTestForNamespaceWithPrefix: aPrefix localName: aLocalName [
	self startNodeTest.
	expressionParserHandler
		handleTestForNamespaceWithPrefix: aPrefix
		localName: aLocalName.
]

{ #category : #handling }
XPathCompilingNodeTestParserHandler >> handleTestForPIWithAnyName [
	self startNodeTest.
	expressionParserHandler handleTestForPIWithAnyName.
]

{ #category : #handling }
XPathCompilingNodeTestParserHandler >> handleTestForPIWithName: aName [
	self startNodeTest.
	expressionParserHandler handleTestForPIWithName: aName.
]

{ #category : #handling }
XPathCompilingNodeTestParserHandler >> handleTestForTextType [
	self startNodeTest.
	expressionParserHandler handleTestForTextType.
]

{ #category : #testing }
XPathCompilingNodeTestParserHandler >> mustBeAtEndAfterParsing [
	^ false
]

{ #category : #initialization }
XPathCompilingNodeTestParserHandler >> setCurrentAxis: anAxis expressionParserHandler: anExpressionParserHandler [
	currentAxis := anAxis.
	expressionParserHandler := anExpressionParserHandler.
]

{ #category : #private }
XPathCompilingNodeTestParserHandler >> startNodeTest [
	self parsingResult: true.
	currentAxis isStartOfRelativeLocationPath
		ifTrue: [expressionParserHandler handleStartRelativeLocationPath].
	expressionParserHandler
		handleStartStep;
		handleAxis: currentAxis.
	currentAxis beDefaultImplicitAxis.
]
