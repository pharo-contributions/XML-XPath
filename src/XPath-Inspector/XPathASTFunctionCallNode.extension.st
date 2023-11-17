Extension { #name : #XPathASTFunctionCallNode }

{ #category : #'*XPath-Inspector' }
XPathASTFunctionCallNode >> printTreeViewLabelOn: aStream [

	super printTreeViewLabelOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $)
]

{ #category : #'*XPath-Inspector' }
XPathASTFunctionCallNode >> supportsTreeView [

	^ self hasArguments
]

{ #category : #'*XPath-Inspector' }
XPathASTFunctionCallNode >> treeViewChildren [

	^ self arguments
]
