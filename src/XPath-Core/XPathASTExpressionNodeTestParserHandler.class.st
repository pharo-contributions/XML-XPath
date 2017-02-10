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
XPathASTExpressionNodeTestParserHandler >> handleAttributeNodeTest [
	self startNodeTest.
	expressionParserHandler handleAttributeNodeTest.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleAttributeNodeTestForLocalName: aLocalName [
	self startNodeTest.
	expressionParserHandler handleAttributeNodeTestForLocalName: aLocalName.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleAttributeNodeTestForName: aName [
	self startNodeTest.
	expressionParserHandler handleAttributeNodeTestForName: aName.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleAttributeNodeTestForNamespaceURI: aURI [
	self startNodeTest.
	expressionParserHandler handleAttributeNodeTestForNamespaceURI: aURI.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleAttributeNodeTestForNamespaceURI: aURI localName: aLocalName [
	self startNodeTest.
	expressionParserHandler
		handleAttributeNodeTestForNamespaceURI: aURI
		localName: aLocalName.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleAttributeNodeTestForPrefix: aPrefix [
	self startNodeTest.
	expressionParserHandler handleAttributeNodeTestForPrefix: aPrefix.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleAttributeNodeTestForPrefix: aPrefix localName: aLocalName [
	self startNodeTest.
	expressionParserHandler
		handleAttributeNodeTestForPrefix: aPrefix
		localName: aLocalName.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleCommentNodeTest [
	self startNodeTest.
	expressionParserHandler handleCommentNodeTest.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleElementNodeTest [
	self startNodeTest.
	expressionParserHandler handleElementNodeTest.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleElementNodeTestForLocalName: aLocalName [
	self startNodeTest.
	expressionParserHandler handleElementNodeTestForLocalName: aLocalName.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleElementNodeTestForName: aName [
	self startNodeTest.
	expressionParserHandler handleElementNodeTestForName: aName.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleElementNodeTestForNamespaceURI: aURI [
	self startNodeTest.
	expressionParserHandler handleElementNodeTestForNamespaceURI: aURI.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleElementNodeTestForNamespaceURI: aURI localName: aLocalName [
	self startNodeTest.
	expressionParserHandler
		handleElementNodeTestForNamespaceURI: aURI
		localName: aLocalName.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleElementNodeTestForPrefix: aPrefix [
	self startNodeTest.
	expressionParserHandler handleElementNodeTestForPrefix: aPrefix.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleElementNodeTestForPrefix: aPrefix localName: aLocalName [
	self startNodeTest.
	expressionParserHandler
		handleElementNodeTestForPrefix: aPrefix
		localName: aLocalName.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleNamespaceNodeTest [
	self startNodeTest.
	expressionParserHandler handleNamespaceNodeTest.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleNamespaceNodeTestForLocalName: aLocalName [
	self startNodeTest.
	expressionParserHandler handleNamespaceNodeTestForLocalName: aLocalName.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleNamespaceNodeTestForName: aName [
	self startNodeTest.
	expressionParserHandler handleNamespaceNodeTestForName: aName.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleNamespaceNodeTestForNamespaceURI: aURI [
	self startNodeTest.
	expressionParserHandler handleNamespaceNodeTestForNamespaceURI: aURI.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleNamespaceNodeTestForNamespaceURI: aURI localName: aLocalName [
	self startNodeTest.
	expressionParserHandler
		handleNamespaceNodeTestForNamespaceURI: aURI
		localName: aLocalName.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleNamespaceNodeTestForPrefix: aPrefix [
	self startNodeTest.
	expressionParserHandler handleNamespaceNodeTestForPrefix: aPrefix.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleNamespaceNodeTestForPrefix: aPrefix localName: aLocalName [
	self startNodeTest.
	expressionParserHandler
		handleNamespaceNodeTestForPrefix: aPrefix
		localName: aLocalName.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handlePINodeTest [
	self startNodeTest.
	expressionParserHandler handlePINodeTest.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handlePINodeTestForName: aName [
	self startNodeTest.
	expressionParserHandler handlePINodeTestForName: aName.
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleStartParsing [
	self parsingResult: false
]

{ #category : #handling }
XPathASTExpressionNodeTestParserHandler >> handleTextNodeTest [
	self startNodeTest.
	expressionParserHandler handleTextNodeTest.
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
