"
This is a handler class for XPath expression parsers that generates an AST that can be searched and manipulated using AST node visitors.
"
Class {
	#name : #XPathASTExpressionParserHandler,
	#superclass : #XPathExpressionParserHandler,
	#instVars : [
		'expressionNodeStack',
		'operatorNodeStack'
	],
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #'handling - operators' }
XPathASTExpressionParserHandler >> handleAdditionOperator [
	self
		popAnyAdditiveExpressionNodes;
		pushBinaryOperatorNode: XPathASTAdditionExpressionNode new
]

{ #category : #'handling - axis' }
XPathASTExpressionParserHandler >> handleAncestorAxis [
	self pushOperatorNode: XPathASTAncestorStepNode new
]

{ #category : #'handling - axis' }
XPathASTExpressionParserHandler >> handleAncestorOrSelfAxis [
	self pushOperatorNode: XPathASTAncestorOrSelfStepNode new
]

{ #category : #'handling - operators' }
XPathASTExpressionParserHandler >> handleAndOperator [
	self
		popAnyAndExpressionNodes;
		pushBinaryOperatorNode: XPathASTAndExpressionNode new
]

{ #category : #'handling - node tests' }
XPathASTExpressionParserHandler >> handleAnyNodeTest [
	self topOperatorNode nodeTest: XPathASTAnyNodeTestNode new
]

{ #category : #'handling - axis' }
XPathASTExpressionParserHandler >> handleAttributeAxis [
	self pushOperatorNode: XPathASTAttributeStepNode new
]

{ #category : #'handling - node tests' }
XPathASTExpressionParserHandler >> handleAttributeTest [
	self topOperatorNode nodeTest: XPathASTAttributeTestNode new
]

{ #category : #'handling - node tests' }
XPathASTExpressionParserHandler >> handleAttributeTestForLocalName: aLocalName [
	self topOperatorNode nodeTest:
		(XPathASTAttributeTestForLocalNameNode localName: aLocalName)
]

{ #category : #'handling - node tests' }
XPathASTExpressionParserHandler >> handleAttributeTestForName: aName [
	self topOperatorNode nodeTest:
		(XPathASTAttributeTestForNameNode name: aName)
]

{ #category : #'handling - node tests' }
XPathASTExpressionParserHandler >> handleAttributeTestForNamespaceURI: aURI [
	self topOperatorNode nodeTest:
		(XPathASTAttributeTestForNamespaceURINode namespaceURI: aURI)
]

{ #category : #'handling - node tests' }
XPathASTExpressionParserHandler >> handleAttributeTestForNamespaceURI: aURI localName: aLocalName [
	self topOperatorNode nodeTest:
		(XPathASTAttributeTestForNamespaceURIAndLocalNameNode
			namespaceURI: aURI
			localName: aLocalName)
]

{ #category : #'handling - node tests' }
XPathASTExpressionParserHandler >> handleAttributeTestForPrefix: aPrefix [
	self topOperatorNode nodeTest:
		(XPathASTAttributeTestForPrefixNode prefix: aPrefix)
]

{ #category : #'handling - node tests' }
XPathASTExpressionParserHandler >> handleAttributeTestForPrefix: aPrefix localName: aLocalName [
	self topOperatorNode nodeTest:
		(XPathASTAttributeTestForPrefixAndLocalNameNode
			prefix: aPrefix
			localName: aLocalName)
]

{ #category : #'handling - axis' }
XPathASTExpressionParserHandler >> handleChildAxis [
	self pushOperatorNode: XPathASTChildStepNode new
]

{ #category : #'handling - node tests' }
XPathASTExpressionParserHandler >> handleCommentTest [
	self topOperatorNode nodeTest: XPathASTCommentTestNode new
]

{ #category : #'handling - axis' }
XPathASTExpressionParserHandler >> handleDescendantAxis [
	self pushOperatorNode: XPathASTDescendantStepNode new
]

{ #category : #'handling - axis' }
XPathASTExpressionParserHandler >> handleDescendantOrSelfAxis [
	self pushOperatorNode: XPathASTDescendantOrSelfStepNode new
]

{ #category : #'handling - operators' }
XPathASTExpressionParserHandler >> handleDivisionOperator [
	self
		popAnyMultiplicativeExpressionNodes;
		pushBinaryOperatorNode: XPathASTDivisionExpressionNode new
]

{ #category : #'handling - node tests' }
XPathASTExpressionParserHandler >> handleElementTest [
	self topOperatorNode nodeTest: XPathASTElementTestNode new
]

{ #category : #'handling - node tests' }
XPathASTExpressionParserHandler >> handleElementTestForLocalName: aLocalName [
	self topOperatorNode nodeTest:
		(XPathASTElementTestForLocalNameNode localName: aLocalName)
]

{ #category : #'handling - node tests' }
XPathASTExpressionParserHandler >> handleElementTestForName: aName [
	self topOperatorNode nodeTest:
		(XPathASTElementTestForNameNode name: aName)
]

{ #category : #'handling - node tests' }
XPathASTExpressionParserHandler >> handleElementTestForNamespaceURI: aURI [
	self topOperatorNode nodeTest:
		(XPathASTElementTestForNamespaceURINode namespaceURI: aURI)
]

{ #category : #'handling - node tests' }
XPathASTExpressionParserHandler >> handleElementTestForNamespaceURI: aURI localName: aLocalName [
	self topOperatorNode nodeTest:
		(XPathASTElementTestForNamespaceURIAndLocalNameNode
			namespaceURI: aURI
			localName: aLocalName)
]

{ #category : #'handling - node tests' }
XPathASTExpressionParserHandler >> handleElementTestForPrefix: aPrefix [
	self topOperatorNode nodeTest:
		(XPathASTElementTestForPrefixNode prefix: aPrefix)
]

{ #category : #'handling - node tests' }
XPathASTExpressionParserHandler >> handleElementTestForPrefix: aPrefix localName: aLocalName [
	self topOperatorNode nodeTest:
		(XPathASTElementTestForPrefixAndLocalNameNode
			prefix: aPrefix
			localName: aLocalName)
]

{ #category : #'handling - operators' }
XPathASTExpressionParserHandler >> handleEndAdditiveExpression [
	self popAnyAdditiveExpressionNodes
]

{ #category : #'handling - operators' }
XPathASTExpressionParserHandler >> handleEndAndExpression [
	self popAnyAndExpressionNodes
]

{ #category : #'handling - operators' }
XPathASTExpressionParserHandler >> handleEndEqualityExpression [
	self popAnyEqualityExpressionNodes
]

{ #category : #'handling - location paths' }
XPathASTExpressionParserHandler >> handleEndFilterExpression [
	self topOperatorNode isFilterExpression
		ifTrue: [self pushExpressionNode: self popOperatorNode]
]

{ #category : #'handling - functions' }
XPathASTExpressionParserHandler >> handleEndFunctionArgument [
	self topOperatorNode addArgument:
		(XPathASTArgumentNode expression: self popExpressionNode)
]

{ #category : #'handling - functions' }
XPathASTExpressionParserHandler >> handleEndFunctionCall [
	self pushExpressionNode: self popOperatorNode
]

{ #category : #'handling - location paths' }
XPathASTExpressionParserHandler >> handleEndLocationPath [
	self pushExpressionNode: self popOperatorNode
]

{ #category : #'handling - operators' }
XPathASTExpressionParserHandler >> handleEndMultiplicativeExpression [
	self popAnyMultiplicativeExpressionNodes
]

{ #category : #'handling - operators' }
XPathASTExpressionParserHandler >> handleEndOrExpression [
	self
		popAnyOrExpressionNodes;
		popOperatorNode "pop the or expression grouping null node"
]

{ #category : #handling }
XPathASTExpressionParserHandler >> handleEndParsing [
	self parsingResult:
		(XPathASTExpressionRootNode expression: self popExpressionNode)
]

{ #category : #'handling - predicates' }
XPathASTExpressionParserHandler >> handleEndPredicate [
	self topOperatorNode addPredicate:
		(XPathASTPredicateNode expression: self popExpressionNode)
]

{ #category : #'handling - operators' }
XPathASTExpressionParserHandler >> handleEndRelationalExpression [
	self popAnyRelationalExpressionNodes
]

{ #category : #'handling - location paths' }
XPathASTExpressionParserHandler >> handleEndStep [
	| step |

	step := self popOperatorNode.
	self topOperatorNode addStep: step.
]

{ #category : #'handling - operators' }
XPathASTExpressionParserHandler >> handleEndUnaryExpression [
	self popAnyUnaryExpressionNodes
]

{ #category : #'handling - operators' }
XPathASTExpressionParserHandler >> handleEndUnionExpression [
	self popAnyUnionExpressionNodes
]

{ #category : #'handling - operators' }
XPathASTExpressionParserHandler >> handleEqualsOperator [
	self
		popAnyEqualityExpressionNodes;
		pushBinaryOperatorNode: XPathASTEqualsExpressionNode new
]

{ #category : #'handling - axis' }
XPathASTExpressionParserHandler >> handleFollowingAxis [
	self pushOperatorNode: XPathASTFollowingStepNode new
]

{ #category : #'handling - axis' }
XPathASTExpressionParserHandler >> handleFollowingSiblingAxis [
	self pushOperatorNode: XPathASTFollowingSiblingStepNode new
]

{ #category : #'handling - operators' }
XPathASTExpressionParserHandler >> handleGreaterThanOperator [
	self
		popAnyRelationalExpressionNodes;
		pushBinaryOperatorNode: XPathASTGreaterThanExpressionNode new
]

{ #category : #'handling - operators' }
XPathASTExpressionParserHandler >> handleGreaterThanOrEqualToOperator [
	self
		popAnyRelationalExpressionNodes;
		pushBinaryOperatorNode: XPathASTGreaterThanOrEqualToExpressionNode new
]

{ #category : #'handling - operators' }
XPathASTExpressionParserHandler >> handleLessThanOperator [
	self
		popAnyRelationalExpressionNodes;
		pushBinaryOperatorNode: XPathASTLessThanExpressionNode new
]

{ #category : #'handling - operators' }
XPathASTExpressionParserHandler >> handleLessThanOrEqualToOperator [
	self
		popAnyRelationalExpressionNodes;
		pushBinaryOperatorNode: XPathASTLessThanOrEqualToExpressionNode new
]

{ #category : #'handling - operators' }
XPathASTExpressionParserHandler >> handleModulusOperator [
	self
		popAnyMultiplicativeExpressionNodes;
		pushBinaryOperatorNode: XPathASTModulusExpressionNode new
]

{ #category : #'handling - operators' }
XPathASTExpressionParserHandler >> handleMultiplicationOperator [
	self
		popAnyMultiplicativeExpressionNodes;
		pushBinaryOperatorNode: XPathASTMultiplicationExpressionNode new
]

{ #category : #'handling - axis' }
XPathASTExpressionParserHandler >> handleNamespaceAxis [
	self pushOperatorNode: XPathASTNamespaceStepNode new
]

{ #category : #'handling - node tests' }
XPathASTExpressionParserHandler >> handleNamespaceTest [
	self topOperatorNode nodeTest: XPathASTNamespaceTestNode new
]

{ #category : #'handling - node tests' }
XPathASTExpressionParserHandler >> handleNamespaceTestForLocalName: aLocalName [
	self topOperatorNode nodeTest:
		(XPathASTNamespaceTestForLocalNameNode localName: aLocalName)
]

{ #category : #'handling - node tests' }
XPathASTExpressionParserHandler >> handleNamespaceTestForName: aName [
	self topOperatorNode nodeTest:
		(XPathASTNamespaceTestForNameNode name: aName)
]

{ #category : #'handling - node tests' }
XPathASTExpressionParserHandler >> handleNamespaceTestForNamespaceURI: aURI [
	self topOperatorNode nodeTest:
		(XPathASTNamespaceTestForNamespaceURINode namespaceURI: aURI)
]

{ #category : #'handling - node tests' }
XPathASTExpressionParserHandler >> handleNamespaceTestForNamespaceURI: aURI localName: aLocalName [
	self topOperatorNode nodeTest:
		(XPathASTNamespaceTestForNamespaceURIAndLocalNameNode
			namespaceURI: aURI
			localName: aLocalName)
]

{ #category : #'handling - node tests' }
XPathASTExpressionParserHandler >> handleNamespaceTestForPrefix: aPrefix [
	self topOperatorNode nodeTest:
		(XPathASTNamespaceTestForPrefixNode prefix: aPrefix)
]

{ #category : #'handling - node tests' }
XPathASTExpressionParserHandler >> handleNamespaceTestForPrefix: aPrefix localName: aLocalName [
	self topOperatorNode nodeTest:
		(XPathASTNamespaceTestForPrefixAndLocalNameNode
			prefix: aPrefix
			localName: aLocalName)
]

{ #category : #'handling - operators' }
XPathASTExpressionParserHandler >> handleNegationOperator [
	self pushUnaryOperatorNode: XPathASTNegationExpressionNode new
]

{ #category : #'handling - operators' }
XPathASTExpressionParserHandler >> handleNotEqualsOperator [
	self
		popAnyEqualityExpressionNodes;
		pushBinaryOperatorNode: XPathASTNotEqualsExpressionNode new
]

{ #category : #'handling - literals' }
XPathASTExpressionParserHandler >> handleNumberLiteral: anIntegerOrFloatString [
	self pushExpressionNode:
		(XPathASTNumberLiteralNode number: anIntegerOrFloatString asXPathNumber)
]

{ #category : #'handling - operators' }
XPathASTExpressionParserHandler >> handleOrOperator [
	self
		popAnyOrExpressionNodes;
		pushBinaryOperatorNode: XPathASTOrExpressionNode new
]

{ #category : #'handling - node tests' }
XPathASTExpressionParserHandler >> handlePITest [
	self topOperatorNode nodeTest: XPathASTPITestNode new
]

{ #category : #'handling - node tests' }
XPathASTExpressionParserHandler >> handlePITestForName: aName [
	self topOperatorNode nodeTest:
		(XPathASTPITestForNameNode name: aName)
]

{ #category : #'handling - axis' }
XPathASTExpressionParserHandler >> handleParentAxis [
	self pushOperatorNode: XPathASTParentStepNode new
]

{ #category : #'handling - axis' }
XPathASTExpressionParserHandler >> handlePrecedingAxis [
	self pushOperatorNode: XPathASTPrecedingStepNode new
]

{ #category : #'handling - axis' }
XPathASTExpressionParserHandler >> handlePrecedingSiblingAxis [
	self pushOperatorNode: XPathASTPrecedingSiblingStepNode new
]

{ #category : #'handling - axis' }
XPathASTExpressionParserHandler >> handleSelfAxis [
	self pushOperatorNode: XPathASTSelfStepNode new
]

{ #category : #'handling - location paths' }
XPathASTExpressionParserHandler >> handleStartAbsoluteLocationPath [
	self pushOperatorNode: XPathASTAbsoluteLocationPathNode new
]

{ #category : #'handling - location paths' }
XPathASTExpressionParserHandler >> handleStartFilterExpressionLocationPath [
	self pushOperatorNode:
		(XPathASTFilterExpressionLocationPathNode expression:
			self popExpressionNode)
]

{ #category : #'handling - functions' }
XPathASTExpressionParserHandler >> handleStartFunctionCall: aFunctionName [
	self pushOperatorNode:
		(XPathASTFunctionCallNode name: aFunctionName)
]

{ #category : #'handling - operators' }
XPathASTExpressionParserHandler >> handleStartOrExpression [
	self pushOperatorNode: XPathASTNullNode new
]

{ #category : #handling }
XPathASTExpressionParserHandler >> handleStartParsing [
	expressionNodeStack := OrderedCollection new.
	operatorNodeStack := OrderedCollection new.
]

{ #category : #'handling - predicates' }
XPathASTExpressionParserHandler >> handleStartPredicates [
	self topOperatorNode isStep
		ifFalse: [
			self pushOperatorNode:
				(XPathASTFilterExpressionNode expression:
					self popExpressionNode)]
]

{ #category : #'handling - location paths' }
XPathASTExpressionParserHandler >> handleStartRelativeLocationPath [
	self pushOperatorNode: XPathASTRelativeLocationPathNode new
]

{ #category : #'handling - literals' }
XPathASTExpressionParserHandler >> handleStringLiteral: aString [
	self pushExpressionNode:
		(XPathASTStringLiteralNode string: aString)
]

{ #category : #'handling - operators' }
XPathASTExpressionParserHandler >> handleSubtractionOperator [
	self
		popAnyAdditiveExpressionNodes;
		pushBinaryOperatorNode: XPathASTSubtractionExpressionNode new
]

{ #category : #'handling - node tests' }
XPathASTExpressionParserHandler >> handleTextTest [
	self topOperatorNode nodeTest: XPathASTTextTestNode new
]

{ #category : #'handling - operators' }
XPathASTExpressionParserHandler >> handleUnionOperator [
	self
		popAnyUnionExpressionNodes;
		pushBinaryOperatorNode: XPathASTUnionExpressionNode new
]

{ #category : #'handling - variables' }
XPathASTExpressionParserHandler >> handleVariableReference: aName [
	self pushExpressionNode:
		(XPathASTVariableReferenceNode name: aName)
]

{ #category : #private }
XPathASTExpressionParserHandler >> popAnyAdditiveExpressionNodes [
	[self topOperatorNode isAdditiveExpression]
		whileTrue: [self popBinaryOperatorNode]
]

{ #category : #private }
XPathASTExpressionParserHandler >> popAnyAndExpressionNodes [
	[self topOperatorNode isAndExpression]
		whileTrue: [self popBinaryOperatorNode]
]

{ #category : #private }
XPathASTExpressionParserHandler >> popAnyEqualityExpressionNodes [
	[self topOperatorNode isEqualityExpression]
		whileTrue: [self popBinaryOperatorNode]
]

{ #category : #private }
XPathASTExpressionParserHandler >> popAnyMultiplicativeExpressionNodes [
	[self topOperatorNode isMultiplicativeExpression]
		whileTrue: [self popBinaryOperatorNode]
]

{ #category : #private }
XPathASTExpressionParserHandler >> popAnyOrExpressionNodes [
	[self topOperatorNode isOrExpression]
		whileTrue: [self popBinaryOperatorNode]
]

{ #category : #private }
XPathASTExpressionParserHandler >> popAnyRelationalExpressionNodes [
	[self topOperatorNode isRelationalExpression]
		whileTrue: [self popBinaryOperatorNode]
]

{ #category : #private }
XPathASTExpressionParserHandler >> popAnyUnaryExpressionNodes [
	[self topOperatorNode isUnaryOperatorExpression]
		whileTrue: [self popUnaryOperatorNode]
]

{ #category : #private }
XPathASTExpressionParserHandler >> popAnyUnionExpressionNodes [
	[self topOperatorNode isUnionExpression]
		whileTrue: [self popBinaryOperatorNode]
]

{ #category : #private }
XPathASTExpressionParserHandler >> popBinaryOperatorNode [
	^ self pushExpressionNode:
		(self popOperatorNode otherExpression: self popExpressionNode)
]

{ #category : #private }
XPathASTExpressionParserHandler >> popExpressionNode [
	^ expressionNodeStack removeLast
]

{ #category : #private }
XPathASTExpressionParserHandler >> popOperatorNode [
	^ operatorNodeStack removeLast
]

{ #category : #private }
XPathASTExpressionParserHandler >> popUnaryOperatorNode [
	^ self pushExpressionNode:
		(self popOperatorNode expression: self popExpressionNode)
]

{ #category : #private }
XPathASTExpressionParserHandler >> pushBinaryOperatorNode: aBinaryOperatorNode [
	^ self pushOperatorNode:
		(aBinaryOperatorNode expression: self popExpressionNode)
]

{ #category : #private }
XPathASTExpressionParserHandler >> pushExpressionNode: anExpressionNode [
	^ expressionNodeStack addLast: anExpressionNode
]

{ #category : #private }
XPathASTExpressionParserHandler >> pushOperatorNode: anOperatorNode [
	^ operatorNodeStack addLast: anOperatorNode
]

{ #category : #private }
XPathASTExpressionParserHandler >> pushUnaryOperatorNode: aUnaryOperatorNode [
	^ self pushOperatorNode: aUnaryOperatorNode
]

{ #category : #private }
XPathASTExpressionParserHandler >> topOperatorNode [
	^ operatorNodeStack last
]
