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
XPathExpressionNodeTestParserHandler >> handleTestForAnyLocalNameAfterPrefix: aPrefix [
	self startNodeTest.
	expressionParserHandler handleTestForAnyLocalNameAfterPrefix: aPrefix.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForAnyName [
	self startNodeTest.
	expressionParserHandler handleTestForAnyName.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForAnyPrefixBeforeLocalName: aLocalName [
	self startNodeTest.
	expressionParserHandler handleTestForAnyPrefixBeforeLocalName: aLocalName.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForCommentType [
	self startNodeTest.
	expressionParserHandler handleTestForCommentType.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForLocalName: aLocalName [
	self startNodeTest.
	expressionParserHandler handleTestForLocalName: aLocalName.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForNamespaceURI: aNamespaceUri localName: aLocalName [
	self startNodeTest.
	expressionParserHandler
		handleTestForNamespaceURI: aNamespaceUri
		localName: aLocalName.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForNodeType [
	self startNodeTest.
	expressionParserHandler handleTestForNodeType.
]

{ #category : #handling }
XPathExpressionNodeTestParserHandler >> handleTestForPIType: aName [
	self startNodeTest.
	expressionParserHandler handleTestForPIType: aName.
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
