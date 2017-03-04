Extension { #name : #XMLNode }

{ #category : #'*XPath-GTExtensions' }
XMLNode >> addXPathEvaluatorToComposite: aComposite [
	aComposite custom:
		(GLMRubricHighlightedTextPresentation new
			title: 'XPath';
			editingMode: [
				GLMHighlighterTextRubEditingMode withStylerDecorator:
					GLMXPathHighlighterTextStylerDecorator new];
			display: [''];
			withLineNumbers: true;
			selectionAct: [:presentation |
				presentation selectedText asString
					ifNotEmpty: [:source |
						presentation selection:
							(self xPath: source)]]
				on: $g
				entitled: 'Evaluated and go';
			act: [:presentation |
				presentation selection:
					(self xPath: presentation text asString)]
				icon: GLMUIThemeExtraIcons glamorousGo
				on: $G
				entitled: 'Evaluate all and go')
]

{ #category : #'*XPath-GTExtensions' }
XMLNode >> gtInspectorXPathIn: aComposite [
	<gtInspectorPresentationOrder: 9>

	self addXPathEvaluatorToComposite: aComposite
]
