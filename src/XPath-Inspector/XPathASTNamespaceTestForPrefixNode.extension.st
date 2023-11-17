Extension { #name : #XPathASTNamespaceTestForPrefixNode }

{ #category : #'*XPath-Inspector' }
XPathASTNamespaceTestForPrefixNode >> printTreeViewLabelOn: aStream [

	super printTreeViewLabelOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self prefix;
		nextPut: $)
]
