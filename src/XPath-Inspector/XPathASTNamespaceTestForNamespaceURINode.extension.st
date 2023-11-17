Extension { #name : #XPathASTNamespaceTestForNamespaceURINode }

{ #category : #'*XPath-Inspector' }
XPathASTNamespaceTestForNamespaceURINode >> printTreeViewLabelOn: aStream [

	super printTreeViewLabelOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self namespaceURI;
		nextPut: $)
]
