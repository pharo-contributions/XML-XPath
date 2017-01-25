"
This class is a rewriting node visitor that can replace any node in the tree with the result of its #visit*: message.
"
Class {
	#name : #XPathASTMutatingNodeVisitor,
	#superclass : #XPathASTNodeVisitor,
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #'visiting - location paths' }
XPathASTMutatingNodeVisitor >> visitFilterable: aFilterable [
	aFilterable hasPredicates
		ifTrue: [| oldPredicateStream oldPreviousPredicate predicates |
			oldPredicateStream := predicateStream.
			oldPreviousPredicate := previousPredicate.
			predicateStream := aFilterable predicates readStream.
			previousPredicate := XPathASTNullNode new.
			predicates := OrderedCollection new: aFilterable totalPredicates.
			[predicateStream atEnd]
				whileFalse: [| predicate |
				((predicate := self nextPredicate acceptNodeVisitor: self) isNil
					or: [predicate isNull])
					ifFalse: [
						predicates addLast: predicate.
						previousPredicate := predicate]].
			aFilterable predicates: predicates.
			predicateStream := oldPredicateStream.
			previousPredicate := oldPreviousPredicate].
	^ aFilterable.
]

{ #category : #'visiting - functions' }
XPathASTMutatingNodeVisitor >> visitFunctionCall: aFunctionCall [
	aFunctionCall hasArguments
		ifTrue: [| oldArgumentStream oldPreviousArgument arguments |
			oldArgumentStream := argumentStream.
			oldPreviousArgument := previousArgument.
			argumentStream := aFunctionCall arguments readStream.
			previousArgument := XPathASTNullNode new.
			arguments := OrderedCollection new: aFunctionCall totalArguments.
			[argumentStream atEnd]
				whileFalse: [| argument |
					((argument := self nextArgument acceptNodeVisitor: self) isNil
						or: [argument isNull])
						ifFalse: [
							arguments addLast: argument.
							previousArgument := argument]].
			aFunctionCall arguments: arguments.
			argumentStream := oldArgumentStream.
			previousArgument := oldPreviousArgument].
	^ aFunctionCall.
]

{ #category : #'visiting - location paths' }
XPathASTMutatingNodeVisitor >> visitLocationPath: aLocationPath [
	aLocationPath hasSteps
		ifTrue: [| oldStepStream oldPreviousStep steps |
			oldStepStream := stepStream.
			oldPreviousStep := previousStep.
			stepStream := aLocationPath steps readStream.
			previousStep := XPathASTNullNode new.
			steps := OrderedCollection new: aLocationPath totalSteps.
			[stepStream atEnd]
				whileFalse: [| step |
					((step := self nextStep acceptNodeVisitor: self) isNil
						or: [step isNull])
							ifFalse: [
								steps addLast: step.
								previousStep := step]].
			aLocationPath steps: steps.
			stepStream := oldStepStream.
			previousStep := oldPreviousStep].
	^ aLocationPath.
]

{ #category : #visiting }
XPathASTMutatingNodeVisitor >> visitNodeWithExpression: aNodeWithExpression [
	aNodeWithExpression expression:
		(aNodeWithExpression expression acceptNodeVisitor: self).
	^ aNodeWithExpression.
]

{ #category : #visiting }
XPathASTMutatingNodeVisitor >> visitNodeWithOtherExpression: aNodeWithOtherExpression [
	self visitNodeWithExpression: aNodeWithOtherExpression.
	aNodeWithOtherExpression otherExpression:
		(aNodeWithOtherExpression otherExpression acceptNodeVisitor: self).
	^ aNodeWithOtherExpression.
]

{ #category : #'visiting - steps' }
XPathASTMutatingNodeVisitor >> visitStep: aStep [
	aStep nodeTest: (aStep nodeTest acceptNodeVisitor: self).
	^ self visitFilterable: aStep.
]
