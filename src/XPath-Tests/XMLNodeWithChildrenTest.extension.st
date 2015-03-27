Extension { #name : #XMLNodeWithChildrenTest }

{ #category : #'*XPath-Tests' }
XMLNodeWithChildrenTest >> testDocumentRoot [
	| nodeWithNodes |

	super testDocumentRoot.

	nodeWithNodes := self newNodeWithNodes.
	nodeWithNodes allNodesDo: [:each |
		self assert: each documentRoot == nodeWithNodes].
]
