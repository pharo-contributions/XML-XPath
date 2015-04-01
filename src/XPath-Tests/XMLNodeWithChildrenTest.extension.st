Extension { #name : #XMLNodeWithChildrenTest }

{ #category : #'*XPath-Tests' }
XMLNodeWithChildrenTest >> testAllNodesReverseDo [
	| nodeWithNodes |

	super testAllNodesReverseDo.
	nodeWithNodes := self newNodeWithNodes.
	self
		should: [:block | nodeWithNodes allNodesReverseDo: block]
		enumerate: nodeWithNodes allNodes reversed.
]

{ #category : #'*XPath-Tests' }
XMLNodeWithChildrenTest >> testDocumentRoot [
	| nodeWithNodes |

	super testDocumentRoot.

	nodeWithNodes := self newNodeWithNodes.
	nodeWithNodes allNodesDo: [:each |
		self assert: each documentRoot == nodeWithNodes].
]

{ #category : #'*XPath-Tests' }
XMLNodeWithChildrenTest >> testLastAncestorOrSelfInNode [
	| nodeWithNodes |

	super testLastAncestorOrSelfInNode.

	nodeWithNodes := self newNodeWithNodes.
	nodeWithNodes nodesDo: [:node |
		self assert: (node lastAncestorOrSelfInNode: nodeWithNodes) = node.
		node descendentNodesDo: [:each | | ancestors |
			ancestors := each ancestorNodes.
			self assert:
				(each lastAncestorOrSelfInNode: nodeWithNodes) =
					(ancestors at: ancestors size - 1)]].
]

{ #category : #'*XPath-Tests' }
XMLNodeWithChildrenTest >> testOccursInDocumentBeforeNode [
	| nodeWithNodes before |

	super testOccursInDocumentBeforeNode.

	nodeWithNodes := self newNodeWithNodes.
	before := OrderedCollection new.
	nodeWithNodes allNodesDo: [:node |
		before do: [:each |
			self
				assert: (each occursInDocumentBeforeNode: node);
				deny: (node occursInDocumentBeforeNode: each)].
		before addLast: node].
]
