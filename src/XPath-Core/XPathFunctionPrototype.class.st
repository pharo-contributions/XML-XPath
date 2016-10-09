"
An immutable class for storing the function return type, name, and argument number and types parsed from a function prototype source string.
"
Class {
	#name : #XPathFunctionPrototype,
	#superclass : #Object,
	#instVars : [
		'returnType',
		'functionName',
		'minArguments',
		'maxArguments',
		'argumentTypes'
	],
	#category : #'XPath-Core-Functions'
}

{ #category : #'instance creation' }
XPathFunctionPrototype class >> returnType: aReturnType functionName: aName minArguments: aMinimum maxArguments: aMaximum argumentTypes: anArgumentTypeCollection [
	^ self new
		setReturnType: aReturnType
		functionName: aName
		minArguments: aMinimum
		maxArguments: aMaximum
		argumentTypes: anArgumentTypeCollection
]

{ #category : #testing }
XPathFunctionPrototype >> acceptsArguments [
	^ self minArguments > 0
		or: [self maxArguments isNil
			or: [self maxArguments > 0]]
]

{ #category : #testing }
XPathFunctionPrototype >> acceptsOptionalArguments [
	^ self acceptsArguments
		and: [self minArguments ~= self maxArguments]
]

{ #category : #testing }
XPathFunctionPrototype >> acceptsVariableArguments [
	^ self acceptsArguments
		and: [self maxArguments isNil]
]

{ #category : #accessing }
XPathFunctionPrototype >> argumentTypeAt: anIndex [
	^ self
		argumentTypeAt: anIndex
		ifAbsent: [nil]
]

{ #category : #accessing }
XPathFunctionPrototype >> argumentTypeAt: anIndex ifAbsent: aBlock [
	anIndex > 0
		ifFalse: [^ aBlock value].
	anIndex > self argumentTypes size
		ifTrue: [
			"If it has a variable number of arguments, then
			use the last argument type for the remaining"
			self acceptsVariableArguments
				ifTrue: [^ self argumentTypes last]
				ifFalse: [^ aBlock value]].
	^ self argumentTypes at: anIndex.
]

{ #category : #accessing }
XPathFunctionPrototype >> argumentTypes [
	^ argumentTypes
]

{ #category : #accessing }
XPathFunctionPrototype >> functionName [
	^ functionName
]

{ #category : #accessing }
XPathFunctionPrototype >> maxArguments [
	^ maxArguments
]

{ #category : #accessing }
XPathFunctionPrototype >> minArguments [
	^ minArguments
]

{ #category : #printing }
XPathFunctionPrototype >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self returnType name asString;
		space;
		nextPutAll: self functionName;
		nextPut: $(.
	self argumentTypes withIndexDo: [:each :i |
		i > 1
			ifTrue: [aStream nextPutAll: ', '].
		aStream nextPutAll: each name asString.
		i > self minArguments
			ifTrue: [
				self maxArguments
					ifNil: [aStream nextPut: $*]
					ifNotNil: [aStream nextPut: $?]]].
	aStream nextPutAll: '))'.
]

{ #category : #accessing }
XPathFunctionPrototype >> returnType [
	^ returnType
]

{ #category : #initialization }
XPathFunctionPrototype >> setReturnType: aReturnType functionName: aName minArguments: aMinimum maxArguments: aMaximum argumentTypes: anArgumentTypeCollection [
	returnType := aReturnType.
	functionName := aName.
	minArguments := aMinimum.
	maxArguments := aMaximum.
	argumentTypes := anArgumentTypeCollection asArray.
]
