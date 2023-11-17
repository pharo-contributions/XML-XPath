Extension { #name : #XPathASTElementNodeTestForNamespaceURIAndLocalNameNode }

{ #category : #'*XPath-Inspector' }
XPathASTElementNodeTestForNamespaceURIAndLocalNameNode >> printTreeViewLabelOn: aStream [

	super printTreeViewLabelOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll:
			(self localName expandWithXMLNamespaceURI: self namespaceURI);
		nextPut: $)
]
