"
This class evaluates XPath expressions in the context of XMLNodes with optional custom context objects to control evaluation. It supports complete XPath 1.0 syntax with extensions.

Basic usage:
	| doc path result context |
	doc := XMLDOMParser parse: '<test>test</test>'.
	path := XPath for: '/test'.
	result := path in: doc.

	""with a custom context""
	path := XPath for: '/*[name() = $name]'.
	context :=  XPathContext new.
	context variableAt: 'name' put: 'test'.
	result := path in: doc context: context.

The syntax extensions are:
- Prefix wildcards in name tests like ""*:name""
- Expanded name tests like ""Q{namespaceURI}localName"" that allow easier namespace testing 
- The element(), attribute(), and namespace() type tests that can also have embedded name tests like ""element(name)""

Unlike standard XPath, by default prefixes in node tests are matched against literal prefixes of nodes, so you don't need to declare prefixes in the context before using them in node tests. Declaring at least one prefix triggers standard behavior. See XPathContext for more.

XPath expressions can be encoded directly in Smalltalk using special binary selectors on XMLNodes and  XMLNodeSets:
	xmlNode //  'entry' / '*' /'link' @ 'href'.
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

{ #category : #clearing }
XPath class >> clearCompiledXPathCache [
	"self clearCompiledXPathCache"
	compiledXPathCache
		ifNotNil: [compiledXPathCache clear]
]

{ #category : #private }
XPath class >> compiledXPathCache [
	^ compiledXPathCache
		ifNil: [compiledXPathCache := XMLKeyValueCache maxSize: 512]
]

{ #category : #accessing }
XPath class >> compiledXPathCacheAt: anXPathSourceString [
	^ self compiledXPathCache at: anXPathSourceString
]

{ #category : #accessing }
XPath class >> compiledXPathCacheAt: anXPathSourceString ifAbsent: aBlock [
	^ self compiledXPathCache
		at: anXPathSourceString
		ifAbsent: aBlock
]

{ #category : #accessing }
XPath class >> compiledXPathCacheAt: anXPathSourceString ifAbsentPut: aBlock [
	^ self compiledXPathCache
		at: anXPathSourceString
		ifAbsentPut: aBlock
]

{ #category : #accessing }
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
	"used to evaluate expressions that don't use a context node"
	^ self in: nil
]

{ #category : #evaluating }
XPath >> in: aNode [
	"evaluate in context of aNode"
	^ self
		in: aNode
		context: self contextClass new
]

{ #category : #evaluating }
XPath >> in: aNode context: aContext [
	"evaluate in context of aNode with aContext"
	^ self compiledXPath
		value: aNode
		value: aContext
]

{ #category : #printing }
XPath >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: self xPathSource;
		nextPut: $).
]

{ #category : #accessing }
XPath >> xPathSource [
	^ xPathSource
]

{ #category : #accessing }
XPath >> xPathSource: anXPathSourceString [
	xPathSource := anXPathSourceString
]
