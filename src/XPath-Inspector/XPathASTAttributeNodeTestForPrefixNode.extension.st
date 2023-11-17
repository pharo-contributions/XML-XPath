Extension { #name : #XPathASTAttributeNodeTestForPrefixNode }

{ #category : #'*XPath-Inspector' }
XPathASTAttributeNodeTestForPrefixNode >> printTreeViewLabelOn: aStream [

	super printTreeViewLabelOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self prefix;
		nextPut: $)
]
