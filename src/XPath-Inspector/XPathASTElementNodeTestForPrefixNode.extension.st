Extension { #name : #XPathASTElementNodeTestForPrefixNode }

{ #category : #'*XPath-Inspector' }
XPathASTElementNodeTestForPrefixNode >> printTreeViewLabelOn: aStream [

	super printTreeViewLabelOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self prefix;
		nextPut: $)
]
