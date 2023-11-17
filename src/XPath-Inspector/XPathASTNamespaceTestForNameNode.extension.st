Extension { #name : #XPathASTNamespaceTestForNameNode }

{ #category : #'*XPath-Inspector' }
XPathASTNamespaceTestForNameNode >> printTreeViewLabelOn: aStream [

	super printTreeViewLabelOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $)
]
