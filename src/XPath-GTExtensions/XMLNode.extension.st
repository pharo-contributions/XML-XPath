Extension { #name : #XMLNode }

{ #category : #'*XPath-GTExtensions' }
XMLNode >> gtInspectorXPathIn: composite [
	<gtInspectorPresentationOrder: 9>
	composite custom:
			(GLMRubricHighlightedTextPresentation new
				title: 'XPath';
				editingMode: [
					GLMHighlighterTextRubEditingMode withStylerDecorator:
						GLMXPathHighlighterTextStylerDecorator new];
				display: [ '' ];
				withLineNumbers: true;
				act: [:presentation |
						| result |
						[result := presentation text asString asXPath in: self]
							on: XPathException
							do: [:error | result := nil].
						presentation selection: result ]
					icon: GLMUIThemeExtraIcons glamorousGo
					on: $G
					entitled: 'Evaluate and go')
]
