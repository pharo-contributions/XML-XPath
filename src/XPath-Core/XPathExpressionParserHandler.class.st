"
An abstract class for XPath expression parser handlers.
"
Class {
	#name : #XPathExpressionParserHandler,
	#superclass : #XPathParserHandler,
	#category : #'XPath-Core-Parsers'
}

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleAddition [
]

{ #category : #'handling - location paths' }
XPathExpressionParserHandler >> handleAxis: anAxis [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleDivision [
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

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleEndRelationalExpression [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleEndShortCircuited: anInteger [
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
XPathExpressionParserHandler >> handleEquals [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleGreaterThan [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleGreaterThanOrEqualTo [
]

{ #category : #'handling - predicates' }
XPathExpressionParserHandler >> handleIntegerPredicate: anIntegerString [
]

{ #category : #'handling - functions' }
XPathExpressionParserHandler >> handleLastFunctionCall [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleLessThan [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleLessThanOrEqualTo [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleModulus [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleMultiplication [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleNegation [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleNotEquals [
]

{ #category : #handling }
XPathExpressionParserHandler >> handleNumberLiteral: anIntegerOrFloatString [
]

{ #category : #'handling - functions' }
XPathExpressionParserHandler >> handlePositionFunctionCall [
]

{ #category : #'handling - predicates' }
XPathExpressionParserHandler >> handlePredicateAttribute: aName equalsStringLiteral: aStringLiteral [
]

{ #category : #'handling - predicates' }
XPathExpressionParserHandler >> handlePredicateAttribute: aName notEqualsStringLiteral: aStringLiteral [
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

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleStartRelationalExpression [
]

{ #category : #'handling - location paths' }
XPathExpressionParserHandler >> handleStartRelativeLocationPath [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleStartShortCircuitAnd [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleStartShortCircuitOr [
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

{ #category : #handling }
XPathExpressionParserHandler >> handleStringLiteral: aString [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleSubtraction [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForAnyNodeType [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForAttributeWithAnyName [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForAttributeWithLocalName: aLocalName [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForAttributeWithName: aName [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForAttributeWithNamespaceURI: aURI [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForAttributeWithNamespaceURI: aURI localName: aLocalName [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForAttributeWithPrefix: aPrefix [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForAttributeWithPrefix: aPrefix localName: aLocalName [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForCommentType [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForElementWithAnyName [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForElementWithLocalName: aLocalName [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForElementWithName: aName [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForElementWithNamespaceURI: aURI [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForElementWithNamespaceURI: aURI localName: aLocalName [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForElementWithPrefix: aPrefix [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForElementWithPrefix: aPrefix localName: aLocalName [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForNamespaceWithAnyName [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForNamespaceWithLocalName: aLocalName [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForNamespaceWithName: aName [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForNamespaceWithNamespaceURI: aURI [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForNamespaceWithNamespaceURI: aURI localName: aLocalName [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForNamespaceWithPrefix: aPrefix [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForNamespaceWithPrefix: aPrefix localName: aLocalName [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForPIWithAnyName [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForPIWithName: aName [
]

{ #category : #'handling - node tests' }
XPathExpressionParserHandler >> handleTestForTextType [
]

{ #category : #'handling - operators' }
XPathExpressionParserHandler >> handleUnion [
]

{ #category : #handling }
XPathExpressionParserHandler >> handleVariableReference: aName [
]
