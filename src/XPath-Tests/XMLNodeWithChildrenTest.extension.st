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
						each parent descendentNodes copyAfter:
							(each hasChildren
								ifTrue: [each descendentNodes last]
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
		self deny: (node occursInDocumentBeforeNode: node).
		before do: [:each |
			self
				assert: (each occursInDocumentBeforeNode: node);
				deny: (node occursInDocumentBeforeNode: each)].
		before addLast: node.
		node isElement
			ifTrue: [
				node hasNamespaceNodes
					ifTrue: [
						node namespaceNodesDo: [:namespace |
							self deny: (namespace occursInDocumentBeforeNode: namespace).
							before do: [:each |
								self
									assert: (each occursInDocumentBeforeNode: namespace);
									deny: (namespace occursInDocumentBeforeNode: each)].
							before addLast: namespace]].
				node hasAttributes
					ifTrue: [
						node attributeNodesDo: [:attribute |
							self deny: (attribute occursInDocumentBeforeNode: attribute).
							before do: [:each |
								self
									assert: (each occursInDocumentBeforeNode: attribute);
									deny: (attribute occursInDocumentBeforeNode: each)].
							before addLast: attribute]]]].
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
					ifTrue: [(each parent descendentNodes copyUpTo: each) reversed]
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
