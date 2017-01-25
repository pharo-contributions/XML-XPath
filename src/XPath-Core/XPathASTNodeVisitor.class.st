"
This is a base class for AST visitors.
"
Class {
	#name : #XPathASTNodeVisitor,
	#superclass : #Object,
	#instVars : [
		'stepStream',
		'previousStep',
		'predicateStream',
		'previousPredicate',
		'argumentStream',
		'previousArgument'
	],
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #iterating }
XPathASTNodeVisitor >> nextArgument [
	(argumentStream isNil
		or: [argumentStream atEnd])
		ifTrue: [^ XPathASTNullNode new]
		ifFalse: [^ argumentStream next]
]

{ #category : #iterating }
XPathASTNodeVisitor >> nextPredicate [
	(predicateStream isNil
		or: [predicateStream atEnd])
		ifTrue: [^ XPathASTNullNode new]
		ifFalse: [^ predicateStream next]
]

{ #category : #iterating }
XPathASTNodeVisitor >> nextStep [
	(stepStream isNil
		or: [stepStream atEnd])
		ifTrue: [^ XPathASTNullNode new]
		ifFalse: [^ stepStream next]
]

{ #category : #iterating }
XPathASTNodeVisitor >> peekArgument [
	(argumentStream isNil
		or: [argumentStream atEnd])
		ifTrue: [^ XPathASTNullNode new]
		ifFalse: [^ argumentStream peek]
]

{ #category : #iterating }
XPathASTNodeVisitor >> peekPredicate [
	(predicateStream isNil
		or: [predicateStream atEnd])
		ifTrue: [^ XPathASTNullNode new]
		ifFalse: [^ predicateStream peek]
]

{ #category : #iterating }
XPathASTNodeVisitor >> peekStep [
	(stepStream isNil
		or: [stepStream atEnd])
		ifTrue: [^ XPathASTNullNode new]
		ifFalse: [^ stepStream peek]
]

{ #category : #iterating }
XPathASTNodeVisitor >> previousArgument [
	^ previousArgument ifNil: [previousArgument := XPathASTNullNode new]
]

{ #category : #iterating }
XPathASTNodeVisitor >> previousPredicate [
	^ previousPredicate ifNil: [previousPredicate := XPathASTNullNode new]
]

{ #category : #iterating }
XPathASTNodeVisitor >> previousStep [
	^ previousStep ifNil: [previousStep := XPathASTNullNode new]
]

{ #category : #'visiting - location paths' }
XPathASTNodeVisitor >> visitAbsoluteLocationPath: anAbsoluteLocationPath [
	^ self visitLocationPath: anAbsoluteLocationPath
]

{ #category : #'visiting - operators' }
XPathASTNodeVisitor >> visitAdditionExpression: anAdditionExpression [
	^ self visitBinaryOperatorExpression: anAdditionExpression
]

{ #category : #'visiting - steps' }
XPathASTNodeVisitor >> visitAncestorOrSelfStep: anAncestorOrSelfStep [
	^ self visitStep: anAncestorOrSelfStep
]

{ #category : #'visiting - steps' }
XPathASTNodeVisitor >> visitAncestorStep: anAncestorStep [
	^ self visitStep: anAncestorStep
]

{ #category : #'visiting - operators' }
XPathASTNodeVisitor >> visitAndExpression: anAndExpression [
	^ self visitBinaryOperatorExpression: anAndExpression
]

{ #category : #'visiting - node tests' }
XPathASTNodeVisitor >> visitAnyNodeTest: anAnyNodeTest [
	^ self visitNodeTest: anAnyNodeTest
]

{ #category : #'visiting - functions' }
XPathASTNodeVisitor >> visitArgument: aNode [
	^ self visitNodeWithExpression: aNode
]

{ #category : #'visiting - steps' }
XPathASTNodeVisitor >> visitAttributeStep: anAttributeStep [
	^ self visitStep: anAttributeStep
]

{ #category : #'visiting - node tests' }
XPathASTNodeVisitor >> visitAttributeTest: anAttributeTest [
	^ self visitNodeTest: anAttributeTest
]

{ #category : #'visiting - node tests' }
XPathASTNodeVisitor >> visitAttributeTestForLocalName: anAttributeTestForLocalName [
	^ self visitNodeTest: anAttributeTestForLocalName
]

{ #category : #'visiting - node tests' }
XPathASTNodeVisitor >> visitAttributeTestForName: anAttributeTestForName [
	^ self visitNodeTest: anAttributeTestForName
]

{ #category : #'visiting - node tests' }
XPathASTNodeVisitor >> visitAttributeTestForNamespaceURI: anAttributeTestForNamespaceURI [
	^ self visitNodeTest: anAttributeTestForNamespaceURI
]

{ #category : #'visiting - node tests' }
XPathASTNodeVisitor >> visitAttributeTestForNamespaceURIAndLocalName: anAttributeTestForNamespaceURIAndLocalName [
	^ self visitNodeTest: anAttributeTestForNamespaceURIAndLocalName
]

{ #category : #'visiting - node tests' }
XPathASTNodeVisitor >> visitAttributeTestForPrefix: anAttributeTestForPrefix [
	^ self visitNodeTest: anAttributeTestForPrefix
]

{ #category : #'visiting - node tests' }
XPathASTNodeVisitor >> visitAttributeTestForPrefixAndLocalName: anAttributeTestForPrefixAndLocalName [
	^ self visitNodeTest: anAttributeTestForPrefixAndLocalName
]

{ #category : #'visiting - operators' }
XPathASTNodeVisitor >> visitBinaryOperatorExpression: aBinaryOperatorExpression [
	^ self visitNodeWithOtherExpression: aBinaryOperatorExpression
]

{ #category : #'visiting - steps' }
XPathASTNodeVisitor >> visitChildStep: aChildStep [
	^ self visitStep: aChildStep
]

{ #category : #'visiting - node tests' }
XPathASTNodeVisitor >> visitCommentTest: aCommentTest [
	^ self visitNodeTest: aCommentTest
]

{ #category : #'visiting - steps' }
XPathASTNodeVisitor >> visitDescendantOrSelfStep: aDescendantOrSelfStep [
	^ self visitStep: aDescendantOrSelfStep
]

{ #category : #'visiting - steps' }
XPathASTNodeVisitor >> visitDescendantStep: aDescendantStep [
	^ self visitStep: aDescendantStep
]

{ #category : #'visiting - operators' }
XPathASTNodeVisitor >> visitDivisionExpression: aDivisionExpression [
	^ self visitBinaryOperatorExpression: aDivisionExpression
]

{ #category : #'visiting - node tests' }
XPathASTNodeVisitor >> visitElementTest: anElementTest [
	^ self visitNodeTest: anElementTest
]

{ #category : #'visiting - node tests' }
XPathASTNodeVisitor >> visitElementTestForLocalName: anElementTestForLocalName [
	^ self visitNodeTest: anElementTestForLocalName
]

{ #category : #'visiting - node tests' }
XPathASTNodeVisitor >> visitElementTestForName: anElementTestForName [
	^ self visitNodeTest: anElementTestForName
]

{ #category : #'visiting - node tests' }
XPathASTNodeVisitor >> visitElementTestForNamespaceURI: anElementTestForNamespaceURI [
	^ self visitNodeTest: anElementTestForNamespaceURI
]

{ #category : #'visiting - node tests' }
XPathASTNodeVisitor >> visitElementTestForNamespaceURIAndLocalName: anElementTestForNamespaceURIAndLocalName [
	^ self visitNodeTest: anElementTestForNamespaceURIAndLocalName
]

{ #category : #'visiting - node tests' }
XPathASTNodeVisitor >> visitElementTestForPrefix: anElementTestForPrefix [
	^ self visitNodeTest: anElementTestForPrefix
]

{ #category : #'visiting - node tests' }
XPathASTNodeVisitor >> visitElementTestForPrefixAndLocalName: anElementTestForPrefixAndLocalName [
	^ self visitNodeTest: anElementTestForPrefixAndLocalName
]

{ #category : #'visiting - operators' }
XPathASTNodeVisitor >> visitEqualsExpression: anEqualsExpression [
	^ self visitBinaryOperatorExpression: anEqualsExpression
]

{ #category : #visiting }
XPathASTNodeVisitor >> visitExpressionRoot: anExpressionRoot [
	^ self visitNodeWithExpression: anExpressionRoot
]

{ #category : #'visiting - location paths' }
XPathASTNodeVisitor >> visitFilterExpression: aFilterExpression [
	^ self
		visitNodeWithExpression: aFilterExpression;
		visitFilterable: aFilterExpression
]

{ #category : #'visiting - location paths' }
XPathASTNodeVisitor >> visitFilterExpressionLocationPath: aFilterExpressionLocationPath [
	^ self
		visitNodeWithExpression: aFilterExpressionLocationPath;
		visitLocationPath: aFilterExpressionLocationPath
]

{ #category : #'visiting - location paths' }
XPathASTNodeVisitor >> visitFilterable: aFilterable [
	aFilterable hasPredicates
		ifTrue: [| oldPredicateStream oldPreviousPredicate |
			oldPredicateStream := predicateStream.
			oldPreviousPredicate := previousPredicate.
			predicateStream := aFilterable predicates readStream.
			previousPredicate := XPathASTNullNode new.
			[predicateStream atEnd]
				whileFalse: [
					previousPredicate := self nextPredicate acceptNodeVisitor: self].
			predicateStream := oldPredicateStream.
			previousPredicate := oldPreviousPredicate].
	^ aFilterable.
]

{ #category : #'visiting - steps' }
XPathASTNodeVisitor >> visitFollowingSiblingStep: aFollowingSiblingStep [
	^ self visitStep: aFollowingSiblingStep
]

{ #category : #'visiting - steps' }
XPathASTNodeVisitor >> visitFollowingStep: aFollowingStep [
	^ self visitStep: aFollowingStep
]

{ #category : #'visiting - functions' }
XPathASTNodeVisitor >> visitFunctionCall: aFunctionCall [
	aFunctionCall hasArguments
		ifTrue: [| oldArgumentStream oldPreviousArgument |
			oldArgumentStream := argumentStream.
			oldPreviousArgument := previousArgument.
			argumentStream := aFunctionCall arguments readStream.
			previousArgument := XPathASTNullNode new.
			[argumentStream atEnd]
				whileFalse: [
					previousArgument := self nextArgument acceptNodeVisitor: self].
			argumentStream := oldArgumentStream.
			previousArgument := oldPreviousArgument].
	^ aFunctionCall.
]

{ #category : #'visiting - operators' }
XPathASTNodeVisitor >> visitGreaterThanExpression: aGreaterThanExpression [
	^ self visitBinaryOperatorExpression: aGreaterThanExpression
]

{ #category : #'visiting - operators' }
XPathASTNodeVisitor >> visitGreaterThanOrEqualToExpression: aGreaterThanOrEqualToExpression [
	^ self visitBinaryOperatorExpression: aGreaterThanOrEqualToExpression
]

{ #category : #'visiting - operators' }
XPathASTNodeVisitor >> visitLessThanExpression: aLessThanExpression [
	^ self visitBinaryOperatorExpression: aLessThanExpression
]

{ #category : #'visiting - operators' }
XPathASTNodeVisitor >> visitLessThanOrEqualToExpression: aLessThanOrEqualToExpression [
	^ self visitBinaryOperatorExpression: aLessThanOrEqualToExpression
]

{ #category : #'visiting - location paths' }
XPathASTNodeVisitor >> visitLocationPath: aLocationPath [
	aLocationPath hasSteps
		ifTrue: [| oldStepStream oldPreviousStep |
			oldStepStream := stepStream.
			oldPreviousStep := previousStep.
			stepStream := aLocationPath steps readStream.
			previousStep := XPathASTNullNode new.
			[stepStream atEnd]
				whileFalse: [
					previousStep := self nextStep acceptNodeVisitor: self].
			stepStream := oldStepStream.
			previousStep := oldPreviousStep].
	^ aLocationPath.
]

{ #category : #'visiting - operators' }
XPathASTNodeVisitor >> visitModulusExpression: aModulusExpression [
	^ self visitBinaryOperatorExpression: aModulusExpression
]

{ #category : #'visiting - operators' }
XPathASTNodeVisitor >> visitMultiplicationExpression: aMultiplicationExpression [
	^ self visitBinaryOperatorExpression: aMultiplicationExpression
]

{ #category : #'visiting - steps' }
XPathASTNodeVisitor >> visitNamespaceStep: aNamespaceStep [
	^ self visitStep: aNamespaceStep
]

{ #category : #'visiting - node tests' }
XPathASTNodeVisitor >> visitNamespaceTest: aNamespaceTest [
	^ self visitNodeTest: aNamespaceTest
]

{ #category : #'visiting - node tests' }
XPathASTNodeVisitor >> visitNamespaceTestForLocalName: aNamespaceTestForLocalName [
	^ self visitNodeTest: aNamespaceTestForLocalName
]

{ #category : #'visiting - node tests' }
XPathASTNodeVisitor >> visitNamespaceTestForName: aNamespaceTestForName [
	^ self visitNodeTest: aNamespaceTestForName
]

{ #category : #'visiting - node tests' }
XPathASTNodeVisitor >> visitNamespaceTestForNamespaceURI: aNamespaceTestForNamespaceURI [
	^ self visitNodeTest: aNamespaceTestForNamespaceURI
]

{ #category : #'visiting - node tests' }
XPathASTNodeVisitor >> visitNamespaceTestForNamespaceURIAndLocalName: aNamespaceTestForNamespaceURIAndLocalName [
	^ self visitNodeTest: aNamespaceTestForNamespaceURIAndLocalName
]

{ #category : #'visiting - node tests' }
XPathASTNodeVisitor >> visitNamespaceTestForPrefix: aNamespaceTestForPrefix [
	^ self visitNodeTest: aNamespaceTestForPrefix
]

{ #category : #'visiting - node tests' }
XPathASTNodeVisitor >> visitNamespaceTestForPrefixAndLocalName: aNamespaceTestForPrefixAndLocalName [
	^ self visitNodeTest: aNamespaceTestForPrefixAndLocalName
]

{ #category : #'visiting - operators' }
XPathASTNodeVisitor >> visitNegationExpression: aNegationExpression [
	^ self visitUnaryOperatorExpression: aNegationExpression
]

{ #category : #visiting }
XPathASTNodeVisitor >> visitNode: aNode [
	^ aNode acceptNodeVisitor: self
]

{ #category : #'visiting - node tests' }
XPathASTNodeVisitor >> visitNodeTest: aNodeTest [
	^ aNodeTest
]

{ #category : #visiting }
XPathASTNodeVisitor >> visitNodeWithExpression: aNodeWithExpression [
	aNodeWithExpression expression acceptNodeVisitor: self.
	^ aNodeWithExpression.
]

{ #category : #visiting }
XPathASTNodeVisitor >> visitNodeWithOtherExpression: aNodeWithOtherExpression [
	self visitNodeWithExpression: aNodeWithOtherExpression.
	aNodeWithOtherExpression otherExpression acceptNodeVisitor: self.
	^ aNodeWithOtherExpression.
]

{ #category : #'visiting - operators' }
XPathASTNodeVisitor >> visitNotEqualsExpression: aNotEqualsExpression [
	^ self visitBinaryOperatorExpression: aNotEqualsExpression
]

{ #category : #'visiting - literals' }
XPathASTNodeVisitor >> visitNumberLiteral: aNumberLiteral [
	^ aNumberLiteral
]

{ #category : #'visiting - operators' }
XPathASTNodeVisitor >> visitOrExpression: anOrExpression [
	^ self visitBinaryOperatorExpression: anOrExpression
]

{ #category : #'visiting - node tests' }
XPathASTNodeVisitor >> visitPITest: aPITest [
	^ self visitNodeTest: aPITest
]

{ #category : #'visiting - node tests' }
XPathASTNodeVisitor >> visitPITestForName: aPITestForName [
	^ self visitNodeTest: aPITestForName
]

{ #category : #'visiting - steps' }
XPathASTNodeVisitor >> visitParentStep: aParentStep [
	^ self visitStep: aParentStep
]

{ #category : #'visiting - steps' }
XPathASTNodeVisitor >> visitPrecedingSiblingStep: aPrecedingSiblingStep [
	^ self visitStep: aPrecedingSiblingStep
]

{ #category : #'visiting - steps' }
XPathASTNodeVisitor >> visitPrecedingStep: aPrecedingStep [
	^ self visitStep: aPrecedingStep
]

{ #category : #'visiting - predicates' }
XPathASTNodeVisitor >> visitPredicate: aPredicate [
	^ self visitNodeWithExpression: aPredicate
]

{ #category : #'visiting - location paths' }
XPathASTNodeVisitor >> visitRelativeLocationPath: aRelativeLocationPath [
	^ self visitLocationPath: aRelativeLocationPath
]

{ #category : #'visiting - steps' }
XPathASTNodeVisitor >> visitSelfStep: aSelfStep [
	^ self visitStep: aSelfStep
]

{ #category : #'visiting - steps' }
XPathASTNodeVisitor >> visitStep: aStep [
	aStep nodeTest acceptNodeVisitor: self.
	^ self visitFilterable: aStep.
]

{ #category : #'visiting - literals' }
XPathASTNodeVisitor >> visitStringLiteral: aStringLiteral [
	^ aStringLiteral
]

{ #category : #'visiting - operators' }
XPathASTNodeVisitor >> visitSubtractionExpression: aSubtractionExpression [
	^ self visitBinaryOperatorExpression: aSubtractionExpression
]

{ #category : #'visiting - node tests' }
XPathASTNodeVisitor >> visitTextTest: aTextTest [
	^ self visitNodeTest: aTextTest
]

{ #category : #'visiting - operators' }
XPathASTNodeVisitor >> visitUnaryOperatorExpression: aUnaryOperatorExpression [
	^ self visitNodeWithExpression: aUnaryOperatorExpression
]

{ #category : #'visiting - operators' }
XPathASTNodeVisitor >> visitUnionExpression: aUnionExpression [
	^ self visitBinaryOperatorExpression: aUnionExpression
]

{ #category : #'visiting - variables' }
XPathASTNodeVisitor >> visitVariableReference: aVariableReference [
	^ aVariableReference
]
