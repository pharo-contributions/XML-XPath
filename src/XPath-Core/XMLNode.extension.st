Extension { #name : #XMLNode }

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> % aNodeTestStringOrBlock [
	^ self parentAxis: aNodeTestStringOrBlock
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> %% aNodeTestStringOrBlock [
	^ self ancestorAxis: aNodeTestStringOrBlock
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> %%~ aNodeTestStringOrBlock [
	^ self ancestorOrSelfAxis: aNodeTestStringOrBlock
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> / aNodeTestStringOrBlock [
	^ self childAxis: aNodeTestStringOrBlock
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> // aNodeTestStringOrBlock [
	^ self descendantAxis: aNodeTestStringOrBlock
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> //~ aNodeTestStringOrBlock [
	^ self descendantOrSelfAxis: aNodeTestStringOrBlock
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> << aNodeTestStringOrBlock [
	^ self precedingAxis: aNodeTestStringOrBlock
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> <<< aNodeTestStringOrBlock [
	^ self precedingSiblingAxis: aNodeTestStringOrBlock
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> >> aNodeTestStringOrBlock [
	^ self followingAxis: aNodeTestStringOrBlock
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> >>> aNodeTestStringOrBlock [
	^ self followingSiblingAxis: aNodeTestStringOrBlock
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> @ aNodeTestStringOrBlock [
	^ self attributeAxis: aNodeTestStringOrBlock
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> @@ aNodeTestStringOrBlock [
	^ self namespaceAxis: aNodeTestStringOrBlock
]

{ #category : #'*XPath-Core-enumerating' }
XMLNode >> allNodesReverseDo: aBlock [
	aBlock value: self
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> ancestorAxis: aNodeTestStringOrBlock [
	^ (self
		ancestorAxisSelect: aNodeTestStringOrBlock asXPathNodeTest
		into: self nodeSetClass new)
			sortOrder: XPathReverseDocumentSortOrder new
]

{ #category : #'*XPath-Core-enumerating - predicate axis' }
XMLNode >> ancestorAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	(aPredicateCollection notEmpty
		and: [aPredicateCollection first isNumber])
		ifTrue: [
			^ (self
				ancestorAxisSelect: aNodeTestStringOrBlock asXPathNodeTest
				at: aPredicateCollection first asXPathNodeSetPosition
				into: self nodeSetClass new)
					sortOrder: XPathReverseDocumentSortOrder new;
					filterWithAll: aPredicateCollection startingAt: 2]
		ifFalse: [
			^ (self ancestorAxis: aNodeTestStringOrBlock)
				filterWithAll: aPredicateCollection]
]

{ #category : #'*XPath-Core-private' }
XMLNode >> ancestorAxisSelect: aNodeTest at: aPosition into: aNodeSet [
	| totalMatched |

	aPosition > 0
		ifFalse: [^ aNodeSet].
	totalMatched := 0.
	self ancestorNodesDo: [:each |
		((aNodeTest value: each)
			and: [(totalMatched := totalMatched + 1) = aPosition])
			ifTrue: [
				aNodeSet addLast: each.
				^ aNodeSet]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> ancestorAxisSelect: aNodeTest ifNotPresentInto: aNodeSet [
	self ancestorNodesDo: [:each |
		((aNodeSet includes: each) not
			and: [aNodeTest value: each])
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> ancestorAxisSelect: aNodeTest into: aNodeSet [
	self ancestorNodesDo: [:each |
		(aNodeTest value: each)
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> ancestorOrSelfAxis: aNodeTestStringOrBlock [
	^ (self
		ancestorOrSelfAxisSelect: aNodeTestStringOrBlock asXPathNodeTest
		into: self nodeSetClass new)
			sortOrder: XPathReverseDocumentSortOrder new
]

{ #category : #'*XPath-Core-enumerating - predicate axis' }
XMLNode >> ancestorOrSelfAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	(aPredicateCollection notEmpty
		and: [aPredicateCollection first isNumber])
		ifTrue: [
			^ (self
				ancestorOrSelfAxisSelect: aNodeTestStringOrBlock asXPathNodeTest
				at: aPredicateCollection first asXPathNodeSetPosition
				into: self nodeSetClass new)
					sortOrder: XPathReverseDocumentSortOrder new;
					filterWithAll: aPredicateCollection startingAt: 2]
		ifFalse: [
			^ (self ancestorOrSelfAxis: aNodeTestStringOrBlock)
				filterWithAll: aPredicateCollection]
]

{ #category : #'*XPath-Core-private' }
XMLNode >> ancestorOrSelfAxisSelect: aNodeTest at: aPosition into: aNodeSet [
	| totalMatched |

	aPosition > 0
		ifFalse: [^ aNodeSet].
	totalMatched := 0.
	self withAncestorNodesDo: [:each |
		((aNodeTest value: each)
			and: [(totalMatched := totalMatched + 1) = aPosition])
			ifTrue: [
				aNodeSet addLast: each.
				^ aNodeSet]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> ancestorOrSelfAxisSelect: aNodeTest ifNotPresentInto: aNodeSet [
	self withAncestorNodesDo: [:each|
		((aNodeSet includes: each) not
			and: [aNodeTest value: each])
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> ancestorOrSelfAxisSelect: aNodeTest into: aNodeSet [
	self withAncestorNodesDo: [:each |
		(aNodeTest value: each)
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-converting' }
XMLNode >> asXPathBoolean [
	XPathTypeException signal: 'Cannot convert nodes to booleans'
]

{ #category : #'*XPath-Core-converting' }
XMLNode >> asXPathComparable [
	XPathTypeException signal: 'Cannot compare nodes'
]

{ #category : #'*XPath-Core-converting' }
XMLNode >> asXPathFilterExpressionLocationPathRoot [
	^ self
]

{ #category : #'*XPath-Core-converting' }
XMLNode >> asXPathFilterable [
	XPathTypeException signal: 'Cannot filter nodes'
]

{ #category : #'*XPath-Core-converting' }
XMLNode >> asXPathNodeSet [
	XPathTypeException signal: 'Cannot convert nodes to node sets'
]

{ #category : #'*XPath-Core-converting' }
XMLNode >> asXPathNumber [
	XPathTypeException signal: 'Cannot convert nodes to numbers'
]

{ #category : #'*XPath-Core-converting' }
XMLNode >> asXPathString [
	XPathTypeException signal: 'Cannot convert nodes to strings'
]

{ #category : #'*XPath-Core-converting' }
XMLNode >> asXPathUnionable [
	XPathTypeException signal: 'Cannot union nodes'
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> attributeAxis: aNodeTestStringOrBlock [
	^ (self
		attributeAxisSelect: aNodeTestStringOrBlock asXPathAttributeAxisNodeTest
		into: self nodeSetClass new)
			sortOrder: XPathDocumentSortOrder new
]

{ #category : #'*XPath-Core-enumerating - predicate axis' }
XMLNode >> attributeAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	(aPredicateCollection notEmpty
		and: [aPredicateCollection first isNumber])
		ifTrue: [
			^ (self
				attributeAxisSelect:
					aNodeTestStringOrBlock asXPathAttributeAxisNodeTest
				at: aPredicateCollection first asXPathNodeSetPosition
				into: self nodeSetClass new)
					sortOrder: XPathDocumentSortOrder new;
					filterWithAll: aPredicateCollection startingAt: 2]
		ifFalse: [
			^ (self attributeAxis: aNodeTestStringOrBlock)
				filterWithAll: aPredicateCollection]
]

{ #category : #'*XPath-Core-private' }
XMLNode >> attributeAxisSelect: anAttributeNodeTest at: aPosition into: aNodeSet [
	^ aNodeSet
]

{ #category : #'*XPath-Core-private' }
XMLNode >> attributeAxisSelect: anAttributeNodeTest into: aNodeSet [
	^ aNodeSet
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> childAxis: aNodeTestStringOrBlock [
	^ (self
		childAxisSelect: aNodeTestStringOrBlock asXPathNodeTest
		into: self nodeSetClass new)
			sortOrder: XPathDocumentSortOrder new
]

{ #category : #'*XPath-Core-enumerating - predicate axis' }
XMLNode >> childAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	(aPredicateCollection notEmpty
		and: [aPredicateCollection first isNumber])
		ifTrue: [
			^ (self
				childAxisSelect: aNodeTestStringOrBlock asXPathNodeTest
				at: aPredicateCollection first asXPathNodeSetPosition
				into: self nodeSetClass new)
					sortOrder: XPathDocumentSortOrder new;
					filterWithAll: aPredicateCollection startingAt: 2]
		ifFalse: [
			^ (self childAxis: aNodeTestStringOrBlock)
				filterWithAll: aPredicateCollection]
]

{ #category : #'*XPath-Core-private' }
XMLNode >> childAxisSelect: aNodeTest at: aPosition into: aNodeSet [
	^ aNodeSet
]

{ #category : #'*XPath-Core-private' }
XMLNode >> childAxisSelect: aNodeTest into: aNodeSet [
	^ aNodeSet
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> descendantAxis: aNodeTestStringOrBlock [
	^ (self
		descendantAxisSelect: aNodeTestStringOrBlock asXPathNodeTest
		into: self nodeSetClass new)
			sortOrder: XPathDocumentSortOrder new
]

{ #category : #'*XPath-Core-enumerating - predicate axis' }
XMLNode >> descendantAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	(aPredicateCollection notEmpty
		and: [aPredicateCollection first isNumber])
		ifTrue: [
			^ (self
				descendantAxisSelect: aNodeTestStringOrBlock asXPathNodeTest
				at: aPredicateCollection first asXPathNodeSetPosition
				into: self nodeSetClass new)
					sortOrder: XPathDocumentSortOrder new;
					filterWithAll: aPredicateCollection startingAt: 2]
		ifFalse: [
			^ (self descendantAxis: aNodeTestStringOrBlock)
				filterWithAll: aPredicateCollection]
]

{ #category : #'*XPath-Core-private' }
XMLNode >> descendantAxisSelect: aNodeTest at: aPosition into: aNodeSet [
	^ aNodeSet
]

{ #category : #'*XPath-Core-private' }
XMLNode >> descendantAxisSelect: aNodeTest ifNotPresentInto: aNodeSet [
	^ aNodeSet
]

{ #category : #'*XPath-Core-private' }
XMLNode >> descendantAxisSelect: aNodeTest into: aNodeSet [
	^ aNodeSet
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> descendantOrSelfAxis: aNodeTestStringOrBlock [
	^ (self
		descendantOrSelfAxisSelect: aNodeTestStringOrBlock asXPathNodeTest
		into: self nodeSetClass new)
			sortOrder: XPathDocumentSortOrder new
]

{ #category : #'*XPath-Core-enumerating - predicate axis' }
XMLNode >> descendantOrSelfAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	(aPredicateCollection notEmpty
		and: [aPredicateCollection first isNumber])
		ifTrue: [
			^ (self
				descendantOrSelfAxisSelect: aNodeTestStringOrBlock asXPathNodeTest
				at: aPredicateCollection first asXPathNodeSetPosition
				into: self nodeSetClass new)
					sortOrder: XPathDocumentSortOrder new;
					filterWithAll: aPredicateCollection startingAt: 2]
		ifFalse: [
			^ (self descendantOrSelfAxis: aNodeTestStringOrBlock)
				filterWithAll: aPredicateCollection]
]

{ #category : #'*XPath-Core-private' }
XMLNode >> descendantOrSelfAxisSelect: aNodeTest at: aPosition into: aNodeSet [
	(aPosition = 1
		and: [aNodeTest value: self])
		ifTrue: [aNodeSet addLast: self].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> descendantOrSelfAxisSelect: aNodeTest ifNotPresentInto: aNodeSet [
	((aNodeSet includes: self) not
		and: [aNodeTest value: self])
		ifTrue: [aNodeSet addLast: self].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> descendantOrSelfAxisSelect: aNodeTest into: aNodeSet [
	(aNodeTest value: self)
		ifTrue: [aNodeSet addLast: self].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> followingAxis: aNodeTestStringOrBlock [
	^ (self
		followingAxisSelect: aNodeTestStringOrBlock asXPathNodeTest
		into: self nodeSetClass new)
			sortOrder: XPathDocumentSortOrder new
]

{ #category : #'*XPath-Core-enumerating - predicate axis' }
XMLNode >> followingAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	(aPredicateCollection notEmpty
		and: [aPredicateCollection first isNumber])
		ifTrue: [
			^ (self
				followingAxisSelect: aNodeTestStringOrBlock asXPathNodeTest
				at: aPredicateCollection first asXPathNodeSetPosition
				into: self nodeSetClass new)
					sortOrder: XPathDocumentSortOrder new;
					filterWithAll: aPredicateCollection startingAt: 2]
		ifFalse: [
			^ (self followingAxis: aNodeTestStringOrBlock)
				filterWithAll: aPredicateCollection]
]

{ #category : #'*XPath-Core-private' }
XMLNode >> followingAxisSelect: aNodeTest at: aPosition into: aNodeSet [
	| totalMatched |

	aPosition > 0
		ifFalse: [^ aNodeSet].
	totalMatched := 0.
	self followingNodesDo: [:each |
		((aNodeTest value: each)
			and: [(totalMatched := totalMatched + 1) = aPosition])
			ifTrue: [
				aNodeSet addLast: each.
				^ aNodeSet]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> followingAxisSelect: aNodeTest ifNotPresentInto: aNodeSet [
	self followingNodesDo: [:each |
		((aNodeSet includes: each) not
			and: [aNodeTest value: each])
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> followingAxisSelect: aNodeTest into: aNodeSet [
	self followingNodesDo: [:each |
		(aNodeTest value: each)
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-enumerating' }
XMLNode >> followingNodesDo: aBlock [
	self hasParent
		ifTrue: [| visitedSelf |
			visitedSelf := false.
			self parent nodesDo: [:each |
				visitedSelf
					ifTrue: [each allNodesDo: aBlock]
					ifFalse: [
						each = self
							ifTrue: [visitedSelf := true]]]]
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> followingSiblingAxis: aNodeTestStringOrBlock [
	^ (self
		followingSiblingAxisSelect: aNodeTestStringOrBlock asXPathNodeTest
		into: self nodeSetClass new)
			sortOrder: XPathDocumentSortOrder new
]

{ #category : #'*XPath-Core-enumerating - predicate axis' }
XMLNode >> followingSiblingAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	(aPredicateCollection notEmpty
		and: [aPredicateCollection first isNumber])
		ifTrue: [
			^ (self
				followingSiblingAxisSelect: aNodeTestStringOrBlock asXPathNodeTest
				at: aPredicateCollection first asXPathNodeSetPosition
				into: self nodeSetClass new)
					sortOrder: XPathDocumentSortOrder new;
					filterWithAll: aPredicateCollection startingAt: 2]
		ifFalse: [
			^ (self followingSiblingAxis: aNodeTestStringOrBlock)
				filterWithAll: aPredicateCollection]
]

{ #category : #'*XPath-Core-private' }
XMLNode >> followingSiblingAxisSelect: aNodeTest at: aPosition into: aNodeSet [
	| totalMatched |

	aPosition > 0
		ifFalse: [^ aNodeSet].
	totalMatched := 0.
	self followingSiblingNodesDo: [:each |
		((aNodeTest value: each)
			and: [(totalMatched := totalMatched + 1) = aPosition])
			ifTrue: [
				aNodeSet addLast: each.
				^ aNodeSet]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> followingSiblingAxisSelect: aNodeTest ifNotPresentInto: aNodeSet [
	self followingSiblingNodesDo: [:each |
		((aNodeSet includes: each) not
			and: [aNodeTest value: each])
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> followingSiblingAxisSelect: aNodeTest into: aNodeSet [
	self followingSiblingNodesDo: [:each |
		(aNodeTest value: each)
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-enumerating' }
XMLNode >> followingSiblingNodesDo: aBlock [
	self hasParent
		ifTrue: [| visitedSelf |
			visitedSelf := false.
			self parent nodesDo: [:each |
				visitedSelf
					ifTrue: [aBlock value: each]
					ifFalse: [
						each = self
							ifTrue: [visitedSelf := true]]]]
]

{ #category : #'*XPath-Core-testing' }
XMLNode >> hasExpandedName [
	^ false
]

{ #category : #'*XPath-Core-testing' }
XMLNode >> isNamespace [
	^ false
]

{ #category : #'*XPath-Core-testing' }
XMLNode >> matches: aNodeTestBlock [
	"#in: is not portable to GS"
	^ aNodeTestBlock value: self
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> namespaceAxis: aNodeTestStringOrBlock [
	^ (self
		namespaceAxisSelect: aNodeTestStringOrBlock asXPathNamespaceAxisNodeTest
		into: self nodeSetClass new)
			sortOrder: XPathDocumentSortOrder new
]

{ #category : #'*XPath-Core-enumerating - predicate axis' }
XMLNode >> namespaceAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ (self namespaceAxis: aNodeTestStringOrBlock)
		filterWithAll: aPredicateCollection
]

{ #category : #'*XPath-Core-private' }
XMLNode >> namespaceAxisSelect: aNamespaceNodeTest into: aNodeSet [
	^ aNodeSet
]

{ #category : #'*XPath-Core-private' }
XMLNode >> nodeSetClass [
	^ XPathNodeSet
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> parentAxis: aNodeTestStringOrBlock [
	^ (self
		parentAxisSelect: aNodeTestStringOrBlock asXPathNodeTest
		into: self nodeSetClass new)
			"the spec says this is a forawrd axis"
			sortOrder: XPathDocumentSortOrder new
]

{ #category : #'*XPath-Core-enumerating - predicate axis' }
XMLNode >> parentAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	(aPredicateCollection notEmpty
		and: [aPredicateCollection first isNumber])
		ifTrue: [
			^ (self
				parentAxisSelect: aNodeTestStringOrBlock asXPathNodeTest
				at: aPredicateCollection first asXPathNodeSetPosition
				into: self nodeSetClass new)
					"the spec says this is a forawrd axis"
					sortOrder: XPathDocumentSortOrder new;
					filterEachInSeparateContextWithAll: aPredicateCollection
						startingAt: 2]
		ifFalse: [
			^ (self parentAxis: aNodeTestStringOrBlock)
				filterEachInSeparateContextWithAll: aPredicateCollection]
]

{ #category : #'*XPath-Core-private' }
XMLNode >> parentAxisSelect: aNodeTest at: aPosition into: aNodeSet [
	(aPosition = 1
		and: [self hasParent
			and: [aNodeTest value: self parent]])
		ifTrue: [aNodeSet addLast: self parent].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> parentAxisSelect: aNodeTest ifNotPresentInto: aNodeSet [
	(self hasParent
		and: [(aNodeSet includes: self parent) not
			and: [aNodeTest value: self parent]])
		ifTrue: [aNodeSet addLast: self parent].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> parentAxisSelect: aNodeTest into: aNodeSet [
	(self hasParent
		and: [aNodeTest value: self parent])
		ifTrue: [aNodeSet addLast: self parent].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> precedingAxis: aNodeTestStringOrBlock [
	^ (self
		precedingAxisSelect: aNodeTestStringOrBlock asXPathNodeTest
		into: self nodeSetClass new)
			sortOrder: XPathReverseDocumentSortOrder new
]

{ #category : #'*XPath-Core-enumerating - predicate axis' }
XMLNode >> precedingAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	(aPredicateCollection notEmpty
		and: [aPredicateCollection first isNumber])
		ifTrue: [
			^ (self
				precedingAxisSelect: aNodeTestStringOrBlock asXPathNodeTest
				at: aPredicateCollection first asXPathNodeSetPosition
				into: self nodeSetClass new)
					sortOrder: XPathReverseDocumentSortOrder new;
					filterWithAll: aPredicateCollection startingAt: 2]
		ifFalse: [
			^ (self precedingAxis: aNodeTestStringOrBlock)
				filterWithAll: aPredicateCollection]
]

{ #category : #'*XPath-Core-private' }
XMLNode >> precedingAxisSelect: aNodeTest at: aPosition into: aNodeSet [
	| totalMatched |

	aPosition > 0
		ifFalse: [^ aNodeSet].
	totalMatched := 0.
	self precedingNodesDo: [:each |
		((aNodeTest value: each)
			and: [(totalMatched := totalMatched + 1) = aPosition])
			ifTrue: [
				aNodeSet addLast: each.
				^ aNodeSet]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> precedingAxisSelect: aNodeTest ifNotPresentInto: aNodeSet [
	self precedingNodesDo: [:each |
		((aNodeSet includes: each) not
			and: [aNodeTest value: each])
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> precedingAxisSelect: aNodeTest into: aNodeSet [
	self precedingNodesDo: [:each |
		(aNodeTest value: each)
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-enumerating' }
XMLNode >> precedingNodesDo: aBlock [
	self hasParent
		ifTrue: [| visitedSelf |
			visitedSelf := false.
			self parent nodes reverseDo: [:each |
				visitedSelf
					ifTrue: [each allNodesReverseDo: aBlock]
					ifFalse: [
						each = self
							ifTrue: [visitedSelf := true]]]]
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> precedingSiblingAxis: aNodeTestStringOrBlock [
	^ (self
		precedingSiblingAxisSelect: aNodeTestStringOrBlock asXPathNodeTest
		into: self nodeSetClass new)
			sortOrder: XPathReverseDocumentSortOrder new
]

{ #category : #'*XPath-Core-enumerating - predicate axis' }
XMLNode >> precedingSiblingAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	(aPredicateCollection notEmpty
		and: [aPredicateCollection first isNumber])
		ifTrue: [
			^ (self
				precedingSiblingAxisSelect: aNodeTestStringOrBlock asXPathNodeTest
				at: aPredicateCollection first asXPathNodeSetPosition
				into: self nodeSetClass new)
					sortOrder: XPathReverseDocumentSortOrder new;
					filterWithAll: aPredicateCollection startingAt: 2]
		ifFalse: [
			^ (self precedingSiblingAxis: aNodeTestStringOrBlock)
				filterWithAll: aPredicateCollection]
]

{ #category : #'*XPath-Core-private' }
XMLNode >> precedingSiblingAxisSelect: aNodeTest at: aPosition into: aNodeSet [
	| totalMatched |

	aPosition > 0
		ifFalse: [^ aNodeSet].
	totalMatched := 0.
	self precedingSiblingNodesDo: [:each |
		((aNodeTest value: each)
			and: [(totalMatched := totalMatched + 1) = aPosition])
			ifTrue: [
				aNodeSet addLast: each.
				^ aNodeSet]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> precedingSiblingAxisSelect: aNodeTest ifNotPresentInto: aNodeSet [
	self precedingSiblingNodesDo: [:each |
		((aNodeSet includes: each) not
			and: [aNodeTest value: each])
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> precedingSiblingAxisSelect: aNodeTest into: aNodeSet [
	self precedingSiblingNodesDo: [:each |
		(aNodeTest value: each)
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-enumerating' }
XMLNode >> precedingSiblingNodesDo: aBlock [
	self hasParent
		ifTrue: [| visitedSelf |
			visitedSelf := false.
			self parent nodes reverseDo: [:each |
				visitedSelf
					ifTrue: [aBlock value: each]
					ifFalse: [
						each = self
							ifTrue: [visitedSelf := true]]]]
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> selfAxis: aNodeTestStringOrBlock [
	^ (self
		selfAxisSelect: aNodeTestStringOrBlock asXPathNodeTest
		into: self nodeSetClass new)
			sortOrder: XPathDocumentSortOrder new
]

{ #category : #'*XPath-Core-enumerating - predicate axis' }
XMLNode >> selfAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	(aPredicateCollection notEmpty
		and: [aPredicateCollection first isNumber])
		ifTrue: [
			^ (self
				selfAxisSelect: aNodeTestStringOrBlock asXPathNodeTest
				at: aPredicateCollection first asXPathNodeSetPosition
				into: self nodeSetClass new)
					sortOrder: XPathDocumentSortOrder new;
					filterEachInSeparateContextWithAll: aPredicateCollection
						startingAt: 2]
		ifFalse: [
			^ (self selfAxis: aNodeTestStringOrBlock)
				filterEachInSeparateContextWithAll: aPredicateCollection]
]

{ #category : #'*XPath-Core-private' }
XMLNode >> selfAxisSelect: aNodeTest at: aPosition into: aNodeSet [
	(aPosition = 1
		and: [aNodeTest value: self])
		ifTrue: [aNodeSet addLast: self].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> selfAxisSelect: aNodeTest into: aNodeSet [
	(aNodeTest value: self)
		ifTrue: [aNodeSet addLast: self].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-accessing' }
XMLNode >> stringValue [
	"returns XPath node string-value"
	 ^ ''
]

{ #category : #'*XPath-Core-private' }
XMLNode >> withAncestorNodesDo: aBlock [
	aBlock value: self.
	self ancestorNodesDo: aBlock.
]

{ #category : #'*XPath-Core-evaluating' }
XMLNode >> xPath: anXPathOrXPathString [
	^ anXPathOrXPathString asXPath in: self
]

{ #category : #'*XPath-Core-evaluating' }
XMLNode >> xPath: anXPathOrXPathString context: aContext [
	^ anXPathOrXPathString asXPath
		in: self
		context: aContext
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> ~ aNodeTestStringOrBlock [
	^ self selfAxis: aNodeTestStringOrBlock
]
