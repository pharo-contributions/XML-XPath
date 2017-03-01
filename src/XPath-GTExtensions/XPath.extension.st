Extension { #name : #XPath }

{ #category : #'*XPath-GTExtensions' }
XPath >> asHighlightedText [
	^ (XPathPositionExpressionParser
		on: self expressionSource
		for:
			(XPathHighlightingPositionExpressionParserHandler expressionSource:
				self expressionSource))
					parse
]

{ #category : #'*XPath-GTExtensions' }
XPath >> gtInspectorCompiledIn: composite [
	<gtInspectorPresentationOrder: 8>

	composite pharoMethod
		title: 'Compiled';
		display: [self compiledExpression block method];
		smalltalkClass: [self compiledExpression block method methodClass]
]

{ #category : #'*XPath-GTExtensions' }
XPath >> gtInspectorSourceIn: composite [
	<gtInspectorPresentationOrder: 7>

	composite text 
		title: 'Source';
		format: #asHighlightedText
]

{ #category : #'*XPath-GTExtensions' }
XPath >> gtInspectorTestsIn: composite [
	<gtInspectorPresentationOrder: 9>

	composite list
		title: 'Tests';
		display: [self compiledExpression nodeTests]
]
