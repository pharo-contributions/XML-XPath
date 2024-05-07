Extension { #name : #XPathASTVariableReferenceNode }

{ #category : #'*XPath-Inspector' }
XPathASTVariableReferenceNode >> printTreeViewLabelOn: aStream [

	super printTreeViewLabelOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $)
]
