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

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleEmptyTest [
	self parsingResult: false
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleStartParsing [
	self parsingResult: false
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForAnyName [
	self startNodeTest.
	expressionParserHandler handleTestForAnyName.
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
XPathExpressionNodeTestParserHandler >> handleTestForAttributeWithNamespaceURI: aNamespaceUri localName: aLocalName [
	self startNodeTest.
	expressionParserHandler
		handleTestForAttributeWithNamespaceURI: aNamespaceUri
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
XPathExpressionNodeTestParserHandler >> handleTestForLocalName: aLocalName [
	self startNodeTest.
	expressionParserHandler handleTestForLocalName: aLocalName.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForName: aLocalName [
	self startNodeTest.
	expressionParserHandler handleTestForName: aLocalName.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForNamespaceType [
	self startNodeTest.
	expressionParserHandler handleTestForNamespaceType.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForNamespaceURI: aNamespaceUri localName: aLocalName [
	self startNodeTest.
	expressionParserHandler
		handleTestForNamespaceURI: aNamespaceUri
		localName: aLocalName.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForPIType [
	self startNodeTest.
	expressionParserHandler handleTestForPIType.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForPIWithName: aName [
	self startNodeTest.
	expressionParserHandler handleTestForPIWithName: aName.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForPrefix: aPrefix [
	self startNodeTest.
	expressionParserHandler handleTestForPrefix: aPrefix.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForPrefix: aPrefix localName: aLocalName [
	self startNodeTest.
	expressionParserHandler
		handleTestForPrefix: aPrefix
		localName: aLocalName.
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
	currentAxis handleWith: expressionParserHandler.
]
