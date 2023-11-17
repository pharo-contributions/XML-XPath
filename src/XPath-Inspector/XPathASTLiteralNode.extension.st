Extension { #name : #XPathASTLiteralNode }

{ #category : #'*XPath-Inspector' }
XPathASTLiteralNode >> printTreeViewLabelOn: aStream [

	super printTreeViewLabelOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self asXPathString;
		nextPut: $)
]
