Extension { #name : #XPathASTFilterExpressionLocationPathNode }

{ #category : #'*XPath-Inspector' }
XPathASTFilterExpressionLocationPathNode >> treeViewChildren [

	^ self hasSteps
		  ifTrue: [ self steps copyWithFirst: self expression ]
		  ifFalse: [ super treeViewChildren ]
]
