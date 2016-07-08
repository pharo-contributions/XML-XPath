"
This class compiles XPath expressions by first translating them into Smalltalk using an XPathExpressionParser and handler and then compiling the result with the system compiler.
"
Class {
	#name : #XPathCompiler,
	#superclass : #Object,
	#category : #'XPath-Core'
}

{ #category : #compiling }
XPathCompiler >> compile: aStringOrStream [
	^ self compileWithParser:
		(self parserClass
			on: aStringOrStream
			for: self parserHandlerClass new)
]

{ #category : #private }
XPathCompiler >> compileGeneratedSourceCode: aString [
	"On Pharo/Squeak, Behavior class>>compilerClass returns the preferred compiler
	class for that platform and can be sent #evaluate: to compile a string.
	On GS there is no compiler class, but String>>evaluate does the same"
	(Behavior respondsTo: #compilerClass)
		ifTrue: [^ Behavior compilerClass evaluate: aString]
		ifFalse: [^ aString evaluate]
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
