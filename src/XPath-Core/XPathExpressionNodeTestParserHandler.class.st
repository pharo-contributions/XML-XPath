"
A handler used by the expression parser for parsing node tests that are part of location path steps.
"
Class {
	#name : #XPathExpressionNodeTestParserHandler,
	#superclass : #XPathNodeTestParserHandler,
	#instVars : [
		'currentAxis',
		'expressionParserHandler'
	],
	#category : #'XPath-Core-Parsers'
}

{ #category : #'instance creation' }
XPathExpressionNodeTestParserHandler class >> currentAxis: anAxis expressionParserHandler: anExpressionParserHandler [
	^ self new
		setCurrentAxis: anAxis
		expressionParserHandler: anExpressionParserHandler
]

{ #category : #accessing }
XPathExpressionNodeTestParserHandler >> defaultNodeTestParserContextClass [
	^ currentAxis defaultNodeTestParserContextClass
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleEmptyTest [
	self parsingResult: false
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleStartParsing [
	self parsingResult: false
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForAnyNodeType [
	self startNodeTest.
	expressionParserHandler handleTestForAnyNodeType.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForAttributeWithAnyName [
	self startNodeTest.
	expressionParserHandler handleTestForAttributeWithAnyName.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForAttributeWithLocalName: aLocalName [
	self startNodeTest.
	expressionParserHandler handleTestForAttributeWithLocalName: aLocalName.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForAttributeWithName: aName [
	self startNodeTest.
	expressionParserHandler handleTestForAttributeWithName: aName.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForAttributeWithNamespaceURI: aURI [
	self startNodeTest.
	expressionParserHandler handleTestForAttributeWithNamespaceURI: aURI.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForAttributeWithNamespaceURI: aURI localName: aLocalName [
	self startNodeTest.
	expressionParserHandler
		handleTestForAttributeWithNamespaceURI: aURI
		localName: aLocalName.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForAttributeWithPrefix: aPrefix [
	self startNodeTest.
	expressionParserHandler handleTestForAttributeWithPrefix: aPrefix.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForAttributeWithPrefix: aPrefix localName: aLocalName [
	self startNodeTest.
	expressionParserHandler
		handleTestForAttributeWithPrefix: aPrefix
		localName: aLocalName.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForCommentType [
	self startNodeTest.
	expressionParserHandler handleTestForCommentType.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForElementWithAnyName [
	self startNodeTest.
	expressionParserHandler handleTestForElementWithAnyName.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForElementWithLocalName: aLocalName [
	self startNodeTest.
	expressionParserHandler handleTestForElementWithLocalName: aLocalName.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForElementWithName: aName [
	self startNodeTest.
	expressionParserHandler handleTestForElementWithName: aName.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForElementWithNamespaceURI: aURI [
	self startNodeTest.
	expressionParserHandler handleTestForElementWithNamespaceURI: aURI.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForElementWithNamespaceURI: aURI localName: aLocalName [
	self startNodeTest.
	expressionParserHandler
		handleTestForElementWithNamespaceURI: aURI
		localName: aLocalName.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForElementWithPrefix: aPrefix [
	self startNodeTest.
	expressionParserHandler handleTestForElementWithPrefix: aPrefix.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForElementWithPrefix: aPrefix localName: aLocalName [
	self startNodeTest.
	expressionParserHandler
		handleTestForElementWithPrefix: aPrefix
		localName: aLocalName.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForNamespaceWithAnyName [
	self startNodeTest.
	expressionParserHandler handleTestForNamespaceWithAnyName.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForNamespaceWithLocalName: aLocalName [
	self startNodeTest.
	expressionParserHandler handleTestForNamespaceWithLocalName: aLocalName.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForNamespaceWithName: aName [
	self startNodeTest.
	expressionParserHandler handleTestForNamespaceWithName: aName.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForNamespaceWithNamespaceURI: aURI [
	self startNodeTest.
	expressionParserHandler handleTestForNamespaceWithNamespaceURI: aURI.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForNamespaceWithNamespaceURI: aURI localName: aLocalName [
	self startNodeTest.
	expressionParserHandler
		handleTestForNamespaceWithNamespaceURI: aURI
		localName: aLocalName.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForNamespaceWithPrefix: aPrefix [
	self startNodeTest.
	expressionParserHandler handleTestForNamespaceWithPrefix: aPrefix.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForNamespaceWithPrefix: aPrefix localName: aLocalName [
	self startNodeTest.
	expressionParserHandler
		handleTestForNamespaceWithPrefix: aPrefix
		localName: aLocalName.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForPIWithAnyName [
	self startNodeTest.
	expressionParserHandler handleTestForPIWithAnyName.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForPIWithName: aName [
	self startNodeTest.
	expressionParserHandler handleTestForPIWithName: aName.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForTextType [
	self startNodeTest.
	expressionParserHandler handleTestForTextType.
]

{ #category : #testing }
XPathExpressionNodeTestParserHandler >> mustBeAtEndAfterParsing [
	^ false
]

{ #category : #initialization }
XPathExpressionNodeTestParserHandler >> setCurrentAxis: anAxis expressionParserHandler: anExpressionParserHandler [
	currentAxis := anAxis.
	expressionParserHandler := anExpressionParserHandler.
]

{ #category : #private }
XPathExpressionNodeTestParserHandler >> startNodeTest [
	self parsingResult: true.
	currentAxis isStartOfRelativeLocationPath
		ifTrue: [expressionParserHandler handleStartRelativeLocationPath].
	expressionParserHandler handleAxis: currentAxis.
	currentAxis resetToImplicitAxis.
]
