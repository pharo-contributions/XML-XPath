Extension { #name : #XPathASTElementNodeTestForLocalNameNode }

{ #category : #'*XPath-Inspector' }
XPathASTElementNodeTestForLocalNameNode >> printTreeViewLabelOn: aStream [

	super printTreeViewLabelOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self localName;
		nextPut: $)
]
