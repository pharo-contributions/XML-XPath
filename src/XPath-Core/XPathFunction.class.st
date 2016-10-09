"
An abstract class for XPath functions. Subclasses need to implement the class #functionPrototype method to return a string with an XPath function prototype and then implement the instance-side #function method to implement the function and return its value.

When invoked, the arguments and the return value are automatically converted to the types specified by the prototype.
"
Class {
	#name : #XPathFunction,
	#superclass : #Object,
	#instVars : [
		'context',
		'contextNode',
		'arguments'
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
XPathFunction class >> context: aContext contextNode: aContextNode arguments: aSequenceableCollection [
	^ self new
		setContext: aContext
		contextNode: aContextNode
		arguments: aSequenceableCollection
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

{ #category : #testing }
XPathFunction >> acceptsArguments [
	^ self functionPrototype acceptsArguments
]

{ #category : #testing }
XPathFunction >> acceptsOptionalArguments [
	^ self functionPrototype acceptsOptionalArguments
]

{ #category : #testing }
XPathFunction >> acceptsVariableArguments [
	^ self functionPrototype acceptsVariableArguments
]

{ #category : #accessing }
XPathFunction >> argumentAt: anIndex [
	^ self
		argumentAt: anIndex
		ifAbsent: [nil]
]

{ #category : #accessing }
XPathFunction >> argumentAt: anIndex ifAbsent: aBlock [
	^ self arguments
		at: anIndex
		ifAbsent: aBlock
]

{ #category : #accessing }
XPathFunction >> argumentTypeAt: anIndex [
	^ self functionPrototype argumentTypeAt: anIndex
]

{ #category : #accessing }
XPathFunction >> argumentTypeAt: anIndex ifAbsent: aBlock [
	^ self functionPrototype
		argumentTypeAt: anIndex
		ifAbsent: aBlock
]

{ #category : #accessing }
XPathFunction >> argumentTypes [
	^ self functionPrototype argumentTypes
]

{ #category : #accessing }
XPathFunction >> arguments [
	^ arguments
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
XPathFunction >> errorAcceptsAtMost: anArgumentMaximum argumentsButGot: anArgumentTotal [
	XPathArgumentNumberException
		formatSignal: '{1}() accepts at most {2} argument(s) but was called with {3}'
		with: self functionName
		with: anArgumentMaximum
		with: anArgumentTotal
]

{ #category : #private }
XPathFunction >> errorRequiresAtLeast: anArgumentMinimum argumentsButGot: anArgumentTotal [
	XPathArgumentNumberException
		formatSignal:
			'{1}() requires at least {2} argument(s) but was called with {3}'
		with: self functionName
		with: anArgumentMinimum
		with: anArgumentTotal
]

{ #category : #accessing }
XPathFunction >> firstArgument [
	^ self argumentAt: 1
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
XPathFunction >> hasArguments [
	^ self totalArguments > 0
]

{ #category : #invoking }
XPathFunction >> invoke [
	^ self returnType xPathNewFrom: self function
]

{ #category : #accessing }
XPathFunction >> lastArgument [
	^ self argumentAt: self totalArguments
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

{ #category : #printing }
XPathFunction >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	self functionPrototype printOn: aStream.
	aStream nextPut: $).
]

{ #category : #accessing }
XPathFunction >> returnType [
	^ self functionPrototype returnType
]

{ #category : #initialization }
XPathFunction >> setArguments: aSequenceableCollection [
	"ensure there aren't too many or too few"
	aSequenceableCollection size < self minArguments
		ifTrue: [
			self
				errorRequiresAtLeast: self minArguments
				argumentsButGot: aSequenceableCollection size].
	(self maxArguments notNil
		and: [aSequenceableCollection size > self maxArguments])
		ifTrue: [
			self
				errorAcceptsAtMost: self maxArguments
				argumentsButGot: aSequenceableCollection size].

	"convert them to the appropriate type (use to:do: for speed)"
	1 to: aSequenceableCollection size do: [:i |
		aSequenceableCollection
			at: i
			put:
				((self argumentTypeAt: i) xPathNewFrom:
					(aSequenceableCollection at: i))].

	arguments := aSequenceableCollection asArray.
]

{ #category : #initialization }
XPathFunction >> setContext: aContext contextNode: aContextNode arguments: aSequenceableCollection [
	context := aContext.
	contextNode := aContextNode.
	self setArguments: aSequenceableCollection.
]

{ #category : #accessing }
XPathFunction >> totalArguments [
	^ self arguments size
]
