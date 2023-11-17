Extension { #name : #XPathASTAttributeNodeTestForNamespaceURINode }

{ #category : #'*XPath-Inspector' }
XPathASTAttributeNodeTestForNamespaceURINode >> printTreeViewLabelOn: aStream [

	super printTreeViewLabelOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self namespaceURI;
		nextPut: $)
]
