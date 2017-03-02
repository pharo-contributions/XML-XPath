Extension { #name : #XMLNode }

{ #category : #'*XPath-GTExtensions' }
XMLNode >> gtInspectorXPathIn: composite [
	<gtInspectorPresentationOrder: 9>

	| expressionSource resultComposite |

	expressionSource := ''.
	composite composite: [:verticalComposite |
		verticalComposite
			title: 'XPath';
			stackedVerticallyArrangement.
		verticalComposite custom:
			(GLMRubricHighlightedTextPresentation new
				title: 'Source';
				editingMode: [
					GLMHighlighterTextRubEditingMode withStylerDecorator:
						GLMXPathHighlighterTextStylerDecorator new];
				display: [expressionSource];
				withLineNumbers: true;
				act: [:presentation | | result |
					expressionSource := presentation text asString.
					[result := expressionSource asXPath in: self]
						on: XPathException
						do: [:error | result := nil].
					
					"remove any previous child presentation of resultComposite
					from a previous evaluation somehow..."
					
					"now add a new child presentation to resultComposite, either
					a label for atomic (non-node set) results or an
					OrderedCollection-style table for node sets"
					result
						ifNotNil: [
							(result isCollection
								and: [result isString not])
								ifTrue: [
									result gtInspectorItemsIn: resultComposite]
								ifFalse: [
									resultComposite label
										title: [result asString]]].
					
					"now somehow update the resultComposite to display the result;
					this does not seem to work"
					resultComposite update.
					
					presentation clearUserEdits]
					icon: GLMUIThemeExtraIcons glamorousGo
					on: $s
					entitled: 'Evaluate').
		verticalComposite composite: [:each |
			(resultComposite := each)
				title: 'Result']]
]
