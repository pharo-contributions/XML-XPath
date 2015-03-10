"
Abstract class for node sort orders. Instances are immutable and shared.
"
Class {
	#name : #XPathSortOrder,
	#superclass : #Object,
	#classInstVars : [
		'instance'
	],
	#category : #'XPath-Core-DOM'
}

{ #category : #'instance creation' }
XPathSortOrder class >> new [
	"these classes are immutable and shared, so they are only initialized once"
	^ instance ifNil: [instance := self basicNew initialize]
]

{ #category : #enumerating }
XPathSortOrder >> ancestorAxisOn: aNodeSet select: aNodeTestBlock [
	| copy |

	"copy will contain the list of ancestors in document order which is then
	reversed to get a list of ancestors in reverse document order"
	copy := aNodeSet copyEmpty.
	self documentOrderOn: aNodeSet do: [:each | | totalAdded ancestor |
		totalAdded := 0.
		ancestor := each parent.
		[ancestor isNil
			or: [copy includes: ancestor]]
			whileFalse: [
				(aNodeTestBlock value: ancestor)
					ifTrue: [
						copy addLast: ancestor.
						totalAdded := totalAdded + 1].
				ancestor := ancestor parent].

		"ancestors are added in reverse document order, so if more than one was
		added, reverse them in place to keep copy in document order"
		totalAdded > 1
			ifTrue: [
				copy
					reverseInPlaceFrom: (copy size - totalAdded) + 1
					to: copy size]].

	^ copy
		reverseInPlace;
		sortOrder: XPathReverseDocumentSortOrder new.
]

{ #category : #enumerating }
XPathSortOrder >> ancestorOrSelfAxisOn: aNodeSet select: aNodeTestBlock [
	| copy |

	"copy will contain the list of nodes and ancestors in document order which
	is then reversed to get a list of nodes and ancestors in reverse document order"
	copy := aNodeSet copyEmpty.
	self documentOrderOn: aNodeSet do: [:each | | totalAdded ancestorOrSelf |
		totalAdded := 0.
		ancestorOrSelf := each.
		[ancestorOrSelf isNil
			or: [copy includes: ancestorOrSelf]]
			whileFalse: [
				(aNodeTestBlock value: ancestorOrSelf)
					ifTrue: [
						copy addLast: ancestorOrSelf.
						totalAdded := totalAdded + 1].
				ancestorOrSelf := ancestorOrSelf parent].

		"nodes and ancestors are added in reverse document order, so if more
		than one was added, reverse them in place to keep copy in document order"
		totalAdded > 1
			ifTrue: [
				copy
					reverseInPlaceFrom: (copy size - totalAdded) + 1
					to: copy size]].

	^ copy
		reverseInPlace;
		sortOrder: XPathReverseDocumentSortOrder new.
]

{ #category : #converting }
XPathSortOrder >> asDocumentSortOrder [
	^ XPathDocumentSortOrder new
]

{ #category : #enumerating }
XPathSortOrder >> attributeAxisOn: aNodeSet select: aNodeTestBlock [
	| copy |

	copy := aNodeSet copyEmpty.
	self documentOrderOn: aNodeSet do: [:each |
		(each isElement
			and: [each hasAttributes])
			ifTrue: [
				each attributeNodesDo: [:attribute |
					(aNodeTestBlock value: attribute)
						ifTrue: [copy addLast: attribute]]]].
	^ copy sortOrder: XPathElementMetaNodeDocumentSortOrder new.
]

{ #category : #enumerating }
XPathSortOrder >> childAxisOn: aNodeSet select: aNodeTestBlock [
	| copy parents |

	copy := aNodeSet copyEmpty.
	parents := OrderedCollection new.
	self documentOrderOn: aNodeSet do: [:each |
		each hasChildren
			ifTrue: [parents addLast: each]].
	[parents isEmpty]
		whileFalse: [
			self
				childrenOfNextParentFrom: parents
				select: aNodeTestBlock
				into: copy].
	^ copy sortOrder: XPathDocumentSortOrder new.
]

{ #category : #private }
XPathSortOrder >> childrenOfNextParentFrom: aParentCollection select: aNodeTestBlock into: aNodeSet [
	| parent ancestorOfNextChildrenInParent |

	parent := aParentCollection removeFirst.
	aParentCollection isEmpty
		ifFalse: [
			ancestorOfNextChildrenInParent :=
				aParentCollection first
					lastAncestorOfChildrenIn: parent].
	parent nodesDo: [:each |
		(aNodeTestBlock value: each)
			ifTrue: [aNodeSet addLast: each].
		ancestorOfNextChildrenInParent
			ifNotNil: [
				each = ancestorOfNextChildrenInParent
					ifTrue: [
						self
							childrenOfNextParentFrom: aParentCollection
							select: aNodeTestBlock
							into: aNodeSet.
						aParentCollection isEmpty
							ifFalse: [
								ancestorOfNextChildrenInParent :=
									aParentCollection first
										lastAncestorOfChildrenIn: parent]]]].
]

{ #category : #copying }
XPathSortOrder >> copy [
	"instances are immutable and shared"
	^ self
]

{ #category : #enumerating }
XPathSortOrder >> descendantAxisOn: aNodeSet select: aNodeTestBlock [
	| copy |

	copy := aNodeSet copyEmpty.
	self documentOrderOn: aNodeSet do: [:each |
		each descendentNodesDetect: [:descendant |
			(copy includes: descendant)
				ifTrue: [true]
				ifFalse: [
					(aNodeTestBlock value: descendant)
						ifTrue: [copy addLast: descendant].
					false]]].
	^ copy sortOrder: XPathDocumentSortOrder new.
]

{ #category : #enumerating }
XPathSortOrder >> descendantOrSelfAxisOn: aNodeSet select: aNodeTestBlock [
	| copy |

	copy := aNodeSet copyEmpty.
	self documentOrderOn: aNodeSet do: [:each |
		each allNodesDetect: [:descendant |
			(copy includes: descendant)
				ifTrue: [true]
				ifFalse: [
					(aNodeTestBlock value: descendant)
						ifTrue: [copy addLast: descendant].
					false]]].
	^ copy sortOrder: XPathDocumentSortOrder new.
]

{ #category : #private }
XPathSortOrder >> documentOrderOn: aNodeSet do: aBlock [
	self subclassResponsibility
]

{ #category : #sorting }
XPathSortOrder >> documentOrderSort: aNodeSet [
	self subclassResponsibility
]

{ #category : #accessing }
XPathSortOrder >> firstInDocumentOrderFrom: aNodeSet [
	self subclassResponsibility
]

{ #category : #enumerating }
XPathSortOrder >> followingAxisOn: aNodeSet select: aNodeTestBlock [
	| copy |

	copy := aNodeSet copyEmpty.
	aNodeSet documentOrderOn: aNodeSet do: [:each |
		(copy includes: each)
			ifFalse: [
				each followingNodesDo: [:followingNode |
					(aNodeTestBlock value: followingNode)
						ifTrue: [copy addLast: followingNode]]]].
	^ copy sort.

]

{ #category : #enumerating }
XPathSortOrder >> followingSiblingAxisOn: aNodeSet select: aNodeTestBlock [
	| copy |

	copy := aNodeSet copyEmpty.
	self documentOrderOn: aNodeSet do: [:each |
		(copy includes: each)
			ifFalse: [
				each followingSiblingNodesDo: [:sibling |
					(aNodeTestBlock value: sibling)
						ifTrue: [copy addLast: sibling]]]].
	^ copy sort.
]

{ #category : #private }
XPathSortOrder >> levelOrderChildAxisOn: aNodeSet select: aNodeTestBlock [
	| copy |

	copy := aNodeSet copyEmpty.
	self documentOrderOn: aNodeSet do: [:each |
		each hasChildren
			ifTrue: [
				each nodesDo: [:node |
					(aNodeTestBlock value: node)
						ifTrue: [copy addLast: node]]]].
	^ copy sortOrder: XPathLevelDocumentSortOrder new.
]

{ #category : #private }
XPathSortOrder >> levelOrderFollowingAxisOn: aNodeSet select: aNodeTestBlock [
	| copy |

	copy := aNodeSet copyEmpty.
	self documentOrderOn: aNodeSet do: [:each | | lastParentAddedFrom |
		(lastParentAddedFrom notNil
			and: [each parent = lastParentAddedFrom])
			ifFalse: [
				each followingNodesDo: [:sibling | 
					(aNodeTestBlock value: sibling)
						ifTrue: [copy addLast: sibling]].
				lastParentAddedFrom := each]].
	^ copy sortOrder: XPathDocumentSortOrder new.
]

{ #category : #private }
XPathSortOrder >> levelOrderFollowingSiblingAxisOn: aNodeSet select: aNodeTestBlock [
	| copy |

	copy := aNodeSet copyEmpty.
	self documentOrderOn: aNodeSet do: [:each | | lastParentAddedFrom |
		(lastParentAddedFrom notNil
			and: [each parent = lastParentAddedFrom])
			ifFalse: [
				each followingSiblingNodesDo: [:sibling | 
					(aNodeTestBlock value: sibling)
						ifTrue: [copy addLast: sibling]].
				lastParentAddedFrom := each]].
	^ copy sortOrder: XPathLevelDocumentSortOrder new.
]

{ #category : #private }
XPathSortOrder >> levelOrderPrecedingAxisOn: aNodeSet select: aNodeTestBlock [
	| copy |

	copy := aNodeSet copyEmpty.
	self reverseDocumentOrderOn: aNodeSet do: [:each | | lastParentAddedFrom |
		(lastParentAddedFrom notNil
			and: [each parent = lastParentAddedFrom])
			ifFalse: [
				each precedingNodesDo: [:sibling | 
					(aNodeTestBlock value: sibling)
						ifTrue: [copy addLast: sibling]].
				lastParentAddedFrom := each]].
	^ copy sortOrder: XPathReverseDocumentSortOrder new.
]

{ #category : #private }
XPathSortOrder >> levelOrderPrecedingSiblingAxisOn: aNodeSet select: aNodeTestBlock [
	| copy |

	copy := aNodeSet copyEmpty.
	self reverseDocumentOrderOn: aNodeSet do: [:each | | lastParentAddedFrom |
		(lastParentAddedFrom notNil
			and: [each parent = lastParentAddedFrom])
			ifFalse: [
				each precedingSiblingNodesDo: [:sibling | 
					(aNodeTestBlock value: sibling)
						ifTrue: [copy addLast: sibling]].
				lastParentAddedFrom := each]].
	^ copy sortOrder: XPathLevelReverseDocumentSortOrder new.
]

{ #category : #enumerating }
XPathSortOrder >> namespaceAxisOn: aNodeSet select: aNodeTestBlock [
	| copy |

	copy := aNodeSet copyEmpty.
	self documentOrderOn: aNodeSet do: [:each |
		(each isElement
			and: [each hasNamespaceNodes])
			ifTrue: [
				each namespaceNodesDo: [:namespace |
					(aNodeTestBlock value: namespace)
						ifTrue: [copy addLast: namespace]]]].
	^ copy sortOrder: XPathElementMetaNodeDocumentSortOrder new.
]

{ #category : #enumerating }
XPathSortOrder >> parentAxisOn: aNodeSet select: aNodeTestBlock [
	| copy |

	copy := aNodeSet copyEmpty.
	self documentOrderOn: aNodeSet do: [:each | | parent |
		(each hasParent
			and: [(copy includes: (parent := each parent)) not
				and: [aNodeTestBlock value: parent]])
			ifTrue: [copy addLast: parent]].
	^ copy sortOrder: self asDocumentSortOrder.
]

{ #category : #enumerating }
XPathSortOrder >> precedingAxisOn: aNodeSet select: aNodeTestBlock [
	| copy |

	copy := aNodeSet copyEmpty.
	aNodeSet reverseDocumentOrderOn: aNodeSet do: [:each |
		(copy includes: each)
			ifFalse: [
				each precedingNodesDo: [:precedingNode |
					(aNodeTestBlock value: precedingNode)
						ifTrue: [copy addLast: precedingNode]]]].
	^ copy reverseSort.
]

{ #category : #enumerating }
XPathSortOrder >> precedingSiblingAxisOn: aNodeSet select: aNodeTestBlock [
	| copy |

	copy := aNodeSet copyEmpty.
	aNodeSet reverseDocumentOrderOn: aNodeSet do: [:each |
		(copy includes: each)
			ifFalse: [
				each precedingSiblingNodesDo: [:sibling |
					(aNodeTestBlock value: sibling)
						ifTrue: [copy addLast: sibling]]]].
	^ copy reverseSort.
]

{ #category : #private }
XPathSortOrder >> reverseDocumentOrderOn: aNodeSet do: aBlock [
	self subclassResponsibility
]

{ #category : #sorting }
XPathSortOrder >> reverseDocumentOrderSort: aNodeSet [
	self subclassResponsibility
]

{ #category : #enumerating }
XPathSortOrder >> selfAxisOn: aNodeSet select: aNodeTestBlock [
	| copy |

	copy := aNodeSet copyEmpty.
	self documentOrderOn: aNodeSet do: [:each |
		(aNodeTestBlock value: each)
			ifTrue: [copy addLast: each]].
	^ copy sortOrder: self asDocumentSortOrder.
]
