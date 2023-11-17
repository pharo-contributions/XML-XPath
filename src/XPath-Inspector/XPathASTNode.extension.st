Extension { #name : #XPathASTNode }

{ #category : #'*XPath-Inspector' }
XPathASTNode >> inspectSourceIn: specBuilder [

	<inspectorPresentationOrder: 6 title: 'Source'>
	| code |
	code := specBuilder newCode.
	code
		withoutSyntaxHighlight;
		beNotEditable;
		overridingContextMenu;
		text: self asString.
	^ code
]

{ #category : #'*XPath-Inspector' }
XPathASTNode >> inspectTreeIn: specBuilder [

	<inspectorPresentationOrder: 5 title: 'Tree'>
	self supportsTreeView ifFalse: [
		^ specBuilder newLabel
			  label: self treeViewLabelText;
			  yourself ].

	^ specBuilder newTree
		  roots: { self };
		  children: [ :each | each treeViewChildren ];
		  display: [ :each | each treeViewLabelText ];
		  expandRoots;
		  yourself
]

{ #category : #'*XPath-Inspector' }
XPathASTNode >> printTreeViewLabelOn: aStream [

	aStream nextPutAll: self class name asString
]

{ #category : #'*XPath-Inspector' }
XPathASTNode >> supportsTreeView [

	^ false
]

{ #category : #'*XPath-Inspector' }
XPathASTNode >> treeViewChildren [

	^ #(  )
]

{ #category : #'*XPath-Inspector' }
XPathASTNode >> treeViewLabelText [

	| writeStream |
	writeStream := (String new: 100) writeStream.
	self printTreeViewLabelOn: writeStream.
	^ writeStream contents asText
]
