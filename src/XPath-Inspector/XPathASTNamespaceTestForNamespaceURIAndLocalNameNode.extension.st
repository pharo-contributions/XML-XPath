Extension { #name : #XPathASTNamespaceTestForNamespaceURIAndLocalNameNode }

{ #category : #'*XPath-Inspector' }
XPathASTNamespaceTestForNamespaceURIAndLocalNameNode >> printTreeViewLabelOn: aStream [

	super printTreeViewLabelOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll:
			(self localName expandWithXMLNamespaceURI: self namespaceURI);
		nextPut: $)
]
