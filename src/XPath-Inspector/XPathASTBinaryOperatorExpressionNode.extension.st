Extension { #name : #XPathASTBinaryOperatorExpressionNode }

{ #category : #'*XPath-Inspector' }
XPathASTBinaryOperatorExpressionNode >> printTreeViewLabelOn: aStream [

	super printTreeViewLabelOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self operatorName;
		nextPut: $)
]
