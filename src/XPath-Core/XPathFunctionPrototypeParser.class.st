"
This class parses XPath function prototypes to extract the name, return type, and the number and type of arguments.
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

	inputStream skipSeparators.
	self nextModifierForArgument: self nextName.
]

{ #category : #parsing }
XPathFunctionPrototypeParser >> nextFunctionName [
	inputStream skipSeparators.
	handler handleFunctionName: self nextName.
]

{ #category : #parsing }
XPathFunctionPrototypeParser >> nextModifierForArgument: anArgument [
	inputStream skipSeparators.
	(inputStream peekFor: $*)
		ifTrue: [
			handler hasOptionalArgument
				ifTrue: [self errorUnboundedArgumentAfterOptional].
			handler handleUnboundedArgument: anArgument]
		ifFalse: [
			(inputStream peekFor: $?)
				ifTrue: [handler handleOptionalArgument: anArgument]
				ifFalse: [
					handler hasOptionalArgument
						ifTrue: [self errorNonOptionalArgumentAfterOptional].
					handler handleArgument: anArgument]].
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
