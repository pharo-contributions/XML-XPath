"
This class compiles XPath expressions by first translating them into Smalltalk using an XPathExpressionParser and handler and then compiling the result with the system compiler.
"
Class {
	#name : #XPathCompiler,
	#superclass : #Object,
	#classVars : [
		'SystemCompilerClass'
	],
	#category : #'XPath-Core-Compilation'
}

{ #category : #accessing }
XPathCompiler class >> systemCompilerClass [
	^ SystemCompilerClass
		ifNil: [
			"On Pharo/Squeak, Behavior class>>#compilerClass returns the  platform's
			preferred compiler class that can be sent #evaluate: to compile a
			string. On GS, any object can be sent #evaluate: to compile a string."
			SystemCompilerClass :=
				(Behavior respondsTo: #compilerClass)
					ifTrue: [Behavior compilerClass]
					ifFalse: [Behavior]]
]

{ #category : #accessing }
XPathCompiler class >> systemCompilerClass: aClass [
	SystemCompilerClass := aClass
]

{ #category : #compiling }
XPathCompiler >> compile: aStringOrStream [
	^ self compileTranslatedSource:
		(self translateParsedSource:
			(self optimizeParsedSource:
				(self parseSource: aStringOrStream)))
]

{ #category : #private }
XPathCompiler >> compileTranslatedSource: aString [
	^ self class systemCompilerClass evaluate: aString
]

{ #category : #private }
XPathCompiler >> optimizeParsedSource: anAST [
	^ self optimizerClass new visitNode: anAST
]

{ #category : #private }
XPathCompiler >> optimizerClass [
	^ XPathASTOptimizingMutatingNodeVisitor
]

{ #category : #private }
XPathCompiler >> parseSource: aStringOrStream [
	^ (self parserClass
		on: aStringOrStream
		for: self parserHandlerClass new) parse
]

{ #category : #private }
XPathCompiler >> parserClass [
	^ XPathExpressionParser
]

{ #category : #private }
XPathCompiler >> parserHandlerClass [
	^ XPathASTExpressionParserHandler
]

{ #category : #private }
XPathCompiler >> translateParsedSource: anAST [
	^ self translatorClass new
		visitNode: anAST;
		contents
]

{ #category : #private }
XPathCompiler >> translatorClass [
	^ XPathASTTranslatingNodeVisitor
]
