"
A set for XPath functions. Supports set composition with + and - and lookup of functions by name.

"
Class {
	#name : #XPathFunctionSet,
	#superclass : #Collection,
	#instVars : [
		'functionsByName'
	],
	#category : #'XPath-Core-Functions'
}

{ #category : #'instance creation' }
XPathFunctionSet class >> default [
	^ XPathBooleanFunction +
		XPathCeilingFunction +
		XPathConcatFunction +
		XPathContainsFunction +
		XPathCountFunction +
		XPathEndsWithFunction +
		XPathFalseFunction +
		XPathFloorFunction +
		XPathLangFunction +
		XPathLocalNameFunction +
		XPathNameFunction +
		XPathNamespaceURIFunction +
		XPathNormalizeSpaceFunction +
		XPathNotFunction +
		XPathNumberFunction +
		XPathRoundFunction +
		XPathStartsWithFunction +
		XPathStringFunction +
		XPathStringLengthFunction +
		XPathSubstringAfterFunction +
		XPathSubstringBeforeFunction +
		XPathSubstringFunction +
		XPathSumFunction +
		XPathTranslateFunction +
		XPathTrueFunction
]

{ #category : #'instance creation' }
XPathFunctionSet class >> new [
	^ self new: 15
]

{ #category : #'instance creation' }
XPathFunctionSet class >> new: aCapacity [
	^ self basicNew initialize: aCapacity
]

{ #category : #'instance creation' }
XPathFunctionSet class >> newFrom: aCollection [
	"for portability"
	^ self withAll: aCollection
]

{ #category : #composition }
XPathFunctionSet >> + aFunctionOrFunctionSet [
	^ aFunctionOrFunctionSet asFunctionSetWithFunctions: self
]

{ #category : #copying }
XPathFunctionSet >> , aCollection [
	", is not defined for non-sequenceable collections on gemstone"
	^ self copy
		addAll: aCollection;
		yourself
]

{ #category : #composition }
XPathFunctionSet >> - aFunctionOrFunctionSet [
	^ aFunctionOrFunctionSet asFunctionSetSubtractedFromFunctions: self
]

{ #category : #comparing }
XPathFunctionSet >> = aFunctionSet [
	self == aFunctionSet
		ifTrue: [^ true].

	(self class == aFunctionSet class
		and: [self size = aFunctionSet size])
		ifFalse: [^ false].

	^ self allSatisfy: [:each | aFunctionSet includes: each].
]

{ #category : #adding }
XPathFunctionSet >> add: aFunction [
	^ functionsByName
		at: aFunction functionName
		put: aFunction
]

{ #category : #converting }
XPathFunctionSet >> asFunctionSet [
	^ self
]

{ #category : #converting }
XPathFunctionSet >> asFunctionSetSubtractedFromFunction: aFunction [
	^ aFunction asFunctionSet copyWithoutAll: self
]

{ #category : #converting }
XPathFunctionSet >> asFunctionSetSubtractedFromFunctions: aFunctionSet [
	^ aFunctionSet copyWithoutAll: self
]

{ #category : #converting }
XPathFunctionSet >> asFunctionSetWithFunction: aFunction [
	^ self copyWith: aFunction
]

{ #category : #converting }
XPathFunctionSet >> asFunctionSetWithFunctions: aFunctionSet [
	^ self, aFunctionSet
]

{ #category : #enumerating }
XPathFunctionSet >> do: aBlock [
	functionsByName valuesDo: aBlock
]

{ #category : #accessing }
XPathFunctionSet >> functionNamed: aFunctionName [
	^  functionsByName at: aFunctionName
]

{ #category : #accessing }
XPathFunctionSet >> functionNamed: aFunctionName ifAbsent: aBlock [
	^  functionsByName
		at: aFunctionName
		ifAbsent: aBlock
]

{ #category : #private }
XPathFunctionSet >> functionsByName [
	^ functionsByName
]

{ #category : #comparing }
XPathFunctionSet >> hash [
	^ functionsByName hash
]

{ #category : #testing }
XPathFunctionSet >> includes: aFunction [
	^ (functionsByName
		at: aFunction functionName
		ifAbsent: [^ false]) == aFunction
]

{ #category : #testing }
XPathFunctionSet >> includesFunctionNamed: aName [
	^ functionsByName includesKey: aName
]

{ #category : #initialization }
XPathFunctionSet >> initialize: aCapacity [
	functionsByName := Dictionary new: aCapacity
]

{ #category : #copying }
XPathFunctionSet >> postCopy [
	functionsByName := functionsByName copy
]

{ #category : #removing }
XPathFunctionSet >> remove: aFunction ifAbsent: aBlock [
	^ functionsByName
		removeKey: aFunction functionName
		ifAbsent: aBlock
]

{ #category : #accessing }
XPathFunctionSet >> size [
	^ functionsByName size
]
