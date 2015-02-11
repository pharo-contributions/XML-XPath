"
An abstract class for XPath parser handlers.
"
Class {
	#name : #XPathParserHandler,
	#superclass : #Object,
	#instVars : [
		'parsingResult'
	],
	#category : #'XPath-Core-Parsers'
}

{ #category : #handling }
XPathParserHandler >> handleEndParsing [
]

{ #category : #handling }
XPathParserHandler >> handleStartParsing [
]

{ #category : #testing }
XPathParserHandler >> mustBeAtEndAfterParsing [
	^ true
]

{ #category : #accessing }
XPathParserHandler >> parsingResult [
	^ parsingResult
]

{ #category : #accessing }
XPathParserHandler >> parsingResult: aParsingResult [
	parsingResult := aParsingResult
]
