Extension { #name : #XPathASTNamespaceTestForLocalNameNode }

{ #category : #'*XPath-Inspector' }
XPathASTNamespaceTestForLocalNameNode >> printTreeViewLabelOn: aStream [

	super printTreeViewLabelOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self localName;
		nextPut: $)
]
