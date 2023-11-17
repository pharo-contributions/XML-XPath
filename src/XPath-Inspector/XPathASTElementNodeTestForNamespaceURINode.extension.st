Extension { #name : #XPathASTElementNodeTestForNamespaceURINode }

{ #category : #'*XPath-Inspector' }
XPathASTElementNodeTestForNamespaceURINode >> printTreeViewLabelOn: aStream [

	super printTreeViewLabelOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self namespaceURI;
		nextPut: $)
]
