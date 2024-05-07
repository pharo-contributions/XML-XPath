Extension { #name : #XPathASTAttributeNodeTestForNameNode }

{ #category : #'*XPath-Inspector' }
XPathASTAttributeNodeTestForNameNode >> printTreeViewLabelOn: aStream [

	super printTreeViewLabelOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $)
]
