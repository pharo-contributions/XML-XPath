"
This is a handler class used by the AST expression parser handler for parsing node tests that are part of location path steps. It forwards its handler messages to the AST expression parser handler and returns a boolean as its parsing result indicating if a node test was parsed.
"
Class {
	#name : #XPathASTExpressionNodeTestParserHandler,
	#superclass : #XPathNodeTestParserHandler,
	#instVars : [
		'currentAxis',
		'expressionParserHandler'
	],
	#category : #'XPath-Core-Parsers'
}

{ #category : #'instance creation' }
XPathASTExpressionNodeTestParserHandler class >> currentAxis: anAxis expressionParserHandler: anExpressionParserHandler [
	^ self new
		setCurrentAxis: anAxis
		expressionParserHandler: anExpressionParserHandler
]

{ #category : #accessing }
XPathASTExpressionNodeTestParserHandler >> defaultNodeTestParserContextClass [
	^ currentAxis defaultNodeTestParserContextClass
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleAnyNodeTest [
	self startNodeTest.
	expressionParserHandler handleAnyNodeTest.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleAttributeTest [
	self startNodeTest.
	expressionParserHandler handleAttributeTest.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleAttributeTestForLocalName: aLocalName [
	self startNodeTest.
	expressionParserHandler handleAttributeTestForLocalName: aLocalName.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleAttributeTestForName: aName [
	self startNodeTest.
	expressionParserHandler handleAttributeTestForName: aName.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleAttributeTestForNamespaceURI: aURI [
	self startNodeTest.
	expressionParserHandler handleAttributeTestForNamespaceURI: aURI.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleAttributeTestForNamespaceURI: aURI localName: aLocalName [
	self startNodeTest.
	expressionParserHandler
		handleAttributeTestForNamespaceURI: aURI
		localName: aLocalName.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleAttributeTestForPrefix: aPrefix [
	self startNodeTest.
	expressionParserHandler handleAttributeTestForPrefix: aPrefix.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleAttributeTestForPrefix: aPrefix localName: aLocalName [
	self startNodeTest.
	expressionParserHandler
		handleAttributeTestForPrefix: aPrefix
		localName: aLocalName.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleCommentTest [
	self startNodeTest.
	expressionParserHandler handleCommentTest.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleElementTest [
	self startNodeTest.
	expressionParserHandler handleElementTest.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleElementTestForLocalName: aLocalName [
	self startNodeTest.
	expressionParserHandler handleElementTestForLocalName: aLocalName.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleElementTestForName: aName [
	self startNodeTest.
	expressionParserHandler handleElementTestForName: aName.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleElementTestForNamespaceURI: aURI [
	self startNodeTest.
	expressionParserHandler handleElementTestForNamespaceURI: aURI.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleElementTestForNamespaceURI: aURI localName: aLocalName [
	self startNodeTest.
	expressionParserHandler
		handleElementTestForNamespaceURI: aURI
		localName: aLocalName.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleElementTestForPrefix: aPrefix [
	self startNodeTest.
	expressionParserHandler handleElementTestForPrefix: aPrefix.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleElementTestForPrefix: aPrefix localName: aLocalName [
	self startNodeTest.
	expressionParserHandler
		handleElementTestForPrefix: aPrefix
		localName: aLocalName.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleEmptyTest [
	self parsingResult: false
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleNamespaceTest [
	self startNodeTest.
	expressionParserHandler handleNamespaceTest.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleNamespaceTestForLocalName: aLocalName [
	self startNodeTest.
	expressionParserHandler handleNamespaceTestForLocalName: aLocalName.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleNamespaceTestForName: aName [
	self startNodeTest.
	expressionParserHandler handleNamespaceTestForName: aName.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleNamespaceTestForNamespaceURI: aURI [
	self startNodeTest.
	expressionParserHandler handleNamespaceTestForNamespaceURI: aURI.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleNamespaceTestForNamespaceURI: aURI localName: aLocalName [
	self startNodeTest.
	expressionParserHandler
		handleNamespaceTestForNamespaceURI: aURI
		localName: aLocalName.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleNamespaceTestForPrefix: aPrefix [
	self startNodeTest.
	expressionParserHandler handleNamespaceTestForPrefix: aPrefix.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleNamespaceTestForPrefix: aPrefix localName: aLocalName [
	self startNodeTest.
	expressionParserHandler
		handleNamespaceTestForPrefix: aPrefix
		localName: aLocalName.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handlePITest [
	self startNodeTest.
	expressionParserHandler handlePITest.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handlePITestForName: aName [
	self startNodeTest.
	expressionParserHandler handlePITestForName: aName.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleStartParsing [
	self parsingResult: false
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleTextTest [
	self startNodeTest.
	expressionParserHandler handleTextTest.
]

{ #category : #testing }
XPathASTExpressionNodeTestParserHandler >> mustBeAtEndAfterParsing [
	^ false
]

{ #category : #initialization }
XPathASTExpressionNodeTestParserHandler >> setCurrentAxis: anAxis expressionParserHandler: anExpressionParserHandler [
	currentAxis := anAxis.
	expressionParserHandler := anExpressionParserHandler.
]

{ #category : #private }
XPathASTExpressionNodeTestParserHandler >> startNodeTest [
	self parsingResult: true.
	currentAxis isStartOfRelativeLocationPath
		ifTrue: [expressionParserHandler handleStartRelativeLocationPath].
	expressionParserHandler
		handleStartStep;
		perform: currentAxis handlerSelector.
	currentAxis beDefaultImplicitAxis.
]
