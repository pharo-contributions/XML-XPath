"
A handler for function prototype parsers that initializes an XPathFunction class with the function name, return type, and number and types of arguments specified by the prototype.
"
Class {
	#name : #XPathFunctionPrototypeParserHandler,
	#superclass : #XPathParserHandler,
	#instVars : [
		'function',
		'returnType',
		'functionName',
		'maxArguments',
		'minArguments',
		'argumentTypes'
	],
	#classInstVars : [
		'classesByTypeName'
	],
	#category : #'XPath-Core-Parsers'
}

{ #category : #private }
XPathFunctionPrototypeParserHandler class >> classesByTypeName [
	^ classesByTypeName
		ifNil: [
			(classesByTypeName := Dictionary new)
				at: 'object' put: Object;
				at: 'boolean' put: Boolean;
				at: 'string' put: String;
				at: 'number' put: Number;
				at: 'node-set' put: XPathNodeSet;
				yourself]
]

{ #category : #private }
XPathFunctionPrototypeParserHandler class >> classesByTypeNameAt: aTypeName ifAbsent: aBlock [
	^ self classesByTypeName
		at: aTypeName
		ifAbsent: aBlock
]

{ #category : #'instance creation' }
XPathFunctionPrototypeParserHandler class >> function: aFunction [
	^ self new setFunction: aFunction
]

{ #category : #private }
XPathFunctionPrototypeParserHandler >> addArgumentTypeFor: aTypeName [
	argumentTypes addLast: (self classForTypeName: aTypeName)
]

{ #category : #private }
XPathFunctionPrototypeParserHandler >> classForTypeName: aTypeName [
	^ self class
		classesByTypeNameAt: aTypeName
		ifAbsent: [self errorUnrecognizedTypeName: aTypeName]
]

{ #category : #private }
XPathFunctionPrototypeParserHandler >> errorUnrecognizedTypeName: aTypeName [
	XPathTypeException
		formatSignal: 'Unrecognized type name "{1}"'
		with: aTypeName
]

{ #category : #handling }
XPathFunctionPrototypeParserHandler >> handleArgument: anArgument [
	minArguments := minArguments + 1.
	maxArguments := maxArguments + 1.
	self addArgumentTypeFor: anArgument.
]

{ #category : #handling }
XPathFunctionPrototypeParserHandler >> handleEndParsing [
	function
		setReturnType: returnType
		functionName: functionName
		minArguments: minArguments
		maxArguments: maxArguments
		argumentTypes: argumentTypes
]

{ #category : #handling }
XPathFunctionPrototypeParserHandler >> handleFunctionName: aName [
	functionName := aName
]

{ #category : #handling }
XPathFunctionPrototypeParserHandler >> handleOptionalArgument: anArgument [
	maxArguments := maxArguments + 1.
	self addArgumentTypeFor: anArgument.
]

{ #category : #handling }
XPathFunctionPrototypeParserHandler >> handleReturnType: aReturnType [
	returnType := self classForTypeName: aReturnType
]

{ #category : #handling }
XPathFunctionPrototypeParserHandler >> handleUnboundedArgument: anArgument [
	maxArguments := nil.
	self addArgumentTypeFor: anArgument.
]

{ #category : #testing }
XPathFunctionPrototypeParserHandler >> hasOptionalArgument [
	^ minArguments < maxArguments
	
]

{ #category : #testing }
XPathFunctionPrototypeParserHandler >> hasUnboundedArgument [
	^ maxArguments isNil
]

{ #category : #initialization }
XPathFunctionPrototypeParserHandler >> setFunction: aFunction [
	function := aFunction.
	maxArguments := 0.
	minArguments := 0.
	argumentTypes := OrderedCollection new.
]
