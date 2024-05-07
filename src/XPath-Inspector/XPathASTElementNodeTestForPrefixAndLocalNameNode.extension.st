Extension { #name : #XPathASTElementNodeTestForPrefixAndLocalNameNode }

{ #category : #'*XPath-Inspector' }
XPathASTElementNodeTestForPrefixAndLocalNameNode >> printTreeViewLabelOn: aStream [

	super printTreeViewLabelOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: (self localName qualifyWithXMLPrefix: self prefix);
		nextPut: $)
]
