"
This class is an ordered node list that has no duplicates.
"
Class {
	#name : #XPathNodeSet,
	#superclass : #XMLNodeList,
	#instVars : [
		'set',
		'sortOrder'
	],
	#category : #'XPath-Core-DOM'
}

{ #category : #'instance creation' }
XPathNodeSet class >> new [
	^ self new: 10
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> % aStringOrBlockOrNodeTestWithPredicates [
	^ aStringOrBlockOrNodeTestWithPredicates isXPathNodeTestWithPredicates
		ifTrue: [
			self
				parentAxis: aStringOrBlockOrNodeTestWithPredicates nodeTest
				predicates: aStringOrBlockOrNodeTestWithPredicates predicates]
		ifFalse: [
			self parentAxis: aStringOrBlockOrNodeTestWithPredicates]
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> %% aStringOrBlockOrNodeTestWithPredicates [
	^ aStringOrBlockOrNodeTestWithPredicates isXPathNodeTestWithPredicates
		ifTrue: [
			self
				ancestorAxis: aStringOrBlockOrNodeTestWithPredicates nodeTest
				predicates: aStringOrBlockOrNodeTestWithPredicates predicates]
		ifFalse: [
			self ancestorAxis: aStringOrBlockOrNodeTestWithPredicates]
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> %%~ aStringOrBlockOrNodeTestWithPredicates [
	^ aStringOrBlockOrNodeTestWithPredicates isXPathNodeTestWithPredicates
		ifTrue: [
			self
				ancestorOrSelfAxis: aStringOrBlockOrNodeTestWithPredicates nodeTest
				predicates: aStringOrBlockOrNodeTestWithPredicates predicates]
		ifFalse: [
			self ancestorOrSelfAxis: aStringOrBlockOrNodeTestWithPredicates]
]

{ #category : #enumerating }
XPathNodeSet >> & aNodeSet [
	"redefined here for portability"
	^ self intersection: aNodeSet
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> / aStringOrBlockOrNodeTestWithPredicates [
	^ aStringOrBlockOrNodeTestWithPredicates isXPathNodeTestWithPredicates
		ifTrue: [
			self
				childAxis: aStringOrBlockOrNodeTestWithPredicates nodeTest
				predicates: aStringOrBlockOrNodeTestWithPredicates predicates]
		ifFalse: [
			self childAxis: aStringOrBlockOrNodeTestWithPredicates]
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> // aStringOrBlockOrNodeTestWithPredicates [
	^ aStringOrBlockOrNodeTestWithPredicates isXPathNodeTestWithPredicates
		ifTrue: [
			self
				descendantAxis: aStringOrBlockOrNodeTestWithPredicates nodeTest
				predicates: aStringOrBlockOrNodeTestWithPredicates predicates]
		ifFalse: [
			self descendantAxis: aStringOrBlockOrNodeTestWithPredicates]
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> //~ aStringOrBlockOrNodeTestWithPredicates [
	^ aStringOrBlockOrNodeTestWithPredicates isXPathNodeTestWithPredicates
		ifTrue: [
			self
				descendantOrSelfAxis: aStringOrBlockOrNodeTestWithPredicates nodeTest
				predicates: aStringOrBlockOrNodeTestWithPredicates predicates]
		ifFalse: [
			self descendantOrSelfAxis: aStringOrBlockOrNodeTestWithPredicates]
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> << aStringOrBlockOrNodeTestWithPredicates [
	^ aStringOrBlockOrNodeTestWithPredicates isXPathNodeTestWithPredicates
		ifTrue: [
			self
				precedingAxis: aStringOrBlockOrNodeTestWithPredicates nodeTest
				predicates: aStringOrBlockOrNodeTestWithPredicates predicates]
		ifFalse: [
			self precedingAxis: aStringOrBlockOrNodeTestWithPredicates]
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> <<< aStringOrBlockOrNodeTestWithPredicates [
	^ aStringOrBlockOrNodeTestWithPredicates isXPathNodeTestWithPredicates
		ifTrue: [
			self
				precedingSiblingAxis: aStringOrBlockOrNodeTestWithPredicates nodeTest
				predicates: aStringOrBlockOrNodeTestWithPredicates predicates]
		ifFalse: [
			self precedingSiblingAxis: aStringOrBlockOrNodeTestWithPredicates]
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> >> aStringOrBlockOrNodeTestWithPredicates [
	^ aStringOrBlockOrNodeTestWithPredicates isXPathNodeTestWithPredicates
		ifTrue: [
			self
				followingAxis: aStringOrBlockOrNodeTestWithPredicates nodeTest
				predicates: aStringOrBlockOrNodeTestWithPredicates predicates]
		ifFalse: [
			self followingAxis: aStringOrBlockOrNodeTestWithPredicates]
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> >>> aStringOrBlockOrNodeTestWithPredicates [
	^ aStringOrBlockOrNodeTestWithPredicates isXPathNodeTestWithPredicates
		ifTrue: [
			self
				followingSiblingAxis: aStringOrBlockOrNodeTestWithPredicates nodeTest
				predicates: aStringOrBlockOrNodeTestWithPredicates predicates]
		ifFalse: [
			self followingSiblingAxis: aStringOrBlockOrNodeTestWithPredicates]
]

{ #category : #enumerating }
XPathNodeSet >> ?? aPredicateOrPredicateCollection [
	"?? filters an entire resulting node set like a filter expression, so
	all predicate positions are relative to document order"
	^ aPredicateOrPredicateCollection isCollection
		ifTrue: [
			self asXPathFilterExpressionPredicateRoot
				filterWithAll: aPredicateOrPredicateCollection]
		ifFalse: [
			self asXPathFilterExpressionPredicateRoot
				filterWith: aPredicateOrPredicateCollection]
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> @ aStringOrBlockOrNodeTestWithPredicates [
	^ aStringOrBlockOrNodeTestWithPredicates isXPathNodeTestWithPredicates
		ifTrue: [
			self
				attributeAxis: aStringOrBlockOrNodeTestWithPredicates nodeTest
				predicates: aStringOrBlockOrNodeTestWithPredicates predicates]
		ifFalse: [
			self attributeAxis: aStringOrBlockOrNodeTestWithPredicates]
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> @@ aStringOrBlockOrNodeTestWithPredicates [
	^ aStringOrBlockOrNodeTestWithPredicates isXPathNodeTestWithPredicates
		ifTrue: [
			self
				namespaceAxis: aStringOrBlockOrNodeTestWithPredicates nodeTest
				predicates: aStringOrBlockOrNodeTestWithPredicates predicates]
		ifFalse: [
			self namespaceAxis: aStringOrBlockOrNodeTestWithPredicates]
]

{ #category : #enumerating }
XPathNodeSet >> \ aNodeSet [
	"redefined here for portability"
	^ self difference: aNodeSet
]

{ #category : #private }
XPathNodeSet >> addAllIfNotPresentTo: aCollection [
	"this inverts #addAll: because #addAll: uses #do: instead of #to:do:
	because it accepts non-SequenceableCollection arguments, and also
	does an #includes: test to avoid adding an already present node to
	the end of a node set, which whould left shift everything after
	its old position by one"
	1 to: self size do: [:i | | node |
		node := self at: i.
		(aCollection includes: node)
			ifFalse: [aCollection addLast: node]]
]

{ #category : #private }
XPathNodeSet >> addAllTo: aCollection [
	"this inverts #addAll: because #addAll: uses #do: instead of #to:do:
	because it accepts non-SequenceableCollection arguments"
	1 to: self size do: [:i |
		aCollection addLast: (self at: i)]
]

{ #category : #private }
XPathNodeSet >> afterAdding: aNode at: anIndex [
	| oldSize |

	sortOrder := nil.
	oldSize := self set size.
	(self set
		add: aNode;
		size) = oldSize
		ifTrue: [
			self
				removeDuplicateOf: aNode
				notAt: anIndex]
		ifFalse: [
			observer
				ifNotNil: [observer addedNode: aNode]].
]

{ #category : #private }
XPathNodeSet >> afterAddingLast: aNode [
	| oldSize |

	sortOrder := nil.
	oldSize := self set size.
	(self set
		add: aNode;
		size) = oldSize
		ifTrue: [
			self
				removeDuplicateOf: aNode
				notAt: oldSize]
		ifFalse: [
			observer
				ifNotNil: [observer addedNode: aNode]]
]

{ #category : #private }
XPathNodeSet >> afterRemoving: aNode [
	"removing does not change order, so sortOrder is not reset here"
	self set remove: aNode.
	observer
		ifNotNil: [observer removedNode: aNode].
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> ancestorAxis: aNodeTestStringOrBlock [
	^ self sortOrder
		on: self
		ancestorAxis: aNodeTestStringOrBlock
]

{ #category : #'enumerating - predicate axis' }
XPathNodeSet >> ancestorAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ self sortOrder
		on: self
		ancestorAxis: aNodeTestStringOrBlock
		predicates: aPredicateCollection
]

{ #category : #private }
XPathNodeSet >> ancestorAxisAnySatisfy: aNodeTest [
	self do: [:each |
		(each ancestorAxisAnySatisfy: aNodeTest)
			ifTrue: [^ true]].
	^ false.
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> ancestorOrSelfAxis: aNodeTestStringOrBlock [
	^ self sortOrder
		on: self
		ancestorOrSelfAxis: aNodeTestStringOrBlock
]

{ #category : #'enumerating - predicate axis' }
XPathNodeSet >> ancestorOrSelfAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ self sortOrder
		on: self
		ancestorOrSelfAxis: aNodeTestStringOrBlock
		predicates: aPredicateCollection
]

{ #category : #private }
XPathNodeSet >> ancestorOrSelfAxisAnySatisfy: aNodeTest [
	self do: [:each |
		(each ancestorOrSelfAxisAnySatisfy: aNodeTest)
			ifTrue: [^ true]].
	^ false.
]

{ #category : #converting }
XPathNodeSet >> asXPathBoolean [
	^ self notEmpty
]

{ #category : #converting }
XPathNodeSet >> asXPathComparable [
	^ XPathNodeSetComparable value: self
]

{ #category : #converting }
XPathNodeSet >> asXPathFilterExpressionLocationPathRoot [
	"any node set can be used as the root of a filter expression
	location path, like (/one)/two or '$one/two' (when $one is bound
	to a node set)"
	^ self
]

{ #category : #converting }
XPathNodeSet >> asXPathFilterExpressionPredicateRoot [
	"any node set can be filterd as a whole with predicates in a filter
	expression, like '(/one)[two]' or '$one[two]' (when $one is bound to
	a node set), but it must be sorted so predicate positions are relative to
	document order"
	^ self sorted
]

{ #category : #converting }
XPathNodeSet >> asXPathNodeSet [
	^ self
]

{ #category : #converting }
XPathNodeSet >> asXPathNumber [
	^ self asXPathString asXPathNumber
]

{ #category : #converting }
XPathNodeSet >> asXPathString [
	^ self firstInDocumentOrder
		ifNil: ['']
		ifNotNil: [:node | node stringValue]
]

{ #category : #converting }
XPathNodeSet >> asXPathUnionable [
	^ self
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> attributeAxis: aNodeTestStringOrBlock [
	^ self sortOrder
		on: self
		attributeAxis: aNodeTestStringOrBlock
]

{ #category : #'enumerating - predicate axis' }
XPathNodeSet >> attributeAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ self sortOrder
		on: self
		attributeAxis: aNodeTestStringOrBlock
		predicates: aPredicateCollection
]

{ #category : #private }
XPathNodeSet >> attributeAxisAnySatisfy: anAttributeNodeTest [
	self do: [:each |
		(each attributeAxisAnySatisfy: anAttributeNodeTest)
			ifTrue: [^ true]].
	^ false.
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> childAxis: aNodeTestStringOrBlock [
	^ self sortOrder
		on: self
		childAxis: aNodeTestStringOrBlock
]

{ #category : #'enumerating - predicate axis' }
XPathNodeSet >> childAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ self sortOrder
		on: self
		childAxis: aNodeTestStringOrBlock
		predicates: aPredicateCollection
]

{ #category : #private }
XPathNodeSet >> childAxisAnySatisfy: aNodeTest [
	self do: [:each |
		(each childAxisAnySatisfy: aNodeTest)
			ifTrue: [^ true]].
	^ false.
]

{ #category : #copying }
XPathNodeSet >> copy [
	"copies that don't add or replace keep sort order"
	^ super copy sortOrderFrom: self
]

{ #category : #copying }
XPathNodeSet >> copyAfter: anObject [
	"copies that don't add or replace keep sort order"
	^ (super copyAfter: anObject) sortOrderFrom: self
]

{ #category : #copying }
XPathNodeSet >> copyAfterLast: anObject [
	"copies that don't add or replace keep sort order"
	^ (super copyAfterLast: anObject) sortOrderFrom: self
]

{ #category : #copying }
XPathNodeSet >> copyFrom: aStartIndex to: anEndIndex [
	"copies that don't add or replace keep sort order"
	^ (super
		copyFrom: aStartIndex
		to: anEndIndex) sortOrderFrom: self
]

{ #category : #copying }
XPathNodeSet >> copyUpTo: anObject [
	"copies that don't add or replace keep sort order"
	^ (super copyUpTo: anObject) sortOrderFrom: self
]

{ #category : #copying }
XPathNodeSet >> copyUpToLast: anObject [
	"copies that don't add or replace keep sort order"
	^ (super copyUpToLast: anObject) sortOrderFrom: self
]

{ #category : #copying }
XPathNodeSet >> copyWithout: anObject [
	"copies that don't add or replace keep sort order"
	^ (super copyWithout: anObject) sortOrderFrom: self
]

{ #category : #copying }
XPathNodeSet >> copyWithoutAll: aCollection [
	"copies that don't add or replace keep sort order"
	^ (super copyWithoutAll: aCollection) sortOrderFrom: self
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> descendantAxis: aNodeTestStringOrBlock [
	^ self sortOrder
		on: self
		descendantAxis: aNodeTestStringOrBlock
]

{ #category : #'enumerating - predicate axis' }
XPathNodeSet >> descendantAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ self sortOrder
		on: self
		descendantAxis: aNodeTestStringOrBlock
		predicates: aPredicateCollection
]

{ #category : #private }
XPathNodeSet >> descendantAxisAnySatisfy: aNodeTest [
	self do: [:each |
		(each descendantAxisAnySatisfy: aNodeTest)
			ifTrue: [^ true]].
	^ false.
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> descendantOrSelfAxis: aNodeTestStringOrBlock [
	^ self sortOrder
		on: self
		descendantOrSelfAxis: aNodeTestStringOrBlock
]

{ #category : #'enumerating - predicate axis' }
XPathNodeSet >> descendantOrSelfAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ self sortOrder
		on: self
		descendantOrSelfAxis: aNodeTestStringOrBlock
		predicates: aPredicateCollection
]

{ #category : #private }
XPathNodeSet >> descendantOrSelfAxisAnySatisfy: aNodeTest [
	self do: [:each |
		(each descendantOrSelfAxisAnySatisfy: aNodeTest)
			ifTrue: [^ true]].
	^ false.
]

{ #category : #enumerating }
XPathNodeSet >> difference: aNodeSet [
	^ (self copyWithoutAll: aNodeSet) sort
]

{ #category : #private }
XPathNodeSet >> filterEachInSeparateContextWith: aThreeArgumentBlockOrNumber [
	| copy |

	aThreeArgumentBlockOrNumber isNumber
		ifTrue: [
			copy :=
				aThreeArgumentBlockOrNumber asXPathNodeSetPosition = 1
					ifTrue: [self copy]
					ifFalse: [self copyEmpty]]
		ifFalse: [
			copy := self copyEmpty.
			1 to: self size do: [:i | | node result |
				node := self at: i.
				(result :=
					aThreeArgumentBlockOrNumber
						cull: node "context node"
						cull: 1 "context position"
						cull: 1) isNumber "context size"
						ifTrue: [
							result asXPathNodeSetPosition = 1
								ifTrue: [copy addLast: node]]
						ifFalse: [
							result asXPathBoolean
								ifTrue: [copy addLast: node]]]].
	"filtering cannot change the sort order"
	^ copy sortOrderFrom: self.
]

{ #category : #private }
XPathNodeSet >> filterEachInSeparateContextWithAll: aFilterCollection [
	^ self
		filterEachInSeparateContextWithAll: aFilterCollection
		startingAt: 1
]

{ #category : #private }
XPathNodeSet >> filterEachInSeparateContextWithAll: aFilterCollection startingAt: anIndex [
	| filteredNodeSet |

	filteredNodeSet := self.
	anIndex to: aFilterCollection size do: [:i |
		filteredNodeSet isEmpty
			ifTrue: [^ filteredNodeSet].
		filteredNodeSet :=
			filteredNodeSet filterEachInSeparateContextWith:
				(aFilterCollection at: i)].
	^ filteredNodeSet.
]

{ #category : #private }
XPathNodeSet >> filterWith: aThreeArgumentBlockOrNumber [
	| copy |

	copy := self copyEmpty.
	aThreeArgumentBlockOrNumber isNumber
		ifTrue: [
			(self at: aThreeArgumentBlockOrNumber asXPathNodeSetPosition)
				ifNotNil: [:node |
					copy addLast: node]]
		ifFalse: [| contextSize |
			contextSize := self size.
			1 to: contextSize do: [:i | | node result |
				node := self at: i.
				(result :=
					aThreeArgumentBlockOrNumber
						cull: node "context node"
						cull: i "context position"
						cull: contextSize) isNumber
					ifTrue: [
						result asXPathNodeSetPosition = i
							ifTrue: [copy addLast: node]]
					ifFalse: [
						result asXPathBoolean
							ifTrue: [copy addLast: node]]]].
	"filtering cannot change the sort order"
	^ copy sortOrderFrom: self.
]

{ #category : #private }
XPathNodeSet >> filterWithAll: aFilterCollection [
	^ self
		filterWithAll: aFilterCollection
		startingAt: 1
]

{ #category : #private }
XPathNodeSet >> filterWithAll: aFilterCollection startingAt: anIndex [
	| filteredNodeSet |

	filteredNodeSet := self.
	anIndex to: aFilterCollection size do: [:i |
		filteredNodeSet isEmpty
			ifTrue: [^ filteredNodeSet].
		filteredNodeSet :=
			filteredNodeSet filterWith: (aFilterCollection at: i)].
	^ filteredNodeSet.
]

{ #category : #accessing }
XPathNodeSet >> firstInDocumentOrder [
	^ self sortOrder firstInDocumentOrderFrom: self
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> followingAxis: aNodeTestStringOrBlock [
	^ self sortOrder
		on: self
		followingAxis: aNodeTestStringOrBlock
]

{ #category : #'enumerating - predicate axis' }
XPathNodeSet >> followingAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ self sortOrder
		on: self
		followingAxis: aNodeTestStringOrBlock
		predicates: aPredicateCollection
]

{ #category : #private }
XPathNodeSet >> followingAxisAnySatisfy: aNodeTest [
	self do: [:each |
		(each followingAxisAnySatisfy: aNodeTest)
			ifTrue: [^ true]].
	^ false.
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> followingSiblingAxis: aNodeTestStringOrBlock [
	^ self sortOrder
		on: self
		followingSiblingAxis: aNodeTestStringOrBlock
]

{ #category : #'enumerating - predicate axis' }
XPathNodeSet >> followingSiblingAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ self sortOrder
		on: self
		followingSiblingAxis: aNodeTestStringOrBlock
		predicates: aPredicateCollection
]

{ #category : #private }
XPathNodeSet >> followingSiblingAxisAnySatisfy: aNodeTest [
	self do: [:each |
		(each followingSiblingAxisAnySatisfy: aNodeTest)
			ifTrue: [^ true]].
	^ false.
]

{ #category : #testing }
XPathNodeSet >> includes: aNode [
	^ self set includes: aNode
]

{ #category : #enumerating }
XPathNodeSet >> intersection: aNodeSet [
	^ (self select: [:each | aNodeSet includes: each]) sort
]

{ #category : #private }
XPathNodeSet >> maximumStringValueNumber [
	| maximum |

	self do: [:each | | number |
		number := each stringValue asXPathNumber.
		maximum
			ifNil: [maximum := number]
			ifNotNil: [
				number > maximum
					ifTrue: [maximum := number]]].
	^ maximum.
]

{ #category : #private }
XPathNodeSet >> minimumStringValueNumber [
	| minimum |

	self do: [:each | | number |
		number := each stringValue asXPathNumber.
		minimum
			ifNil: [minimum := number]
			ifNotNil: [
				number < minimum
					ifTrue: [minimum := number]]].
	^ minimum.
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> namespaceAxis: aNodeTestStringOrBlock [
	^ self sortOrder
		on: self
		namespaceAxis: aNodeTestStringOrBlock
]

{ #category : #'enumerating - predicate axis' }
XPathNodeSet >> namespaceAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ self sortOrder
		on: self
		namespaceAxis: aNodeTestStringOrBlock
		predicates: aPredicateCollection
]

{ #category : #private }
XPathNodeSet >> namespaceAxisAnySatisfy: aNamespaceNodeTest [
	self do: [:each |
		(each namespaceAxisAnySatisfy: aNamespaceNodeTest)
			ifTrue: [^ true]].
	^ false.
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> parentAxis: aNodeTestStringOrBlock [
	^ self sortOrder
		on: self
		parentAxis: aNodeTestStringOrBlock
]

{ #category : #'enumerating - predicate axis' }
XPathNodeSet >> parentAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ self sortOrder
		on: self
		parentAxis: aNodeTestStringOrBlock
		predicates: aPredicateCollection
]

{ #category : #private }
XPathNodeSet >> parentAxisAnySatisfy: aNodeTest [
	self do: [:each |
		(each parentAxisAnySatisfy: aNodeTest)
			ifTrue: [^ true]].
	^ false.
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> precedingAxis: aNodeTestStringOrBlock [
	^ self sortOrder
		on: self
		precedingAxis: aNodeTestStringOrBlock
]

{ #category : #'enumerating - predicate axis' }
XPathNodeSet >> precedingAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ self sortOrder
		on: self
		precedingAxis: aNodeTestStringOrBlock
		predicates: aPredicateCollection
]

{ #category : #private }
XPathNodeSet >> precedingAxisAnySatisfy: aNodeTest [
	self do: [:each |
		(each precedingAxisAnySatisfy: aNodeTest)
			ifTrue: [^ true]].
	^ false.
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> precedingSiblingAxis: aNodeTestStringOrBlock [
	^ self sortOrder
		on: self
		precedingSiblingAxis: aNodeTestStringOrBlock
]

{ #category : #'enumerating - predicate axis' }
XPathNodeSet >> precedingSiblingAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ self sortOrder
		on: self
		precedingSiblingAxis: aNodeTestStringOrBlock
		predicates: aPredicateCollection
]

{ #category : #private }
XPathNodeSet >> precedingSiblingAxisAnySatisfy: aNodeTest [
	self do: [:each |
		(each precedingSiblingAxisAnySatisfy: aNodeTest)
			ifTrue: [^ true]].
	^ false.
]

{ #category : #enumerating }
XPathNodeSet >> reject: aBlock [
	"reject doesn't change sort order"
	^ (super reject: aBlock) sortOrderFrom: self
]

{ #category : #private }
XPathNodeSet >> reverseInPlace [
	| previousSortOrder start end |

	"saved because swap:with: clears the sort order"
	previousSortOrder := self sortOrder.
	start := 1.
	end := self size.
	[start < end]
		whileTrue: [
			self swap: start with: end.
			start := start + 1.
			end := end - 1].
	self sortOrder: previousSortOrder asReversedSortOrder.
]

{ #category : #converting }
XPathNodeSet >> reversed [
	^ super reversed sortOrder: self sortOrder asReversedSortOrder
]

{ #category : #enumerating }
XPathNodeSet >> select: aBlock [
	"select doesn't change sort order"
	^ (super select: aBlock) sortOrderFrom: self
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> selfAxis: aNodeTestStringOrBlock [
	^ self sortOrder
		on: self
		selfAxis: aNodeTestStringOrBlock
]

{ #category : #'enumerating - predicate axis' }
XPathNodeSet >> selfAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ self sortOrder
		on: self
		selfAxis: aNodeTestStringOrBlock
		predicates: aPredicateCollection
]

{ #category : #private }
XPathNodeSet >> selfAxisAnySatisfy: aNodeTest [
	self do: [:each |
		(each selfAxisAnySatisfy: aNodeTest)
			ifTrue: [^ true]].
	^ false.
]

{ #category : #private }
XPathNodeSet >> set [
	"IdentitySet is not used because namespace nodes implement ="
	^ set ifNil: [set := Set new: self capacity]
]

{ #category : #sorting }
XPathNodeSet >> sort [
	self sortOrder documentOrderSort: self
]

{ #category : #sorting }
XPathNodeSet >> sort: aSortBlock [
	super sort: aSortBlock.
	self sortOrder: nil.
]

{ #category : #private }
XPathNodeSet >> sortOrder [
	sortOrder
		ifNil: [
			self size > 1
				ifTrue: [sortOrder := XPathUnknownSortOrder new]
				ifFalse: [
					"safe for node sets with <= 1 node"
					sortOrder := XPathDocumentSortOrder new]].
	^ sortOrder.
]

{ #category : #private }
XPathNodeSet >> sortOrder: aSortOrder [
	sortOrder := aSortOrder
]

{ #category : #private }
XPathNodeSet >> sortOrderFrom: aNodeSet [
	sortOrder := aNodeSet sortOrder
]

{ #category : #accessing }
XPathNodeSet >> stringValue [
	"returns XPath string-value for the first node in document order"
	^ self asXPathString
]

{ #category : #accessing }
XPathNodeSet >> stringValues [
	"returns XPath string-values of nodes"
	^ self collect: [:each | each stringValue]
]

{ #category : #enumerating }
XPathNodeSet >> stringValuesDo: aBlock [
	"enumerates XPath string-values of nodes"
	self do: [:each | aBlock value: each stringValue]
]

{ #category : #accessing }
XPathNodeSet >> swap: aFirstIndex with: aSecondIndex [
	super
		swap: aFirstIndex
		with: aSecondIndex.
	self sortOrder: nil.
]

{ #category : #enumerating }
XPathNodeSet >> union: aNodeSet [
	"XPath node set union operator"
	^ self copy
		addAll: aNodeSet;
		sort
]

{ #category : #enumerating }
XPathNodeSet >> | aNodeSet [
	"redefined here for portability"
	^ self union: aNodeSet
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> ~ aNodeTestStringOrBlock [
	^ self selfAxis: aNodeTestStringOrBlock
]
