Extension { #name : #XPathASTNodeWithOtherExpression }

{ #category : #'*XPath-Inspector' }
XPathASTNodeWithOtherExpression >> treeViewChildren [

	^ Array with: self expression with: self otherExpression
]
