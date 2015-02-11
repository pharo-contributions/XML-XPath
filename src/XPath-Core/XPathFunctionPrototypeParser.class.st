"
This class parses XPath function prototypes.
"
Class {
	#name : #XPathFunctionPrototypeParser,
	#superclass : #XPathParser,
	#category : #'XPath-Core-Parsers'
}

{ #category : #private }
XPathFunctionPrototypeParser >> errorArgumentAfterUnboundedArgument [
	XPathSyntaxException signal: 'Argument after unbounded "*" argument'
]

{ #category : #private }
XPathFunctionPrototypeParser >> errorNonOptionalArgumentAfterOptional [
	XPathSyntaxException signal: 'Non-optional argument afer optional "?" argument'
]

{ #category : #private }
XPathFunctionPrototypeParser >> errorUnboundedArgumentAfterOptional [
	XPathSyntaxException signal: 'Unbounded "*" argument after optional "?" argument'
]

{ #category : #parsing }
XPathFunctionPrototypeParser >> nextArgument [
	handler hasUnboundedArgument
		ifTrue: [self errorArgumentAfterUnboundedArgument].

	self nextArgumentTypeAndModifier.
	
	inputStream skipSeparators.
	inputStream peek == $)
		ifFalse: [self expectNext: $,].
]

{ #category : #parsing }
XPathFunctionPrototypeParser >> nextArgumentList [
	self nextStartArgumentList.
	[inputStream skipSeparators.
	inputStream peek == $)]
		whileFalse: [self nextArgument].
	self nextEndArgumentList.
]

{ #category : #parsing }
XPathFunctionPrototypeParser >> nextArgumentTypeAndModifier [
	| argument |
	
	argument := self nextName.
	(inputStream peekFor: $*)
		ifTrue: [
			handler hasOptionalArgument
				ifTrue: [self errorUnboundedArgumentAfterOptional].
			handler handleUnboundedArgument: argument]
		ifFalse: [
			(inputStream peekFor: $?)
				ifTrue: [handler handleOptionalArgument: argument]
				ifFalse: [
					handler hasOptionalArgument
						ifTrue: [self errorNonOptionalArgumentAfterOptional].
					handler handleArgument: argument]].
]

{ #category : #parsing }
XPathFunctionPrototypeParser >> nextFunctionName [
	inputStream skipSeparators.
	handler handleFunctionName: self nextName.
]

{ #category : #parsing }
XPathFunctionPrototypeParser >> nextReturnType [
	inputStream skipSeparators.
	handler handleReturnType: self nextName.
]

{ #category : #parsing }
XPathFunctionPrototypeParser >> parseInput [
	self
		nextReturnType;
		nextFunctionName;
		nextArgumentList
]
