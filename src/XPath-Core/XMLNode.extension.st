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
		ancestorAxisSelect: aNodeTestStringOrBlock asXPathNodeTestBlock
		into: self nodeSetClass new)
			sortOrder: XPathReverseDocumentSortOrder new
]

{ #category : #'*XPath-Core-enumerating - predicate axis' }
XMLNode >> ancestorAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ (self ancestorAxis: aNodeTestStringOrBlock)
		filterWithAll: aPredicateCollection
]

{ #category : #'*XPath-Core-private' }
XMLNode >> ancestorAxisSelect: aNodeTestBlock ifNotPresentInto: aNodeSet [
	self ancestorNodesDo: [:each |
		((aNodeSet includes: each) not
			and: [aNodeTestBlock value: each])
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> ancestorAxisSelect: aNodeTestBlock into: aNodeSet [
	self ancestorNodesDo: [:each |
		(aNodeTestBlock value: each)
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> ancestorOrSelfAxis: aNodeTestStringOrBlock [
	^ (self
		ancestorOrSelfAxisSelect: aNodeTestStringOrBlock asXPathNodeTestBlock
		into: self nodeSetClass new)
			sortOrder: XPathReverseDocumentSortOrder new
]

{ #category : #'*XPath-Core-enumerating - predicate axis' }
XMLNode >> ancestorOrSelfAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ (self ancestorOrSelfAxis: aNodeTestStringOrBlock)
		filterWithAll: aPredicateCollection
]

{ #category : #'*XPath-Core-private' }
XMLNode >> ancestorOrSelfAxisSelect: aNodeTestBlock ifNotPresentInto: aNodeSet [
	((aNodeSet includes: self) not
		and: [aNodeTestBlock value: self])
		ifTrue: [aNodeSet addLast: self].
	self ancestorNodesDo: [:each |
		((aNodeSet includes: each) not
			and: [aNodeTestBlock value: each])
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> ancestorOrSelfAxisSelect: aNodeTestBlock into: aNodeSet [
	(aNodeTestBlock value: self)
		ifTrue: [aNodeSet addLast: self].
	self ancestorNodesDo: [:each |
		(aNodeTestBlock value: each)
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
		attributeAxisSelect: aNodeTestStringOrBlock asXPathAttributeNodeTestBlock
		into: self nodeSetClass new)
			sortOrder: XPathDocumentSortOrder new
]

{ #category : #'*XPath-Core-enumerating - predicate axis' }
XMLNode >> attributeAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ (self attributeAxis: aNodeTestStringOrBlock)
		filterWithAll: aPredicateCollection
]

{ #category : #'*XPath-Core-private' }
XMLNode >> attributeAxisSelect: anAttributeNodeTestBlock into: aNodeSet [
	^ aNodeSet
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> childAxis: aNodeTestStringOrBlock [
	^ (self
		childAxisSelect: aNodeTestStringOrBlock asXPathNodeTestBlock
		into: self nodeSetClass new)
			sortOrder: XPathDocumentSortOrder new
]

{ #category : #'*XPath-Core-enumerating - predicate axis' }
XMLNode >> childAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ (self childAxis: aNodeTestStringOrBlock)
		filterWithAll: aPredicateCollection
]

{ #category : #'*XPath-Core-private' }
XMLNode >> childAxisSelect: aNodeTestBlock into: aNodeSet [
	^ aNodeSet
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> descendantAxis: aNodeTestStringOrBlock [
	^ (self
		descendantAxisSelect: aNodeTestStringOrBlock asXPathNodeTestBlock
		into: self nodeSetClass new)
			sortOrder: XPathDocumentSortOrder new
]

{ #category : #'*XPath-Core-enumerating - predicate axis' }
XMLNode >> descendantAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ (self descendantAxis: aNodeTestStringOrBlock)
		filterWithAll: aPredicateCollection
]

{ #category : #'*XPath-Core-private' }
XMLNode >> descendantAxisSelect: aNodeTestBlock ifNotPresentInto: aNodeSet [
	^ aNodeSet
]

{ #category : #'*XPath-Core-private' }
XMLNode >> descendantAxisSelect: aNodeTestBlock into: aNodeSet [
	^ aNodeSet
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> descendantOrSelfAxis: aNodeTestStringOrBlock [
	^ (self
		descendantOrSelfAxisSelect: aNodeTestStringOrBlock asXPathNodeTestBlock
		into: self nodeSetClass new)
			sortOrder: XPathDocumentSortOrder new
]

{ #category : #'*XPath-Core-enumerating - predicate axis' }
XMLNode >> descendantOrSelfAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ (self descendantOrSelfAxis: aNodeTestStringOrBlock)
		filterWithAll: aPredicateCollection
]

{ #category : #'*XPath-Core-private' }
XMLNode >> descendantOrSelfAxisSelect: aNodeTestBlock ifNotPresentInto: aNodeSet [
	((aNodeSet includes: self) not
		and: [aNodeTestBlock value: self])
		ifTrue: [aNodeSet addLast: self].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> descendantOrSelfAxisSelect: aNodeTestBlock into: aNodeSet [
	(aNodeTestBlock value: self)
		ifTrue: [aNodeSet addLast: self].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> followingAxis: aNodeTestStringOrBlock [
	^ (self
		followingAxisSelect: aNodeTestStringOrBlock asXPathNodeTestBlock
		into: self nodeSetClass new)
			sortOrder: XPathDocumentSortOrder new
]

{ #category : #'*XPath-Core-enumerating - predicate axis' }
XMLNode >> followingAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ (self followingAxis: aNodeTestStringOrBlock)
		filterWithAll: aPredicateCollection
]

{ #category : #'*XPath-Core-private' }
XMLNode >> followingAxisSelect: aNodeTestBlock ifNotPresentInto: aNodeSet [
	self followingNodesDo: [:each |
		((aNodeSet includes: each) not
			and: [aNodeTestBlock value: each])
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> followingAxisSelect: aNodeTestBlock into: aNodeSet [
	self followingNodesDo: [:each |
		(aNodeTestBlock value: each)
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
		followingSiblingAxisSelect: aNodeTestStringOrBlock asXPathNodeTestBlock
		into: self nodeSetClass new)
			sortOrder: XPathDocumentSortOrder new
]

{ #category : #'*XPath-Core-enumerating - predicate axis' }
XMLNode >> followingSiblingAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ (self followingSiblingAxis: aNodeTestStringOrBlock)
		filterWithAll: aPredicateCollection
]

{ #category : #'*XPath-Core-private' }
XMLNode >> followingSiblingAxisSelect: aNodeTestBlock ifNotPresentInto: aNodeSet [
	self followingSiblingNodesDo: [:each |
		((aNodeSet includes: each) not
			and: [aNodeTestBlock value: each])
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> followingSiblingAxisSelect: aNodeTestBlock into: aNodeSet [
	self followingSiblingNodesDo: [:each |
		(aNodeTestBlock value: each)
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
		namespaceAxisSelect: aNodeTestStringOrBlock asXPathNamespaceNodeTestBlock
		into: self nodeSetClass new)
			sortOrder: XPathDocumentSortOrder new
]

{ #category : #'*XPath-Core-enumerating - predicate axis' }
XMLNode >> namespaceAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ (self namespaceAxis: aNodeTestStringOrBlock)
		filterWithAll: aPredicateCollection
]

{ #category : #'*XPath-Core-private' }
XMLNode >> namespaceAxisSelect: aNamespaceNodeTestBlock into: aNodeSet [
	^ aNodeSet
]

{ #category : #'*XPath-Core-private' }
XMLNode >> nodeSetClass [
	^ XPathNodeSet
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> parentAxis: aNodeTestStringOrBlock [
	^ (self
		parentAxisSelect: aNodeTestStringOrBlock asXPathNodeTestBlock
		into: self nodeSetClass new)
			"the spec says this is a forawrd axis"
			sortOrder: XPathDocumentSortOrder new
]

{ #category : #'*XPath-Core-enumerating - predicate axis' }
XMLNode >> parentAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ (self parentAxis: aNodeTestStringOrBlock)
		filterEachInSeparateContextWithAll: aPredicateCollection
]

{ #category : #'*XPath-Core-private' }
XMLNode >> parentAxisSelect: aNodeTestBlock ifNotPresentInto: aNodeSet [
	(self hasParent
		and: [(aNodeSet includes: self parent) not
			and: [aNodeTestBlock value: self parent]])
		ifTrue: [aNodeSet addLast: self parent].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> parentAxisSelect: aNodeTestBlock into: aNodeSet [
	(self hasParent
		and: [aNodeTestBlock value: self parent])
		ifTrue: [aNodeSet addLast: self parent].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> precedingAxis: aNodeTestStringOrBlock [
	^ (self
		precedingAxisSelect: aNodeTestStringOrBlock asXPathNodeTestBlock
		into: self nodeSetClass new)
			sortOrder: XPathReverseDocumentSortOrder new
]

{ #category : #'*XPath-Core-enumerating - predicate axis' }
XMLNode >> precedingAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ (self precedingAxis: aNodeTestStringOrBlock)
		filterWithAll: aPredicateCollection
]

{ #category : #'*XPath-Core-private' }
XMLNode >> precedingAxisSelect: aNodeTestBlock ifNotPresentInto: aNodeSet [
	self precedingNodesDo: [:each |
		((aNodeSet includes: each) not
			and: [aNodeTestBlock value: each])
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> precedingAxisSelect: aNodeTestBlock into: aNodeSet [
	self precedingNodesDo: [:each |
		(aNodeTestBlock value: each)
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
		precedingSiblingAxisSelect: aNodeTestStringOrBlock asXPathNodeTestBlock
		into: self nodeSetClass new)
			sortOrder: XPathReverseDocumentSortOrder new
]

{ #category : #'*XPath-Core-enumerating - predicate axis' }
XMLNode >> precedingSiblingAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ (self precedingSiblingAxis: aNodeTestStringOrBlock)
		filterWithAll: aPredicateCollection
]

{ #category : #'*XPath-Core-private' }
XMLNode >> precedingSiblingAxisSelect: aNodeTestBlock ifNotPresentInto: aNodeSet [
	self precedingSiblingNodesDo: [:each |
		((aNodeSet includes: each) not
			and: [aNodeTestBlock value: each])
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> precedingSiblingAxisSelect: aNodeTestBlock into: aNodeSet [
	self precedingSiblingNodesDo: [:each |
		(aNodeTestBlock value: each)
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
		selfAxisSelect: aNodeTestStringOrBlock asXPathNodeTestBlock
		into: self nodeSetClass new)
			sortOrder: XPathDocumentSortOrder new
]

{ #category : #'*XPath-Core-enumerating - predicate axis' }
XMLNode >> selfAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ (self selfAxis: aNodeTestStringOrBlock)
		filterEachInSeparateContextWithAll: aPredicateCollection
]

{ #category : #'*XPath-Core-private' }
XMLNode >> selfAxisSelect: aNodeTestBlock into: aNodeSet [
	(aNodeTestBlock value: self)
		ifTrue: [aNodeSet addLast: self].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-accessing' }
XMLNode >> stringValue [
	"returns XPath node string-value"
	 ^ ''
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
