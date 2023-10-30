Extension { #name : #XPath }

{ #category : #'*XPath-Inspector' }
XPath >> inspectASTIn: specBuilder [

	<inspectorPresentationOrder: 6 title: 'AST'>
	^ self
		  newPresenterForASTGeneratedWith: [
		  XPathExpressionCompiler new parseExpression: self expressionSource ]
		  in: specBuilder
]

{ #category : #'*XPath-Inspector' }
XPath >> inspectCompiledIn: specBuilder [

	<inspectorPresentationOrder: 8 title: 'Compiled'>
	| method |
	method := [ self compiledExpression block ]
		          on: XPathException
		          do: [ :error |
		          ^ self newTextPresenterForError: error in: specBuilder ].

	^ method inspectionSource
]

{ #category : #'*XPath-Inspector' }
XPath >> inspectOptimizedASTIn: specBuilder [

	<inspectorPresentationOrder: 7 title: 'Optimized AST'>
	^ self
		  newPresenterForASTGeneratedWith: [
			  | compiler |
			  compiler := XPathExpressionCompiler new.
			  compiler optimizeParsedExpression:
				  (compiler parseExpression: self expressionSource) ]
		  in: specBuilder
]

{ #category : #'*XPath-Inspector' }
XPath >> inspectSourceIn: specBuilder [

	<inspectorPresentationOrder: 5 title: 'Source'>
	| code |
	code := specBuilder newCode.
	code
		withoutSyntaxHighlight;
		whenSubmitDo: [ :text |
			self expressionSource: text asString.
			code text: self expressionSource ];
		text: self expressionSource.
	^ code
]

{ #category : #'*XPath-Inspector' }
XPath >> inspectTestsIn: specBuilder [

	<inspectorPresentationOrder: 9 title: 'Tests'>
	| nodeTests |
	nodeTests := [ self compiledExpression nodeTests ]
		             on: XPathException
		             do: [ :error |
		             ^ self newTextPresenterForError: error in: specBuilder ].
	^ specBuilder newList
		  items: nodeTests;
		  yourself
]

{ #category : #'*XPath-Inspector' }
XPath >> newPresenterForASTGeneratedWith: aBlock in: specBuilder [

	| ast |
	ast := aBlock
		       on: XPathException
		       do: [ :error |
		       ^ self newTextPresenterForError: error in: specBuilder ].

	^ specBuilder newTree
		  roots: { ast };
		  children: [ :each | each treeViewChildren ];
		  display: [ :each | each treeViewLabelText ];
		  expandRoots;
		  yourself
]

{ #category : #'*XPath-Inspector' }
XPath >> newTextPresenterForError: anError in: specBuilder [

	^ specBuilder newText text: anError class name asString , '
' , anError messageText asString
]
