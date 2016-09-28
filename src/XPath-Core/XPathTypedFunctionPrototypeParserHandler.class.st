"
A handler class for function prototype parsers that returns XPathFunctionPrototypes with the function name, return type, and number and types of arguments from the prototype source.
"
Class {
	#name : #XPathTypedFunctionPrototypeParserHandler,
	#superclass : #XPathFunctionPrototypeParserHandler,
	#instVars : [
		'returnType',
		'functionName',
		'minArguments',
		'maxArguments',
		'argumentTypes'
	],
	#category : #'XPath-Core-Parsers'
}

{ #category : #private }
XPathTypedFunctionPrototypeParserHandler >> addArgumentTypeFor: aTypeName [
	argumentTypes addLast: (self classForTypeName: aTypeName)
]

{ #category : #private }
XPathTypedFunctionPrototypeParserHandler >> booleanClass [
	^ Boolean
]

{ #category : #accessing }
XPathTypedFunctionPrototypeParserHandler >> classForTypeName: aTypeName [
	^ self
		classForTypeName: aTypeName
		ifAbsent: [self errorUnrecognizedTypeName: aTypeName]
]

{ #category : #accessing }
XPathTypedFunctionPrototypeParserHandler >> classForTypeName: aTypeName ifAbsent: aBlock [
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

{ #category : #private }
XPathTypedFunctionPrototypeParserHandler >> errorUnrecognizedTypeName: aTypeName [
	XPathTypeException
		formatSignal: 'Unrecognized type name "{1}"'
		with: aTypeName
]

{ #category : #handling }
XPathTypedFunctionPrototypeParserHandler >> handleArgument: anArgument [
	minArguments := minArguments + 1.
	maxArguments := maxArguments + 1.
	self addArgumentTypeFor: anArgument.
]

{ #category : #handling }
XPathTypedFunctionPrototypeParserHandler >> handleEndParsing [
	self parsingResult:
		(XPathFunctionPrototype
			returnType: returnType
			functionName: functionName
			minArguments: minArguments
			maxArguments: maxArguments
			argumentTypes: argumentTypes)
]

{ #category : #handling }
XPathTypedFunctionPrototypeParserHandler >> handleFunctionName: aName [
	functionName := aName
]

{ #category : #handling }
XPathTypedFunctionPrototypeParserHandler >> handleOptionalArgument: anArgument [
	maxArguments := maxArguments + 1.
	self addArgumentTypeFor: anArgument.
]

{ #category : #handling }
XPathTypedFunctionPrototypeParserHandler >> handleReturnType: aReturnType [
	returnType := self classForTypeName: aReturnType
]

{ #category : #handling }
XPathTypedFunctionPrototypeParserHandler >> handleStartParsing [
	minArguments := 0.
	maxArguments := 0.
	argumentTypes := OrderedCollection new.
]

{ #category : #handling }
XPathTypedFunctionPrototypeParserHandler >> handleUnboundedArgument: anArgument [
	maxArguments := nil.
	self addArgumentTypeFor: anArgument.
]

{ #category : #private }
XPathTypedFunctionPrototypeParserHandler >> nodeSetClass [
	^ XPathNodeSet
]

{ #category : #private }
XPathTypedFunctionPrototypeParserHandler >> numberClass [
	^ Number
]

{ #category : #private }
XPathTypedFunctionPrototypeParserHandler >> objectClass [
	^ Object
]

{ #category : #private }
XPathTypedFunctionPrototypeParserHandler >> stringClass [
	^ String
]
