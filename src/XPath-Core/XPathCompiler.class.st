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
	^ self compileWithParser:
		(self parserClass
			on: aStringOrStream
			for: self parserHandlerClass new)
]

{ #category : #private }
XPathCompiler >> compileGeneratedSourceCode: aString [
	^ self class systemCompilerClass evaluate: aString
]

{ #category : #compiling }
XPathCompiler >> compileWithParser: aParser [
	^ self compileGeneratedSourceCode: aParser parse
]

{ #category : #accessing }
XPathCompiler >> parserClass [
	^ XPathExpressionParser
]

{ #category : #accessing }
XPathCompiler >> parserHandlerClass [
	^ XPathCompilingExpressionParserHandler
]
