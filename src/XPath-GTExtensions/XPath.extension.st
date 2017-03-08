Extension { #name : #XPath }

{ #category : #'*XPath-GTExtensions' }
XPath >> gtInspectorCompiledIn: composite [
	<gtInspectorPresentationOrder: 8>

	composite pharoMethod
		title: 'Compiled';
		display: [
			[self compiledExpression block method]
				on: XPathException
				do: [:error |
					error class name asString, '
	"', error messageText, '"']];
		smalltalkClass: [
			[self compiledExpression block method methodClass]
				on: XPathException
				do: [:error | nil]]
]

{ #category : #'*XPath-GTExtensions' }
XPath >> gtInspectorSourceIn: aComposite [
	<gtInspectorPresentationOrder: 7>

	aComposite custom:
		(GLMRubricHighlightedTextPresentation new
			title: 'Source';
			editingMode: [
				GLMHighlighterTextRubEditingMode withStylerDecorator:
					GLMXPathHighlighterTextStylerDecorator new];
			display: [self expressionSource];
			withLineNumbers: true;
			act: [:presentation |
				self expressionSource: presentation text asString.
				presentation clearUserEdits.
				aComposite pane update]
				icon: GLMUIThemeExtraIcons glamorousAccept
				on: $s
				entitled: 'Save').
]

{ #category : #'*XPath-GTExtensions' }
XPath >> gtInspectorTestsIn: composite [
	<gtInspectorPresentationOrder: 9>

	composite list
		title: 'Tests';
		display: [
			[self compiledExpression nodeTests]
				on: XPathException
				do: [:error | #()]]
]
