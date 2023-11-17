Extension { #name : #XPathASTUnaryOperatorExpressionNode }

{ #category : #'*XPath-Inspector' }
XPathASTUnaryOperatorExpressionNode >> printTreeViewLabelOn: aStream [

	super printTreeViewLabelOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self operatorName;
		nextPut: $)
]
