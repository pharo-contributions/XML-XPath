"
A handler class for function prototype parsers that initializes an XPathFunction class with the function name, return type, and number and types of arguments specified by the prototype.
"
Class {
	#name : #XPathInitializingFunctionPrototypeParserHandler,
	#superclass : #XPathFunctionPrototypeParserHandler,
	#instVars : [
		'function',
		'returnType',
		'functionName',
		'minArguments',
		'maxArguments',
		'argumentTypes'
	],
	#classVars : [
		'ClassesByTypeName'
	],
	#category : #'XPath-Core-Parsers'
}

{ #category : #'instance creation' }
XPathInitializingFunctionPrototypeParserHandler class >> function: aFunction [
	^ self new setFunction: aFunction
]

{ #category : #'class initialization' }
XPathInitializingFunctionPrototypeParserHandler class >> initialize [
	"self initialize"

	(ClassesByTypeName := Dictionary new)
		at: 'object' put: Object;
		at: 'boolean' put: Boolean;
		at: 'string' put: String;
		at: 'number' put: Number;
		at: 'node-set' put: XPathNodeSet
]

{ #category : #private }
XPathInitializingFunctionPrototypeParserHandler >> addArgumentTypeFor: aTypeName [
	argumentTypes addLast: (self classForTypeName: aTypeName)
]

{ #category : #private }
XPathInitializingFunctionPrototypeParserHandler >> classForTypeName: aTypeName [
	^ ClassesByTypeName
		at: aTypeName
		ifAbsent: [self errorUnrecognizedTypeName: aTypeName]
]

{ #category : #private }
XPathInitializingFunctionPrototypeParserHandler >> errorUnrecognizedTypeName: aTypeName [
	XPathTypeException
		formatSignal: 'Unrecognized type name "{1}"'
		with: aTypeName
]

{ #category : #handling }
XPathInitializingFunctionPrototypeParserHandler >> handleArgument: anArgument [
	minArguments := minArguments + 1.
	maxArguments := maxArguments + 1.
	self addArgumentTypeFor: anArgument.
]

{ #category : #handling }
XPathInitializingFunctionPrototypeParserHandler >> handleEndParsing [
	function
		setReturnType: returnType
		functionName: functionName
		minArguments: minArguments
		maxArguments: maxArguments
		argumentTypes: argumentTypes
]

{ #category : #handling }
XPathInitializingFunctionPrototypeParserHandler >> handleFunctionName: aName [
	functionName := aName
]

{ #category : #handling }
XPathInitializingFunctionPrototypeParserHandler >> handleOptionalArgument: anArgument [
	maxArguments := maxArguments + 1.
	self addArgumentTypeFor: anArgument.
]

{ #category : #handling }
XPathInitializingFunctionPrototypeParserHandler >> handleReturnType: aReturnType [
	returnType := self classForTypeName: aReturnType
]

{ #category : #handling }
XPathInitializingFunctionPrototypeParserHandler >> handleUnboundedArgument: anArgument [
	maxArguments := nil.
	self addArgumentTypeFor: anArgument.
]

{ #category : #initialization }
XPathInitializingFunctionPrototypeParserHandler >> setFunction: aFunction [
	function := aFunction.
	maxArguments := 0.
	minArguments := 0.
	argumentTypes := OrderedCollection new.
]
