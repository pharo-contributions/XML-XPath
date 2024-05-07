Extension { #name : #XPathASTAttributeNodeTestForLocalNameNode }

{ #category : #'*XPath-Inspector' }
XPathASTAttributeNodeTestForLocalNameNode >> printTreeViewLabelOn: aStream [

	super printTreeViewLabelOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self localName;
		nextPut: $)
]
