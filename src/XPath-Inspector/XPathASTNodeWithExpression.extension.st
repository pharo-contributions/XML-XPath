Extension { #name : #XPathASTNodeWithExpression }

{ #category : #'*XPath-Inspector' }
XPathASTNodeWithExpression >> supportsTreeView [

	^ true
]

{ #category : #'*XPath-Inspector' }
XPathASTNodeWithExpression >> treeViewChildren [

	^ Array with: self expression
]
