"
An abstract class for XPath functions. Subclasses need to override the class-side functionPrototype method to return a string containing an XPath function prototype and then implement the instance-side function method to implement the function.

Arguments are passed to functions using a stack and are popped off in LIFO order (last arg popped off first). This is because functions can have optional arguments or even an unbounded number of arguments.

Arguments and return values are automatically converted to the types specified by the prototype.
"
Class {
	#name : #XPathFunction,
	#superclass : #Object,
	#instVars : [
		'context',
		'contextNode',
		'totalPushedArguments'
	],
	#classInstVars : [
		'returnType',
		'functionName',
		'minArguments',
		'maxArguments',
		'argumentTypes'
	],
	#category : #'XPath-Core-Functions'
}

{ #category : #composition }
XPathFunction class >> + aFunctionOrFunctionSet [
	^ aFunctionOrFunctionSet asFunctionSetWithFunction: self
]

{ #category : #composition }
XPathFunction class >> - aFunctionOrFunctionSet [
	^ aFunctionOrFunctionSet asFunctionSetSubtractedFromFunction: self
]

{ #category : #accessing }
XPathFunction class >> argumentTypes [
	^ argumentTypes
		ifNil: [
			self parseFunctionPrototype.
			argumentTypes]
]

{ #category : #converting }
XPathFunction class >> asFunctionSet [
	^ XPathFunctionSet with: self
]

{ #category : #converting }
XPathFunction class >> asFunctionSetSubtractedFromFunction: aFunction [
	^ aFunction asFunctionSet copyWithout: self
]

{ #category : #converting }
XPathFunction class >> asFunctionSetSubtractedFromFunctions: aFunctionSet [
	^ aFunctionSet copyWithout: self
]

{ #category : #converting }
XPathFunction class >> asFunctionSetWithFunction: aFunction [
	^ self asFunctionSet
		add: aFunction;
		yourself
]

{ #category : #converting }
XPathFunction class >> asFunctionSetWithFunctions: aFunctionSet [
	^ self asFunctionSet
		addAll: aFunctionSet;
		yourself
]

{ #category : #private }
XPathFunction class >> classForTypeName: aTypeName [
	aTypeName = 'object'
		ifTrue: [^ Object].
	aTypeName = 'boolean'
		ifTrue: [^ Boolean].
	aTypeName = 'string'
		ifTrue: [^ String].
	aTypeName = 'number'
		ifTrue: [^ Number].
	aTypeName = 'node-set'
		ifTrue: [^ XPathNodeSet].
	^ nil.
]

{ #category : #'instance creation' }
XPathFunction class >> context: aContext contextNode: aContextNode [
	^ self new
		setContext: aContext
		contextNode: aContextNode
]

{ #category : #accessing }
XPathFunction class >> functionName [
	^ functionName
		ifNil: [
			self parseFunctionPrototype.
			functionName]
]

{ #category : #accessing }
XPathFunction class >> functionPrototype [
	"should return a protype string. see subclasses for examples."
	self subclassResponsibility
]

{ #category : #accessing }
XPathFunction class >> maxArguments [
	^ maxArguments
		ifNil: [
			self parseFunctionPrototype.
			maxArguments]
]

{ #category : #accessing }
XPathFunction class >> minArguments [
	^ minArguments
		ifNil: [
			self parseFunctionPrototype.
			minArguments]
]

{ #category : #private }
XPathFunction class >> parseFunctionPrototype [
	"self allSubclassesDo: [:each | each parseFunctionPrototype]"

	(XPathFunctionPrototypeParser
		on: self functionPrototype
		for: (XPathFunctionPrototypeParserHandler function: self))
		parse
]

{ #category : #accessing }
XPathFunction class >> returnType [
	^ returnType
		ifNil: [
			self parseFunctionPrototype.
			returnType]
]

{ #category : #private }
XPathFunction class >> setReturnType: aReturnType functionName: aName minArguments: aMinimum maxArguments: aMaximum argumentTypes: anArgumentTypeCollection [
	returnType := aReturnType.
	functionName := aName.
	minArguments := aMinimum.
	maxArguments := aMaximum.
	argumentTypes := anArgumentTypeCollection asArray.
]

{ #category : #accessing }
XPathFunction >> argumentTypeAt: anInteger [
	^ self argumentTypes at: (anInteger min: self argumentTypes size)
]

{ #category : #accessing }
XPathFunction >> argumentTypes [
	^ self class argumentTypes
]

{ #category : #accessing }
XPathFunction >> context [
	^ context
]

{ #category : #accessing }
XPathFunction >> contextNode [
	^ contextNode
]

{ #category : #private }
XPathFunction >> errorTooFewArguments [
	XPathArgumentNumberException
		formatSignal: '{1}() requires at least {2} arguments'
		with: self functionName
		with: self minArguments
]

{ #category : #private }
XPathFunction >> errorTooManyArguments [
	XPathArgumentNumberException
		formatSignal: '{1}() accepts at most {2} arguments'
		with: self functionName
		with: self maxArguments
]

{ #category : #invoking }
XPathFunction >> function [
	self subclassResponsibility
]

{ #category : #accessing }
XPathFunction >> functionName [
	^ self class functionName
]

{ #category : #accessing }
XPathFunction >> functionPrototype [
	^ self class functionPrototype
]

{ #category : #invoking }
XPathFunction >> invoke [
	totalPushedArguments < self minArguments
		ifTrue: [self errorTooFewArguments].

	^ self returnType xPathNewFrom: self function.
]

{ #category : #accessing }
XPathFunction >> maxArguments [
	^ self class maxArguments
]

{ #category : #accessing }
XPathFunction >> minArguments [
	^ self class minArguments
]

{ #category : #stack }
XPathFunction >> pop [
	totalPushedArguments := totalPushedArguments - 1.
	^ context pop.
]

{ #category : #printing }
XPathFunction >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: '(''';
		nextPutAll: self functionPrototype;
		nextPutAll: ''')'.
]

{ #category : #stack }
XPathFunction >> push: anArgument [
	self maxArguments
		ifNotNil: [:maxArguments |
			totalPushedArguments >= maxArguments
				ifTrue: [self errorTooManyArguments]].

	totalPushedArguments := totalPushedArguments + 1.
	context push:
		((self argumentTypeAt: totalPushedArguments)
			xPathNewFrom: anArgument).
]

{ #category : #accessing }
XPathFunction >> returnType [
	^ self class returnType
]

{ #category : #initialization }
XPathFunction >> setContext: aContext contextNode: aContextNode [
	context := aContext.
	contextNode := aContextNode.
	totalPushedArguments := 0.
]

{ #category : #accessing }
XPathFunction >> totalPushedArguments [
	^ totalPushedArguments
]
