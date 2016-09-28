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
		'functionPrototype'
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

{ #category : #'instance creation' }
XPathFunction class >> context: aContext contextNode: aContextNode [
	^ self new
		setContext: aContext
		contextNode: aContextNode
]

{ #category : #accessing }
XPathFunction class >> functionName [
	^ self functionPrototype functionName
]

{ #category : #accessing }
XPathFunction class >> functionPrototype [
	^ functionPrototype
		ifNil: [
			functionPrototype :=
				(XPathFunctionPrototypeParser
					on: self functionPrototypeSource
					for: XPathTypedFunctionPrototypeParserHandler new)
				parse]
]

{ #category : #accessing }
XPathFunction class >> functionPrototype: aFunctionPrototype [
	"
	self allSubclassesDo: [:each |
		each
			functionPrototype: nil;
			functionPrototype]
	"
	functionPrototype := aFunctionPrototype
]

{ #category : #accessing }
XPathFunction class >> functionPrototypeSource [
	"Should return a protype string. See subclasses for examples."

	self subclassResponsibility
]

{ #category : #private }
XPathFunction class >> functionSetClass [
	^ XPathFunctionSet
]

{ #category : #accessing }
XPathFunction >> argumentTypeAt: anInteger [
	^ self argumentTypes at: (anInteger min: self argumentTypes size)
]

{ #category : #accessing }
XPathFunction >> argumentTypes [
	^ self functionPrototype argumentTypes
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
	^ self functionPrototype functionName
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
	^ self functionPrototype maxArguments
]

{ #category : #accessing }
XPathFunction >> minArguments [
	^ self functionPrototype minArguments
]

{ #category : #'instance creation' }
XPathFunction >> newNodeSet [
	^ self nodeSetClass new
]

{ #category : #accessing }
XPathFunction >> nodeSetClass [
	^ XPathNodeSet
]

{ #category : #stack }
XPathFunction >> pop [
	totalPushedArguments := totalPushedArguments - 1.
	^ context pop.
]

{ #category : #printing }
XPathFunction >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	self functionPrototype printOn: aStream.
	aStream nextPut: $).
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
	^ self functionPrototype returnType
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
