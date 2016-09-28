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
