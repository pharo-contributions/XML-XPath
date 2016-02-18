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
XPathCompiler >> compileSource: aString [
	"On Pharo/Squeak, Compiler class>>evaluate: can be used to compile source code.
	On GS, there is no Compiler class, but String>>evaluate does the same"
	^ (Smalltalk
		at: #Compiler
		ifAbsent: [^ aString evaluate])
			evaluate: aString
]

{ #category : #compiling }
XPathCompiler >> compileWithParser: aParser [
	^ self compileSource: aParser parse
]

{ #category : #accessing }
XPathCompiler >> parserClass [
	^ XPathExpressionParser
]

{ #category : #accessing }
XPathCompiler >> parserHandlerClass [
	^ XPathExpressionParserHandler
]
