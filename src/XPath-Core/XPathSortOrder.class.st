"
Abstract class for node sort orders to keep track of the order of nodes in a node set. Instances of subclasses are immutable and shared.
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
			ancestorNodesOf: each
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

{ #category : #private }
XPathSortOrder >> ancestorNodesOf: aNode select: aNodeTestBlock into: aNodeSet [
	aNode ancestorNodesDo: [:each |
		(aNodeSet includes: each)
			ifTrue: [^ self].
		(aNodeTestBlock value: each)
			ifTrue: [aNodeSet addLast: each]]
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
					ancestorNodesOf: each
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
	| copy readStream |

	copy := aNodeSet copyEmpty.
	readStream := self documentOrderReadStreamOn: aNodeSet.
	[readStream atEnd]
		whileFalse: [
			self
				nodesOfNextFrom: readStream
				select: aNodeTestBlock
				into: copy].
	^ copy sortOrder: XPathDocumentSortOrder new.
]

{ #category : #enumerating }
XPathSortOrder >> descendantAxisOn: aNodeSet select: aNodeTestBlock [
	| copy readStream |

	copy := aNodeSet copyEmpty.
	readStream := self documentOrderReadStreamOn: aNodeSet.
	[readStream atEnd]
		whileFalse: [
			self
				descendentNodesOfNextFrom: readStream
				select: aNodeTestBlock
				into: copy].
	^ copy sortOrder: XPathDocumentSortOrder new.
]

{ #category : #enumerating }
XPathSortOrder >> descendantOrSelfAxisOn: aNodeSet select: aNodeTestBlock [
	| copy readStream |

	copy := aNodeSet copyEmpty.
	readStream := self documentOrderReadStreamOn: aNodeSet.
	[readStream atEnd]
		whileFalse: [
			(aNodeTestBlock value: readStream peek)
				ifTrue: [copy addLast:  readStream peek].
			self
				descendentNodesOfNextFrom: readStream
				select: aNodeTestBlock
				into: copy].
	^ copy sortOrder: XPathDocumentSortOrder new
]

{ #category : #private }
XPathSortOrder >> descendentNodesOfNextFrom: aDocumentOrderStream select: aNodeTestBlock into: aNodeSet [
	aDocumentOrderStream next descendentNodesDo: [:each |
		(aNodeTestBlock value: each)
			ifTrue: [aNodeSet add: each].
		[aDocumentOrderStream atEnd not
			and: [aDocumentOrderStream peek = each]]
			whileTrue: [aDocumentOrderStream next]]
]

{ #category : #private }
XPathSortOrder >> documentOrderOn: aNodeSet do: aBlock [
	self subclassResponsibility
]

{ #category : #private }
XPathSortOrder >> documentOrderReadStreamOn: aNodeSet [
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
	| copy readStream |

	copy := aNodeSet copyEmpty.
	readStream := self documentOrderReadStreamOn: aNodeSet.
	[readStream atEnd]
		whileFalse: [
			self
				followingNodesOfNextFrom: readStream
				select: aNodeTestBlock
				into: copy].
	^ copy sortOrder: XPathDocumentSortOrder new.
]

{ #category : #private }
XPathSortOrder >> followingNodesOfNextFrom: aDocumentOrderStream select: aNodeTestBlock into: aNodeSet [
	| node nextNodeAncestorOrSelf |

	node := aDocumentOrderStream next.
	"to keep document order, descendants of node with following nodes that need to be
	enumerated are handled first and then node's following nodes after"
	[aDocumentOrderStream atEnd or: [
		(nextNodeAncestorOrSelf :=
			aDocumentOrderStream peek lastAncestorOrSelfIn: node) isNil]]
		whileFalse: [
			self
				followingNodesOfNextFrom: aDocumentOrderStream
				select: aNodeTestBlock
				into: aNodeSet.
			nextNodeAncestorOrSelf := nil].

	node followingNodesDo: [:each |
		(aNodeTestBlock value: each)
			ifTrue: [aNodeSet add: each].
		[aDocumentOrderStream atEnd not
			and: [aDocumentOrderStream peek = each]]
			whileTrue: [aDocumentOrderStream next]].
]

{ #category : #enumerating }
XPathSortOrder >> followingSiblingAxisOn: aNodeSet select: aNodeTestBlock [
	| copy readStream |

	copy := aNodeSet copyEmpty.
	readStream := self documentOrderReadStreamOn: aNodeSet.
	[readStream atEnd]
		whileFalse: [
			self
				followingSiblingNodesOfNextFrom: readStream
				select: aNodeTestBlock
				into: copy].
	^ copy sortOrder: XPathDocumentSortOrder new.
]

{ #category : #private }
XPathSortOrder >> followingSiblingNodesOfNextFrom: aDocumentOrderStream select: aNodeTestBlock into: aNodeSet [
	| node nextNodeAncestorOrSelf |

	node := aDocumentOrderStream next.
	"to keep document order, descendants of node with siblings that need to be
	enumerated are handled first and then node's siblings after"
	[aDocumentOrderStream atEnd or: [
		(nextNodeAncestorOrSelf :=
			aDocumentOrderStream peek lastAncestorOrSelfIn: node) isNil]]
		whileFalse: [
			self
				followingSiblingNodesOfNextFrom: aDocumentOrderStream
				select: aNodeTestBlock
				into: aNodeSet.
			nextNodeAncestorOrSelf := nil].

	(aDocumentOrderStream atEnd or: [node hasParent not])
		ifFalse: [
			nextNodeAncestorOrSelf :=
				aDocumentOrderStream peek lastAncestorOrSelfIn: node parent].
	node followingSiblingNodesDo: [:each |
		(aNodeTestBlock value: each)
			ifTrue: [aNodeSet add: each].
		[nextNodeAncestorOrSelf = each]
			whileTrue: [
				nextNodeAncestorOrSelf = aDocumentOrderStream peek
					ifTrue: [aDocumentOrderStream next]
					ifFalse: [
						self
							followingSiblingNodesOfNextFrom: aDocumentOrderStream
							select: aNodeTestBlock
							into: aNodeSet].
				(aDocumentOrderStream atEnd or: [node hasParent not])
					ifTrue: [nextNodeAncestorOrSelf := nil]
					ifFalse: [
						nextNodeAncestorOrSelf :=
							aDocumentOrderStream peek lastAncestorOrSelfIn:
								node parent]]].
]

{ #category : #private }
XPathSortOrder >> levelOrderChildAxisOn: aNodeSet select: aNodeTestBlock [
	| copy |

	copy := aNodeSet copyEmpty.
	self documentOrderOn: aNodeSet do: [:node |
		node hasChildren
			ifTrue: [
				node nodesDo: [:each |
					(aNodeTestBlock value: each)
						ifTrue: [copy addLast: each]]]].
	"still in level order"
	^ copy sortOrder: XPathLevelDocumentSortOrder new.
]

{ #category : #private }
XPathSortOrder >> levelOrderDescendantAxisOn: aNodeSet select: aNodeTestBlock [
	| copy |

	copy := aNodeSet copyEmpty.
	self documentOrderOn: aNodeSet do: [:node |
		node descendentNodesDo: [:each |
			(aNodeTestBlock value: each)
				ifTrue: [copy addLast: each]]].
	^ copy sortOrder: XPathDocumentSortOrder new.
]

{ #category : #private }
XPathSortOrder >> levelOrderDescendantOrSelfAxisOn: aNodeSet select: aNodeTestBlock [
	| copy |

	copy := aNodeSet copyEmpty.
	self documentOrderOn: aNodeSet do: [:node |
		node allNodesDo: [:each |
			(aNodeTestBlock value: each)
				ifTrue: [copy addLast: each]]].
	^ copy sortOrder: XPathDocumentSortOrder new.
]

{ #category : #private }
XPathSortOrder >> levelOrderFollowingAxisOn: aNodeSet select: aNodeTestBlock [
	| copy |

	copy := aNodeSet copyEmpty.
	self documentOrderOn: aNodeSet do: [:node | | lastParentAddedFrom |
		(lastParentAddedFrom notNil
			and: [node parent = lastParentAddedFrom])
			ifFalse: [
				node followingNodesDo: [:each | 
					(aNodeTestBlock value: each)
						ifTrue: [copy addLast: each]].
				lastParentAddedFrom := node parent]].
	"not in level order anymore"
	^ copy sortOrder: XPathDocumentSortOrder new.
]

{ #category : #private }
XPathSortOrder >> levelOrderFollowingSiblingAxisOn: aNodeSet select: aNodeTestBlock [
	| copy |

	copy := aNodeSet copyEmpty.
	self documentOrderOn: aNodeSet do: [:node | | lastParentAddedFrom |
		(lastParentAddedFrom notNil
			and: [node parent = lastParentAddedFrom])
			ifFalse: [
				node followingSiblingNodesDo: [:each |
					(aNodeTestBlock value: each)
						ifTrue: [copy addLast: each]].
				lastParentAddedFrom := node parent]].
	"still in level order"
	^ copy sortOrder: XPathLevelDocumentSortOrder new.
]

{ #category : #private }
XPathSortOrder >> levelOrderParentAxisOn: aNodeSet select: aNodeTestBlock [
	| copy |

	copy := aNodeSet copyEmpty.
	"parent axis is a forward axis, according to spec"
	self documentOrderOn: aNodeSet do: [:each | | parent lastParentVisited |
		each hasParent
			ifTrue: [
				parent := each parent.
				(parent ~= lastParentVisited
					and: [aNodeTestBlock value: parent])
						ifTrue: [copy addLast: parent].
				lastParentVisited := parent]].
	"still in level order"
	^ copy sortOrder: XPathLevelDocumentSortOrder new.
]

{ #category : #private }
XPathSortOrder >> levelOrderPrecedingAxisOn: aNodeSet select: aNodeTestBlock [
	| copy |

	copy := aNodeSet copyEmpty.
	self reverseDocumentOrderOn: aNodeSet do: [:node | | lastParentAddedFrom |
		(lastParentAddedFrom notNil
			and: [node parent = lastParentAddedFrom])
			ifFalse: [
				node precedingNodesDo: [:each | 
					(aNodeTestBlock value: each)
						ifTrue: [copy addLast: each]].
				lastParentAddedFrom := node parent]].
	"not in level order anymore"
	^ copy sortOrder: XPathReverseDocumentSortOrder new.
]

{ #category : #private }
XPathSortOrder >> levelOrderPrecedingSiblingAxisOn: aNodeSet select: aNodeTestBlock [
	| copy |

	copy := aNodeSet copyEmpty.
	self reverseDocumentOrderOn: aNodeSet do: [:node | | lastParentAddedFrom |
		(lastParentAddedFrom notNil
			and: [node parent = lastParentAddedFrom])
			ifFalse: [
				node precedingSiblingNodesDo: [:each | 
					(aNodeTestBlock value: each)
						ifTrue: [copy addLast: each]].
				lastParentAddedFrom := node parent]].
	"still in level order"
	^ copy sortOrder: XPathLevelReverseDocumentSortOrder new.
]

{ #category : #private }
XPathSortOrder >> levelOrderSelfAxisOn: aNodeSet select: aNodeTestBlock [
	| copy |

	copy := aNodeSet copyEmpty.
	self documentOrderOn: aNodeSet do: [:each |
		(aNodeTestBlock value: each)
			ifTrue: [copy addLast: each]].
	"still in level order"
	^ copy sortOrder: XPathLevelDocumentSortOrder new.
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

{ #category : #private }
XPathSortOrder >> nodesOfNextFrom: aDocumentOrderStream select: aNodeTestBlock into: aNodeSet [
	| node nextNodeAncestorOrSelf |

	(node := aDocumentOrderStream next) hasChildren
		ifFalse: [^ self].

	aDocumentOrderStream atEnd
		ifFalse: [
			nextNodeAncestorOrSelf :=
				aDocumentOrderStream peek lastAncestorOrSelfIn: node].

	node nodesDo: [:each |
		(aNodeTestBlock value: each)
			ifTrue: [aNodeSet addLast: each].
		[each = nextNodeAncestorOrSelf]
			whileTrue: [
				self
					nodesOfNextFrom: aDocumentOrderStream
					select: aNodeTestBlock
					into: aNodeSet.
				aDocumentOrderStream atEnd
					ifTrue: [nextNodeAncestorOrSelf := nil]
					ifFalse: [
						nextNodeAncestorOrSelf :=
							aDocumentOrderStream peek lastAncestorOrSelfIn: node]]].
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
	^ copy sortOrder: XPathDocumentSortOrder new.
]

{ #category : #enumerating }
XPathSortOrder >> precedingAxisOn: aNodeSet select: aNodeTestBlock [
	| copy readStream |

	copy := aNodeSet copyEmpty.
	readStream := self reverseDocumentOrderReadStreamOn: aNodeSet.
	[readStream atEnd]
		whileFalse: [
			self
				precedingNodesOfNextFrom: readStream
				select: aNodeTestBlock
				into: copy].
	^ copy sortOrder: XPathReverseDocumentSortOrder new.
]

{ #category : #private }
XPathSortOrder >> precedingNodesOfNextFrom: aReverseDocumentOrderStream select: aNodeTestBlock into: aNodeSet [
	aReverseDocumentOrderStream next precedingNodesDo: [:each |
		[aReverseDocumentOrderStream atEnd not
			and: [aReverseDocumentOrderStream peek = each]]
			whileTrue: [aReverseDocumentOrderStream next].
		(aNodeTestBlock value: each)
			ifTrue: [aNodeSet add: each]]
]

{ #category : #enumerating }
XPathSortOrder >> precedingSiblingAxisOn: aNodeSet select: aNodeTestBlock [
	| copy readStream |

	copy := aNodeSet copyEmpty.
	readStream := self reverseDocumentOrderReadStreamOn: aNodeSet.
	[readStream atEnd]
		whileFalse: [
			self
				precedingSiblingNodesOfNextFrom: readStream
				select: aNodeTestBlock
				into: copy].
	^ copy sortOrder: XPathReverseDocumentSortOrder new.
]

{ #category : #private }
XPathSortOrder >> precedingSiblingNodesOfNextFrom: aReverseDocumentOrderStream select: aNodeTestBlock into: aNodeSet [
	| node nextNodeAncestorOrSelf |

	node := aReverseDocumentOrderStream next.
	(aReverseDocumentOrderStream atEnd or: [node hasParent not])
		ifFalse: [
			nextNodeAncestorOrSelf :=
				aReverseDocumentOrderStream peek lastAncestorOrSelfIn:
					node parent].

	node precedingSiblingNodesDo: [:each |
		[nextNodeAncestorOrSelf = each]
			whileTrue: [
				nextNodeAncestorOrSelf = aReverseDocumentOrderStream peek
					ifTrue: [aReverseDocumentOrderStream next]
					ifFalse: [
						self
							precedingSiblingNodesOfNextFrom: aReverseDocumentOrderStream
							select: aNodeTestBlock
							into: aNodeSet].
				(aReverseDocumentOrderStream atEnd or: [node hasParent not])
					ifTrue: [nextNodeAncestorOrSelf := nil]
					ifFalse: [
						nextNodeAncestorOrSelf :=
							aReverseDocumentOrderStream peek lastAncestorOrSelfIn:
								node parent]].
		(aNodeTestBlock value: each)
			ifTrue: [aNodeSet add: each]].
]

{ #category : #private }
XPathSortOrder >> reverseDocumentOrderOn: aNodeSet do: aBlock [
	self subclassResponsibility
]

{ #category : #private }
XPathSortOrder >> reverseDocumentOrderReadStreamOn: aNodeSet [
	self subclassResponsibility
]

{ #category : #enumerating }
XPathSortOrder >> selfAxisOn: aNodeSet select: aNodeTestBlock [
	| copy |

	copy := aNodeSet copyEmpty.
	self documentOrderOn: aNodeSet do: [:each |
		(aNodeTestBlock value: each)
			ifTrue: [copy addLast: each]].
	^ copy sortOrder: XPathDocumentSortOrder new.
]
