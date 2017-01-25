"
An abstract class for XPath expression parser handlers.
"
Class {
	#name : #XPathExpressionParserHandler,
	#superclass : #XPathParserHandler,
	#category : #'XPath-Core-Parsers'
}

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleAdditionOperator [
]

{ #category : #'handling - axis' }
XPathExpressionParserHandler >> handleAncestorAxis [
]

{ #category : #'handling - axis' }
XPathExpressionParserHandler >> handleAncestorOrSelfAxis [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleAndOperator [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleAnyNodeTest [
]

{ #category : #'handling - axis' }
XPathExpressionParserHandler >> handleAttributeAxis [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleAttributeTest [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleAttributeTestForLocalName: aLocalName [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleAttributeTestForName: aName [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleAttributeTestForNamespaceURI: aURI [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleAttributeTestForNamespaceURI: aURI localName: aLocalName [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleAttributeTestForPrefix: aPrefix [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleAttributeTestForPrefix: aPrefix localName: aLocalName [
]

{ #category : #'handling - axis' }
XPathExpressionParserHandler >> handleChildAxis [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleCommentTest [
]

{ #category : #'handling - axis' }
XPathExpressionParserHandler >> handleDescendantAxis [
]

{ #category : #'handling - axis' }
XPathExpressionParserHandler >> handleDescendantOrSelfAxis [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleDivisionOperator [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleElementTest [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleElementTestForLocalName: aLocalName [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleElementTestForName: aName [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleElementTestForNamespaceURI: aURI [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleElementTestForNamespaceURI: aURI localName: aLocalName [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleElementTestForPrefix: aPrefix [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleElementTestForPrefix: aPrefix localName: aLocalName [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleEndAdditiveExpression [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleEndAndExpression [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleEndEqualityExpression [
]

{ #category : #'handling - location paths' }
XPathExpressionParserHandler >> handleEndFilterExpression [
]

{ #category : #'handling - functions' }
XPathExpressionParserHandler >> handleEndFunctionArgument [
]

{ #category : #'handling - functions' }
XPathExpressionParserHandler >> handleEndFunctionCall [
]

{ #category : #'handling - location paths' }
XPathExpressionParserHandler >> handleEndLocationPath [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleEndMultiplicativeExpression [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleEndOrExpression [
]

{ #category : #'handling - location paths' }
XPathExpressionParserHandler >> handleEndPathExpression [
]

{ #category : #'handling - predicates' }
XPathExpressionParserHandler >> handleEndPredicate [
]

{ #category : #'handling - location paths' }
XPathExpressionParserHandler >> handleEndPredicates [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleEndRelationalExpression [
]

{ #category : #'handling - location paths' }
XPathExpressionParserHandler >> handleEndStep [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleEndUnaryExpression [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleEndUnionExpression [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleEqualsOperator [
]

{ #category : #'handling - axis' }
XPathExpressionParserHandler >> handleFollowingAxis [
]

{ #category : #'handling - axis' }
XPathExpressionParserHandler >> handleFollowingSiblingAxis [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleGreaterThanOperator [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleGreaterThanOrEqualToOperator [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleLessThanOperator [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleLessThanOrEqualToOperator [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleModulusOperator [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleMultiplicationOperator [
]

{ #category : #'handling - axis' }
XPathExpressionParserHandler >> handleNamespaceAxis [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleNamespaceTest [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleNamespaceTestForLocalName: aLocalName [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleNamespaceTestForName: aName [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleNamespaceTestForNamespaceURI: aURI [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleNamespaceTestForNamespaceURI: aURI localName: aLocalName [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleNamespaceTestForPrefix: aPrefix [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleNamespaceTestForPrefix: aPrefix localName: aLocalName [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleNegationOperator [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleNotEqualsOperator [
]

{ #category : #'handling - literals' }
XPathExpressionParserHandler >> handleNumberLiteral: anIntegerOrFloatString [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleOrOperator [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handlePITest [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handlePITestForName: aName [
]

{ #category : #'handling - axis' }
XPathExpressionParserHandler >> handleParentAxis [
]

{ #category : #'handling - axis' }
XPathExpressionParserHandler >> handlePrecedingAxis [
]

{ #category : #'handling - axis' }
XPathExpressionParserHandler >> handlePrecedingSiblingAxis [
]

{ #category : #'handling - axis' }
XPathExpressionParserHandler >> handleSelfAxis [
]

{ #category : #'handling - location paths' }
XPathExpressionParserHandler >> handleStartAbsoluteLocationPath [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleStartAdditiveExpression [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleStartAndExpression [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleStartEqualityExpression [
]

{ #category : #'handling - location paths' }
XPathExpressionParserHandler >> handleStartFilterExpression [
]

{ #category : #'handling - location paths' }
XPathExpressionParserHandler >> handleStartFilterExpressionLocationPath [
]

{ #category : #'handling - functions' }
XPathExpressionParserHandler >> handleStartFunctionArgument [
]

{ #category : #'handling - functions' }
XPathExpressionParserHandler >> handleStartFunctionCall: aFunctionName [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleStartMultiplicativeExpression [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleStartOrExpression [
]

{ #category : #'handling - location paths' }
XPathExpressionParserHandler >> handleStartPathExpression [
]

{ #category : #'handling - predicates' }
XPathExpressionParserHandler >> handleStartPredicate [
]

{ #category : #'handling - predicates' }
XPathExpressionParserHandler >> handleStartPredicates [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleStartRelationalExpression [
]

{ #category : #'handling - location paths' }
XPathExpressionParserHandler >> handleStartRelativeLocationPath [
]

{ #category : #'handling - location paths' }
XPathExpressionParserHandler >> handleStartStep [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleStartUnaryExpression [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleStartUnionExpression [
]

{ #category : #'handling - literals' }
XPathExpressionParserHandler >> handleStringLiteral: aString [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleSubtractionOperator [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTextTest [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleUnionOperator [
]

{ #category : #'handling - variables' }
XPathExpressionParserHandler >> handleVariableReference: aName [
]
