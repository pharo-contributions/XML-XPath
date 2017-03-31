"
A highlighting XPath expression text style decorator.
"
Class {
	#name : #GLMXPathHighlighterTextStylerDecorator,
	#superclass : #GLMXMLHighlighterTextStylerDecorator,
	#category : #'XPath-GTExtensions-Highlighting-Parsers'
}

{ #category : #private }
GLMXPathHighlighterTextStylerDecorator >> highlightingParse: aString onSuccess: aOneArgumentBlock onError: aTwoArgumentBlock [
	| highlightingParserHandler highlightingParser |

	highlightingParserHandler :=
		XPathHighlightingPositionExpressionParserHandler expressionSource:
			aString.
	highlightingParser :=
		XPathPositionExpressionParser
			on: aString
			for: highlightingParserHandler.
	[highlightingParser parse]
		on: XPathException
		do: [:error |
			"increment the position by one to more accurately reflect
			where the error happaned, because the parser peeks for each
			kind of token"
			^ aTwoArgumentBlock
				value: highlightingParserHandler
				value: highlightingParser currentPosition + 1].
	^ aOneArgumentBlock value: highlightingParserHandler.
]
