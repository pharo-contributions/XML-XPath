Extension { #name : #XMLNode }

{ #category : #'*XPath-GTExtensions' }
XMLNode >> gtInspectorXPathIn: aComposite [
	<gtInspectorPresentationOrder: 9>

	self supportsXPathEvaluator
		ifFalse: [^ self].

	aComposite custom:
		(GLMRubricHighlightedTextPresentation new
			title: 'XPath';
			editingMode: [
				GLMHighlighterTextRubEditingMode withStylerDecorator:
					GLMXPathHighlighterTextStylerDecorator new];
			display: [''];
			withLineNumbers: true;
			selectionAct: [:presentation |
				presentation selection:
					(self xpath: 
						(presentation selectedText asString
							ifEmpty: [presentation text asString]))]
				on: $g
				entitled: 'Evaluate and go';
			act: [:presentation |
				presentation selection:
					(self xpath: presentation text asString)]
				icon: GLMUIThemeExtraIcons glamorousGo
				on: $G
				entitled: 'Evaluate all and go').
]

{ #category : #'*XPath-GTExtensions' }
XMLNode >> supportsXPathEvaluator [
	^ true
]
