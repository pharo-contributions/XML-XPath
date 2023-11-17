Extension { #name : #XPathASTLocationPathNode }

{ #category : #'*XPath-Inspector' }
XPathASTLocationPathNode >> supportsTreeView [

	^ self hasSteps
]

{ #category : #'*XPath-Inspector' }
XPathASTLocationPathNode >> treeViewChildren [

	^ self steps
]
