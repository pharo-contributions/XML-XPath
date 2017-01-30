"
This class is an optimizing node visitor that does constant folding by eliminating operator expressions that can be evaluated at compile time including arithmetic and boolean operator expressions with literal string or number operands, optimizes location path steps, and eliminates redundant predicates.
"
Class {
	#name : #XPathASTOptimizingMutatingNodeVisitor,
	#superclass : #XPathASTMutatingNodeVisitor,
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #'instance creation' }
XPathASTOptimizingMutatingNodeVisitor >> newFunctionCallForBoolean: aBoolean [
	"the XPath string of a boolean is 'true' or 'false', the function names"
	^ XPathASTFunctionCallNode name: aBoolean asXPathString
]

{ #category : #'visiting - operators' }
XPathASTOptimizingMutatingNodeVisitor >> visitAdditionExpression: anAdditionExpression [
	"visit operands first to traverse bottom-up"
	super visitAdditionExpression: anAdditionExpression.

	anAdditionExpression hasNonLiteralExpression
		ifTrue: [^ anAdditionExpression]
		ifFalse: [
			^ XPathASTNumberLiteralNode number:
				anAdditionExpression expression asXPathNumber +
					anAdditionExpression otherExpression asXPathNumber].
]

{ #category : #'visiting - steps' }
XPathASTOptimizingMutatingNodeVisitor >> visitDescendantOrSelfStep: aDescendantOrSelfStep [
	super visitDescendantOrSelfStep: aDescendantOrSelfStep.

	(aDescendantOrSelfStep nodeTest isAnyNodeTest
		and: [aDescendantOrSelfStep hasPredicates not])
		ifFalse: [^ aDescendantOrSelfStep].

	"'descendant-or-self::node()/child::...' and
	'descendant-or-self::node()/descendant::...' are
	equivalent to ''descendant::...' if the second
	step has no predicares"
	((self peekStep isChildStep
		or: [self peekStep isDescendantStep])
		and: [self peekStep hasPredicates not])
		ifTrue: [| replacementNode |
			replacementNode :=
				(XPathASTDescendantStepNode
					nodeTest: self peekStep nodeTest
					predicates: self peekStep predicates).
			self nextStep.
			^ replacementNode].

	"'descendant-or-self::node()/self::...' and
	'descendant-or-self::node()/descendant-or-self::...'
	are equivalent to ''descendant-or-self::...' if
	the second step has no predicares"
	[(self peekStep isDescendantOrSelfStep
		or: [self peekStep isSelfStep])
		and: [self peekStep nodeTest isAnyNodeTest
			and: [self peekStep hasPredicates not]]]
		whileTrue: [self nextStep].
	((self peekStep isDescendantOrSelfStep
		or: [self peekStep isSelfStep])
		and: [self peekStep hasPredicates not])
		ifTrue: [| replacementNode |
			replacementNode :=
				(XPathASTDescendantOrSelfStepNode
					nodeTest: self peekStep nodeTest
					predicates: self peekStep predicates).
			self nextStep.
			^ replacementNode].

	^ aDescendantOrSelfStep.
]

{ #category : #'visiting - operators' }
XPathASTOptimizingMutatingNodeVisitor >> visitDivisionExpression: aDivisionExpression [
	"visit operands first to traverse bottom-up"
	super visitDivisionExpression: aDivisionExpression.

	aDivisionExpression hasNonLiteralExpression
		ifTrue: [^ aDivisionExpression]
		ifFalse: [
			^ XPathASTNumberLiteralNode number:
				(aDivisionExpression expression asXPathNumber xPathDivision:
					aDivisionExpression otherExpression asXPathNumber)].
]

{ #category : #'visiting - operators' }
XPathASTOptimizingMutatingNodeVisitor >> visitEqualsExpression: anEqualsExpression [
	"visit operands first to traverse bottom-up"
	super visitEqualsExpression: anEqualsExpression.

	anEqualsExpression hasNonLiteralExpression
		ifTrue: [
			(anEqualsExpression hasParent
				and: [anEqualsExpression parent isPredicate])
				ifTrue: [
					"replace predicate expressions like 'position()=10'
					and '10=position()' with '10'"
					anEqualsExpression expression isNumberLiteral
						ifTrue: [
							(anEqualsExpression otherExpression isFunctionCall
								and: [
									anEqualsExpression otherExpression
										isPositionFunctionCall])
								ifTrue: [^ anEqualsExpression expression]]
						ifFalse: [
							anEqualsExpression otherExpression isNumberLiteral
								ifTrue: [
									(anEqualsExpression expression isFunctionCall
										and: [
											anEqualsExpression expression
												isPositionFunctionCall])
										ifTrue: [^ anEqualsExpression otherExpression]]]].
			^ anEqualsExpression]
		ifFalse: [
			"When neither object ... is a node-set and the operator is = or != ...
			if at least one object ... is a number, then each ... is converted to
			a number ... Otherwise, both ... are converted to strings"
			(anEqualsExpression hasNumberLiteralExpression
				ifTrue: [
					^ self newFunctionCallForBoolean:
						anEqualsExpression expression asXPathNumber =
							anEqualsExpression otherExpression asXPathNumber]
				ifFalse: [
					^ self newFunctionCallForBoolean:
						anEqualsExpression expression asXPathString =
							anEqualsExpression otherExpression asXPathString])].
]

{ #category : #'visiting - location paths' }
XPathASTOptimizingMutatingNodeVisitor >> visitFilterExpression: aFilterExpression [
	super visitFilterExpression: aFilterExpression.

	aFilterExpression hasPredicates
		ifFalse: [
			aFilterExpression type:
				aFilterExpression expression type].
	^ aFilterExpression.
]

{ #category : #'visiting - location paths' }
XPathASTOptimizingMutatingNodeVisitor >> visitFilterExpressionLocationPath: aFilterExpressionLocationPath [
	super visitFilterExpressionLocationPath: aFilterExpressionLocationPath.

	aFilterExpressionLocationPath hasSteps
		ifFalse: [
			aFilterExpressionLocationPath type:
				aFilterExpressionLocationPath expression type].
	^ aFilterExpressionLocationPath.
]

{ #category : #'visiting - functions' }
XPathASTOptimizingMutatingNodeVisitor >> visitFunctionCall: aFunctionCall [
	super visitFunctionCall: aFunctionCall.

	"these function calls are inlined by the translator, so we can infer their
	types during compilation, but all other functions can be dynamically
	rebound at runtime with XPathContext objects, so we don't infer them"
	(aFunctionCall isTrueFunctionCall
		or: [aFunctionCall isFalseFunctionCall])
		ifTrue: [aFunctionCall type: XPathBooleanType new]
		ifFalse: [
			(aFunctionCall isPositionFunctionCall
				or: [aFunctionCall isLastFunctionCall])
				ifTrue: [aFunctionCall type: XPathNumberType new]].
	^ aFunctionCall.
]

{ #category : #'visiting - operators' }
XPathASTOptimizingMutatingNodeVisitor >> visitGreaterThanExpression: aGreaterThanExpression [
	"visit operands first to traverse bottom-up"
	super visitGreaterThanExpression: aGreaterThanExpression.

	aGreaterThanExpression hasNonLiteralExpression
		ifTrue: [^ aGreaterThanExpression]
		ifFalse: [
			^ self newFunctionCallForBoolean:
				aGreaterThanExpression expression asXPathNumber >
					aGreaterThanExpression otherExpression asXPathNumber].
]

{ #category : #'visiting - operators' }
XPathASTOptimizingMutatingNodeVisitor >> visitGreaterThanOrEqualToExpression: aGreaterThanOrEqualToExpression [
	"visit operands first to traverse bottom-up"
	super visitGreaterThanOrEqualToExpression: aGreaterThanOrEqualToExpression.

	aGreaterThanOrEqualToExpression hasNonLiteralExpression
		ifTrue: [^ aGreaterThanOrEqualToExpression]
		ifFalse: [
			^ self newFunctionCallForBoolean:
				aGreaterThanOrEqualToExpression expression asXPathNumber >=
					aGreaterThanOrEqualToExpression otherExpression asXPathNumber].
]

{ #category : #'visiting - operators' }
XPathASTOptimizingMutatingNodeVisitor >> visitLessThanExpression: aLessThanExpression [
	"visit operands first to traverse bottom-up"
	super visitLessThanExpression: aLessThanExpression.

	aLessThanExpression hasNonLiteralExpression
		ifTrue: [^ aLessThanExpression]
		ifFalse: [
			^ self newFunctionCallForBoolean:
				aLessThanExpression expression asXPathNumber <
					aLessThanExpression otherExpression asXPathNumber].
]

{ #category : #'visiting - operators' }
XPathASTOptimizingMutatingNodeVisitor >> visitLessThanOrEqualToExpression: aLessThanOrEqualToExpression [
	"visit operands first to traverse bottom-up"
	super visitLessThanOrEqualToExpression: aLessThanOrEqualToExpression.

	aLessThanOrEqualToExpression hasNonLiteralExpression
		ifTrue: [^ aLessThanOrEqualToExpression]
		ifFalse: [
			^ self newFunctionCallForBoolean:
				aLessThanOrEqualToExpression expression asXPathNumber <=
					aLessThanOrEqualToExpression otherExpression asXPathNumber].
]

{ #category : #'visiting - operators' }
XPathASTOptimizingMutatingNodeVisitor >> visitModulusExpression: aModulusExpression [
	"visit operands first to traverse bottom-up"
	super visitModulusExpression: aModulusExpression.

	aModulusExpression hasNonLiteralExpression
		ifTrue: [^ aModulusExpression]
		ifFalse: [
			^ XPathASTNumberLiteralNode number:
				(aModulusExpression expression asXPathNumber xPathModulus:
					aModulusExpression otherExpression asXPathNumber)]
]

{ #category : #'visiting - operators' }
XPathASTOptimizingMutatingNodeVisitor >> visitMultiplicationExpression: aMultiplicationExpression [
	"visit operands first to traverse bottom-up"
	super visitMultiplicationExpression: aMultiplicationExpression.

	aMultiplicationExpression hasNonLiteralExpression
		ifTrue: [^ aMultiplicationExpression]
		ifFalse: [
			^ XPathASTNumberLiteralNode number:
				aMultiplicationExpression expression asXPathNumber *
					aMultiplicationExpression otherExpression asXPathNumber]
]

{ #category : #'visiting - operators' }
XPathASTOptimizingMutatingNodeVisitor >> visitNegationExpression: aNegationExpression [
	"visit the operand first to traverse bottom-up"
	super visitNegationExpression: aNegationExpression.

	aNegationExpression hasNonLiteralExpression
		ifTrue: [^ aNegationExpression]
		ifFalse: [
			^ XPathASTNumberLiteralNode number:
				aNegationExpression expression asXPathNumber negated].
]

{ #category : #'visiting - operators' }
XPathASTOptimizingMutatingNodeVisitor >> visitNotEqualsExpression: anNotEqualsExpression [
	"visit operands first to traverse bottom-up"
	super visitNotEqualsExpression: anNotEqualsExpression.

	anNotEqualsExpression hasNonLiteralExpression
		ifTrue: [^ anNotEqualsExpression]
		ifFalse: [
			"When neither object ... is a node-set and the operator is = or != ...
			if at least one object ... is a number, then each ... is converted to
			a number ... Otherwise, both ... are converted to strings"
			anNotEqualsExpression hasNumberLiteralExpression
				ifTrue: [
					^ self newFunctionCallForBoolean:
						anNotEqualsExpression expression asXPathNumber ~=
							anNotEqualsExpression otherExpression asXPathNumber]
				ifFalse: [
					^ self newFunctionCallForBoolean:
						anNotEqualsExpression expression asXPathString ~=
							anNotEqualsExpression otherExpression asXPathString]].
]

{ #category : #'visiting - predicates' }
XPathASTOptimizingMutatingNodeVisitor >> visitPredicate: aPredicate [
	super visitPredicate: aPredicate.

	"a predicate that is just [true()] can be ignored if it's not first"
	(self previousPredicate isNull not
		and: [aPredicate expression isFunctionCall
			and: [aPredicate expression isTrueFunctionCall]])
		ifTrue: [^ nil]
		ifFalse: [^ aPredicate].
]

{ #category : #'visiting - steps' }
XPathASTOptimizingMutatingNodeVisitor >> visitSelfStep: aSelfStep [
	super visitSelfStep: aSelfStep.

	"'self::node()' or '.' can be eliminated if it's not the first step
	and the previous step is a forward axis step"
	(aSelfStep nodeTest isAnyNodeTest
		and: [aSelfStep hasPredicates not
			and: [self previousStep isNull not
				and: [self previousStep isForwardAxisStep]]])
		ifTrue: [^ XPathASTNullNode new]
		ifFalse: [^ aSelfStep].
]

{ #category : #'visiting - operators' }
XPathASTOptimizingMutatingNodeVisitor >> visitSubtractionExpression: aSubtractionExpression [
	"visit operands first to traverse bottom-up"
	super visitSubtractionExpression: aSubtractionExpression.

	aSubtractionExpression hasNonLiteralExpression
		ifTrue: [^ aSubtractionExpression]
		ifFalse: [
			^ XPathASTNumberLiteralNode number:
				aSubtractionExpression expression asXPathNumber -
					aSubtractionExpression otherExpression asXPathNumber].
]
