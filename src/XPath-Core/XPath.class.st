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
		'xPathSource',
		'compiledXPath'
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
		ifNil: [compiledXPathCache := XMLKeyValueCache maxSize: 512]
]

{ #category : #private }
XPath class >> compiledXPathCacheAt: anXPathSourceString ifAbsent: aBlock [
	^ self compiledXPathCache
		at: anXPathSourceString
		ifAbsent: aBlock
]

{ #category : #private }
XPath class >> compiledXPathCacheAt: anXPathSourceString put: aCompiledXPath [
	^ self compiledXPathCache
		at: anXPathSourceString
		put: aCompiledXPath
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

	self clearCompiledXPathCache
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

{ #category : #compiling }
XPath >> compile [
	^ self compileWith: self compilerClass new
]

{ #category : #compiling }
XPath >> compileWith: anXPathCompiler [
	compiledXPath := anXPathCompiler compile: self xPathSource.
	self class
		compiledXPathCacheAt: self xPathSource
		put: compiledXPath.
	^ compiledXPath.
]

{ #category : #accessing }
XPath >> compiledXPath [
	^ compiledXPath ifNil: [
		compiledXPath :=
			self class
				compiledXPathCacheAt: self xPathSource
				ifAbsent: [self compile]]
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
