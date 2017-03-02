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
			^ aTwoArgumentBlock
				value: highlightingParserHandler
				value: highlightingParser currentPosition].
	^ aOneArgumentBlock value: highlightingParserHandler.
]
