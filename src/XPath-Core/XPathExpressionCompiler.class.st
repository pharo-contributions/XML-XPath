"
This class compiles XPath expressions. It first parses them to an intermediate representation, optimizes it, translates it to Smalltalk source code, and then compiles the translated source code using the system's compiler and returns the result as an evaluable XPathCompiledExpression object.
"
Class {
	#name : #XPathExpressionCompiler,
	#superclass : #Object,
	#classVars : [
		'SystemCompilerClass'
	],
	#category : #'XPath-Core-Compilation'
}

{ #category : #compiling }
XPathExpressionCompiler class >> compileExpression: anExpressionSourceStringOrStream [
	^ self new compileExpression: anExpressionSourceStringOrStream
]

{ #category : #accessing }
XPathExpressionCompiler class >> systemCompilerClass [
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
XPathExpressionCompiler class >> systemCompilerClass: aClass [
	SystemCompilerClass := aClass
]

{ #category : #compiling }
XPathExpressionCompiler >> compileExpression: anExpressionSourceStringOrStream [
	^ self compileTranslatedExpression:
		(self translateParsedExpression:
			(self optimizeParsedExpression:
				(self parseExpression: anExpressionSourceStringOrStream)))
]

{ #category : #private }
XPathExpressionCompiler >> compileTranslatedExpression: aTranslatedExpression [
	^ XPathCompiledExpression
		block:
			(self class systemCompilerClass evaluate:
				aTranslatedExpression sourceCode)
		nodeTests: aTranslatedExpression nodeTests
]

{ #category : #private }
XPathExpressionCompiler >> optimizeParsedExpression: anExpressionAST [
	^ self optimizerClass new
		visitNode: anExpressionAST
]

{ #category : #private }
XPathExpressionCompiler >> optimizerClass [
	^ XPathASTOptimizingMutatingNodeVisitor
]

{ #category : #private }
XPathExpressionCompiler >> parseExpression: anExpressionSourceStringOrStream [
	^ (self parserClass
		on: anExpressionSourceStringOrStream
		for: self parserHandlerClass new) parse
]

{ #category : #private }
XPathExpressionCompiler >> parserClass [
	^ XPathExpressionParser
]

{ #category : #private }
XPathExpressionCompiler >> parserHandlerClass [
	^ XPathASTExpressionParserHandler
]

{ #category : #private }
XPathExpressionCompiler >> translateParsedExpression: anExpressionAST [
	^ self translatorClass new
		visitNode: anExpressionAST;
		translatedExpression
]

{ #category : #private }
XPathExpressionCompiler >> translatorClass [
	^ XPathASTTranslatingWritingNodeVisitor
]
