Extension { #name : #XPath }

{ #category : #'*XPath-GTExtensions' }
XPath >> errorTextFor: anError [
	| errorClassName errorMessage errorText |

	errorClassName := anError class name asString.
	errorMessage := anError messageText.
	errorText :=
		(errorClassName, '
	', errorMessage) asText.
	errorText
		addAttribute: TextColor red
		from: 1
		to: errorText size.
	errorText
		addAttribute: XPathExpressionHighlightDefaults defaultDefaultColor
		from: 1
		to: errorClassName size.
	errorText
		addAttribute: TextEmphasis bold
		from: 1
		to: errorClassName size.
	^ errorText.
]

{ #category : #'*XPath-GTExtensions' }
XPath >> gtInspectorASTIn: aComposite [
	<gtInspectorPresentationOrder: 7>

	| ast astError |

	[ast :=
		(XPathExpressionParser
			on: self expressionSource
			for: XPathASTExpressionParserHandler new) parse]
		on: XPathException
		do: [:error |
			ast := nil.
			astError := error].

	aComposite tree
		title: 'AST';
		display: [{ast}];
		children: [:each | each treeViewChildren];
		format: [:each | each treeViewLabelText];
		when: [ast notNil];
		rootsExpanded.
	aComposite text
		title: 'AST';
		format: [self errorTextFor: astError];
		when: [ast isNil].
]

{ #category : #'*XPath-GTExtensions' }
XPath >> gtInspectorCompiledIn: aComposite [
	<gtInspectorPresentationOrder: 8>

	| block blockError |

	[block := self compiledExpression block]
		on: XPathException
		do: [:error |
			block := nil.
			blockError := error].

	aComposite pharoMethod
		title: 'Compiled';
		display: [block method];
		smalltalkClass: [block method methodClass];
		when: [block notNil].
	aComposite text
		title: 'Compiled';
		format: [self errorTextFor: blockError];
		when: [block isNil].
]

{ #category : #'*XPath-GTExtensions' }
XPath >> gtInspectorSourceIn: aComposite inContext: aGTInspector [
	<gtInspectorPresentationOrder: 6>

	| currentTextStylerDecorator |

	aComposite custom:
		(GLMRubricHighlightedTextPresentation new
			title: 'Source';
			editingMode: [
				currentTextStylerDecorator :=
					GLMXPathHighlighterTextStylerDecorator new.
				GLMHighlighterTextRubEditingMode withStylerDecorator:
					currentTextStylerDecorator];
			display: [self expressionSource];
			withLineNumbers: true;
			act: [:presentation |
				self expressionSource: currentTextStylerDecorator text asString.
				[aGTInspector panes size > 1]
					whileTrue: [aGTInspector removeLastPane].
				"update the entire pane, because the expression has changed"
				aComposite pane update]
				icon: GLMUIThemeExtraIcons glamorousAccept
				on: $s
				entitled: 'Accept';
			act: [:presentation |
				"revert only this presentation"
				presentation update]
				icon: GLMUIThemeExtraIcons glamorousUndo
				on: $Z
				entitled: 'Revert').
]

{ #category : #'*XPath-GTExtensions' }
XPath >> gtInspectorTestsIn: aComposite [
	<gtInspectorPresentationOrder: 9>

	| nodeTests nodeTestsError |

	[nodeTests := self compiledExpression nodeTests]
		on: XPathException
		do: [:error |
			nodeTests := nil.
			nodeTestsError := error].

	aComposite list
		title: 'Tests';
		display: [nodeTests];
		when: [nodeTests notNil].
	aComposite text
		title: 'Tests';
		format: [self errorTextFor: nodeTestsError];
		when: [nodeTests isNil].
]
