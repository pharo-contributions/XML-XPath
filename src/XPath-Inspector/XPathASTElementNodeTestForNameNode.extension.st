Extension { #name : #XPathASTElementNodeTestForNameNode }

{ #category : #'*XPath-Inspector' }
XPathASTElementNodeTestForNameNode >> printTreeViewLabelOn: aStream [

	super printTreeViewLabelOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $)
]
