"
An abstract class for XPath functions. Subclasses need to override the class functionPrototype method to return a string with an XPath function prototype and then implement the instance-side function method to implement the function. Arguments are passed using a stack because functions can have optional arguments or even an unbounded number of arguments, and are popped off in LIFO order (last arg popped off first).

Arguments and return values are automatically converted to the types specified in the prototype.
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
	^ aFunctionOrFunctionSet asXPathFunctionSetWithFunction: self
]

{ #category : #composition }
XPathFunction class >> - aFunctionOrFunctionSet [
	^ aFunctionOrFunctionSet asXPathFunctionSetSubtractedFromFunction: self
]

{ #category : #accessing }
XPathFunction class >> argumentTypes [
	^ argumentTypes
		ifNil: [
			self parseFunctionPrototype.
			argumentTypes]
]

{ #category : #converting }
XPathFunction class >> asXPathFunctionSet [
	^ self functionSetClass with: self
]

{ #category : #converting }
XPathFunction class >> asXPathFunctionSetSubtractedFromFunction: aFunction [
	^ aFunction asXPathFunctionSet copyWithout: self
]

{ #category : #converting }
XPathFunction class >> asXPathFunctionSetSubtractedFromFunctions: aFunctionSet [
	^ aFunctionSet copyWithout: self
]

{ #category : #converting }
XPathFunction class >> asXPathFunctionSetWithFunction: aFunction [
	^ self asXPathFunctionSet
		add: aFunction;
		yourself
]

{ #category : #converting }
XPathFunction class >> asXPathFunctionSetWithFunctions: aFunctionSet [
	^ self asXPathFunctionSet
		addAll: aFunctionSet;
		yourself
]

{ #category : #private }
XPathFunction class >> booleanClass [
	^ Boolean
]

{ #category : #accessing }
XPathFunction class >> classForTypeName: aTypeName [
	^ self
		classForTypeName: aTypeName
		ifAbsent: [self errorUnrecognizedTypeName: aTypeName]
]

{ #category : #accessing }
XPathFunction class >> classForTypeName: aTypeName ifAbsent: aBlock [
	aTypeName = 'object'
		ifTrue: [^ self objectClass].
	aTypeName = 'boolean'
		ifTrue: [^ self booleanClass].
	aTypeName = 'string'
		ifTrue: [^ self stringClass].
	aTypeName = 'number'
		ifTrue: [^ self numberClass].
	aTypeName = 'node-set'
		ifTrue: [^ self nodeSetClass].
	^ aBlock value.
]

{ #category : #'instance creation' }
XPathFunction class >> context: aContext contextNode: aContextNode [
	^ self new
		setContext: aContext
		contextNode: aContextNode
]

{ #category : #private }
XPathFunction class >> errorUnrecognizedTypeName: aTypeName [
	XPathTypeException
		formatSignal: 'Unrecognized type name "{1}"'
		with: aTypeName
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

{ #category : #private }
XPathFunction class >> functionSetClass [
	^ XPathFunctionSet
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
XPathFunction class >> nodeSetClass [
	^ XPathNodeSet
]

{ #category : #private }
XPathFunction class >> numberClass [
	^ Number
]

{ #category : #private }
XPathFunction class >> objectClass [
	^ Object
]

{ #category : #private }
XPathFunction class >> parseFunctionPrototype [
	"
	self allSubclassesDo: [:each |
		each parseFunctionPrototype]
	"

	(XPathFunctionPrototypeParser
		on: self functionPrototype
		for: (XPathInitializingFunctionPrototypeParserHandler function: self))
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

{ #category : #private }
XPathFunction class >> stringClass [
	^ String
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

{ #category : #testing }
XPathFunction >> hasPushedArguments [
	^ totalPushedArguments > 0
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

{ #category : #'instance creation' }
XPathFunction >> newNodeSet [
	^ self nodeSetClass new
]

{ #category : #accessing }
XPathFunction >> nodeSetClass [
	^ self class nodeSetClass
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
		nextPut: $(;
		print: self functionPrototype; "print: quotes"
		nextPut: $).
]

{ #category : #stack }
XPathFunction >> push: anArgument [
	self maxArguments
		ifNotNil: [:maxArguments |
			totalPushedArguments >= maxArguments
				ifTrue: [self errorTooManyArguments]].

	totalPushedArguments := totalPushedArguments + 1.
	^ context push:
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
