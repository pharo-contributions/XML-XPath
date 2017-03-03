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
			selectionAct: [ :presentation | presentation selection: (self xPath: presentation selectedText) ]
				on: $g
				entitled: 'Evaluated and go';
			act: [:presentation | presentation selection: (self xPath: presentation text) ]
				icon: GLMUIThemeExtraIcons glamorousGo
				on: $G
				entitled: 'Evaluate all and go')
]
