Extension { #name : #XMLNodeWithChildrenTest }

{ #category : #'*XPath-Tests' }
XMLNodeWithChildrenTest >> testAllNodesReverseDo [
	| nodeWithNodes |

	super testAllNodesReverseDo.

	nodeWithNodes := self newNodeWithNodes.
	nodeWithNodes allNodesDo: [:each |
		self
			should: [:block | each allNodesReverseDo: block]
			enumerate:
				(each hasChildren
					ifTrue: [each allNodes reversed]
					ifFalse: [Array with: each])].
]

{ #category : #'*XPath-Tests' }
XMLNodeWithChildrenTest >> testFollowingNodesDo [
	| nodeWithNodes |

	super testFollowingNodesDo.

	nodeWithNodes := self newNodeWithNodes.
	nodeWithNodes allNodesDo: [:each |
		self
			should: [:block | each followingNodesDo: block]
			enumerate:
				(each hasParent
					ifTrue: [
						each parent descendantNodes copyAfter:
							(each hasChildren
								ifTrue: [each descendantNodes last]
								ifFalse: [each])]
					ifFalse: [#()])].
]

{ #category : #'*XPath-Tests' }
XMLNodeWithChildrenTest >> testFollowingSiblingNodesDo [
	| nodeWithNodes |

	super testFollowingSiblingNodesDo.

	nodeWithNodes := self newNodeWithNodes.
	nodeWithNodes allNodesDo: [:each |
		self
			should: [:block | each followingSiblingNodesDo: block]
			enumerate:
				(each hasParent
					ifTrue: [each parent nodes copyAfter: each]
					ifFalse: [#()])].
]

{ #category : #'*XPath-Tests' }
XMLNodeWithChildrenTest >> testPrecedingNodesDo [
	| nodeWithNodes |

	super testPrecedingNodesDo.

	nodeWithNodes := self newNodeWithNodes.
	nodeWithNodes allNodesDo: [:each |
		self
			should: [:block | each precedingNodesDo: block]
			enumerate:
				(each hasParent
					ifTrue: [(each parent descendantNodes copyUpTo: each) reversed]
					ifFalse: [#()])].
]

{ #category : #'*XPath-Tests' }
XMLNodeWithChildrenTest >> testPrecedingSiblingNodesDo [
	| nodeWithNodes |

	super testPrecedingSiblingNodesDo.

	nodeWithNodes := self newNodeWithNodes.
	nodeWithNodes allNodesDo: [:each |
		self
			should: [:block | each precedingSiblingNodesDo: block]
			enumerate:
				(each hasParent
					ifTrue: [(each parent nodes copyUpTo: each) reversed]
					ifFalse: [#()])].
]
