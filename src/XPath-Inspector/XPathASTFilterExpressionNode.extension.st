Extension { #name : #XPathASTFilterExpressionNode }

{ #category : #'*XPath-Inspector' }
XPathASTFilterExpressionNode >> treeViewChildren [

	^ self hasPredicates
		  ifTrue: [ self predicates copyWithFirst: self expression ]
		  ifFalse: [ super treeViewChildren ]
]
