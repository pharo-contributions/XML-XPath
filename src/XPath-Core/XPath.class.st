"
This class evaluates XPath expressions in the context of XMLNodes using optional context objects to control evaluation. It supports all XPath 1.0 syntax.

This is the usage:
	path := XPath for: anXPathString.
	result := path in: aNode.

or with one message:
	result := XPath for: anXPathString in: aNode.

A custom context can be set this way:
	path := XPath for: anXPathString.
	path
		in: aNode
		context:
			(XPathContext new
				variableAt: 'name' put: 'value';
				yourself)

or with one message:
	XPath
		for: anXPathString
		in: aNode
		context:
			(XPathContext new
				variableAt: 'name' put: 'value';
				yourself).

Compiled XPaths are cached for performance.
"
Class {
	#name : #XPath,
	#superclass : #Object,
	#instVars : [
		'compiler',
		'xPathSource'
	],
	#classInstVars : [
		'compiledXPathCache'
	],
	#category : #'XPath-Core'
}

{ #category : #accessing }
XPath class >> clearCompiledXPathCache [
	"self clearCompiledXPathCache"
	compiledXPathCache ifNotNil: [compiledXPathCache clear]
]

{ #category : #accessing }
XPath class >> compiledXPathCache [
	^ compiledXPathCache
		ifNil: [compiledXPathCache := XMLKeyValueCache maxSize: 256]
]

{ #category : #private }
XPath class >> compiledXPathCacheAt: anXPathString ifAbsentPut: aBlock [
	^ self compiledXPathCache
		at: anXPathString
		ifAbsentPut: aBlock
]

{ #category : #'instance creation' }
XPath class >> for: anXPathSourceString [
	^ self new xPathSource: anXPathSourceString

]

{ #category : #evaluating }
XPath class >> for: anXPathSourceString in: aNode [
	^ (self for: anXPathSourceString) in: aNode

]

{ #category : #evaluating }
XPath class >> for: anXPathSourceString in: aNode context: aContext [
	^ (self for: anXPathSourceString)
		in: aNode
		context: aContext
]

{ #category : #'class initialization' }
XPath class >> initialize [
	"self initialize"

	self clearCompiledXPathCache.
	self allSubclassesDo: [:each | self clearCompiledXPathCache]
]

{ #category : #accessing }
XPath class >> maxCachedCompiledXPaths [
	^ self compiledXPathCache maxSize
]

{ #category : #accessing }
XPath class >> maxCachedCompiledXPaths: anInteger [
	self compiledXPathCache maxSize: anInteger
]

{ #category : #converting }
XPath >> asXPath [
	^ self
]

{ #category : #accessing }
XPath >> compiledXPath [
	^ self class
		compiledXPathCacheAt: self xPathSource
		ifAbsentPut: [self compiler compile: self xPathSource]
]

{ #category : #accessing }
XPath >> compiler [
	^ compiler ifNil: [compiler := self compilerClass new]
]

{ #category : #accessing }
XPath >> compiler: aCompiler [
	compiler := aCompiler
]

{ #category : #accessing }
XPath >> compilerClass [
	^ XPathCompiler
]

{ #category : #accessing }
XPath >> contextClass [
	^ XPathContext
]

{ #category : #evaluating }
XPath >> evaluate [
	^ self in: nil
]

{ #category : #evaluating }
XPath >> in: aNode [
	^ self
		in: aNode
		context: self contextClass new
]

{ #category : #evaluating }
XPath >> in: aNode context: aContext [
	^ self compiledXPath
		value: aNode
		value: aContext
]

{ #category : #accessing }
XPath >> xPathSource [
	^ xPathSource
]

{ #category : #accessing }
XPath >> xPathSource: anXPathSourceString [
	xPathSource := anXPathSourceString
]
