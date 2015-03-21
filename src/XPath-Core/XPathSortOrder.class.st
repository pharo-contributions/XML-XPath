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
	self documentOrderOn: aNodeSet do: [:each | | oldSize |
		oldSize := copy size.
		self
			ancestorsOfNode: each
			select: aNodeTestBlock
			into: copy.

		"ancestors are added in reverse document order, so if more than one was
		added, reverse them in place to keep copy in document order"
		(copy size - oldSize) > 1
			ifTrue: [
				copy
					reverseInPlaceFrom: oldSize + 1
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
	self documentOrderOn: aNodeSet do: [:each | | oldSize |
		oldSize := copy size.
		(copy includes: each)
			ifFalse: [
				(aNodeTestBlock value: each)
					ifTrue: [copy addLast: each].
				self
					ancestorsOfNode: each
					select: aNodeTestBlock
					into: copy].

		"nodes and ancestors are added in reverse document order, so if more
		than one was added, reverse them in place to keep copy in document order"
		(copy size - oldSize) > 1
			ifTrue: [
				copy
					reverseInPlaceFrom: oldSize + 1
					to: copy size]].

	^ copy
		reverseInPlace;
		sortOrder: XPathReverseDocumentSortOrder new.
]

{ #category : #private }
XPathSortOrder >> ancestorsOfNode: aNode select: aNodeTestBlock into: aNodeSet [
	aNode ancestorNodesDo: [:each |
		(aNodeSet includes: each)
			ifTrue: [^ self].
		(aNodeTestBlock value: each)
			ifTrue: [aNodeSet addLast: each]]
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
	| copy nextParentIndex |

	copy := aNodeSet copyEmpty.
	nextParentIndex :=
		self
			documentOrderOn: aNodeSet
			indexOfNextParentAfterIndex: 0.
	[nextParentIndex isNil]
		whileFalse: [
			nextParentIndex :=
				self
					childrenOfNodeAt: nextParentIndex
					from: aNodeSet
					select: aNodeTestBlock
					into: copy].
	^ copy sortOrder: XPathDocumentSortOrder new.
]

{ #category : #private }
XPathSortOrder >> childrenOfNodeAt: anIndex from: anOldNodeSet select: aNodeTestBlock into: aNewNodeSet [
	| parent indexOfNextParent ancestorOfNextChildren |

	parent := anOldNodeSet at: anIndex.
	indexOfNextParent :=
		self
			documentOrderOn: anOldNodeSet
			indexOfNextParentAfterIndex: anIndex.
	indexOfNextParent
		ifNotNil: [
			ancestorOfNextChildren :=
				(anOldNodeSet at: indexOfNextParent)
					ancestorOrSelfChildOfParent: parent].
	parent nodesDo: [:each |
		(aNodeTestBlock value: each)
			ifTrue: [aNewNodeSet addLast: each].
		(ancestorOfNextChildren notNil
			and: [each = ancestorOfNextChildren])
			ifTrue: [
				indexOfNextParent :=
					self
						childrenOfNodeAt: indexOfNextParent
						from: anOldNodeSet
						select: aNodeTestBlock
						into: aNewNodeSet.
				indexOfNextParent
					ifNil: [ancestorOfNextChildren := nil]
					ifNotNil: [
						ancestorOfNextChildren :=
							(anOldNodeSet at: indexOfNextParent)
								ancestorOrSelfChildOfParent: parent]]].
	^ indexOfNextParent.
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
		self
			descendantsOfNode: each
			select: aNodeTestBlock
			into: copy].
	^ copy sortOrder: XPathDocumentSortOrder new.
]

{ #category : #enumerating }
XPathSortOrder >> descendantOrSelfAxisOn: aNodeSet select: aNodeTestBlock [
	| copy |

	copy := aNodeSet copyEmpty.
	self documentOrderOn: aNodeSet do: [:each |
		(copy includes: each)
			ifFalse: [
				(aNodeTestBlock value: each)
					ifTrue: [copy addLast: each].
				self
					descendantsOfNode: each
					select: aNodeTestBlock
					into: copy]].
	^ copy sortOrder: XPathDocumentSortOrder new.
]

{ #category : #private }
XPathSortOrder >> descendantsOfNode: aNode select: aNodeTestBlock into: aNodeSet [
	aNode descendentNodesDo: [:each |
		(aNodeSet includes: each)
			ifTrue: [^ self].
		(aNodeTestBlock value: each)
			ifTrue: [aNodeSet addLast: each]]
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
	self documentOrderOn: aNodeSet do: [:each |
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
	"parent axis is a forward axis, according to spec"
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
	self reverseDocumentOrderOn: aNodeSet do: [:each |
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
	self reverseDocumentOrderOn: aNodeSet do: [:each |
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
