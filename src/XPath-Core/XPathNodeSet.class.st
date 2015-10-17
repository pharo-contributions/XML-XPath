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

{ #category : #private }
XPathNodeSet class >> errorCannotConvert: anObject [
	XPathTypeException
		formatSignal: 'Cannot convert object of class {1} to node set'
		with: anObject class name
]

{ #category : #'instance creation' }
XPathNodeSet class >> new [
	^ self new: 10
]

{ #category : #'instance creation' }
XPathNodeSet class >> xPathNewFrom: anObject [
	"no conversions are specified from other types to node sets"
	(anObject isKindOf: XPathNodeSet)
		ifFalse: [self errorCannotConvert: anObject].
	^ anObject.
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> % aStringOrBlockOrNodeTestWithFilters [
	"parent axis"
	^ self sortOrder
		parentAxisOn: self
		select: aStringOrBlockOrNodeTestWithFilters
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> %% aStringOrBlockOrNodeTestWithFilters [
	"ancestor axis"
	^ self sortOrder
		ancestorAxisOn: self
		select: aStringOrBlockOrNodeTestWithFilters
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> %%~ aStringOrBlockOrNodeTestWithFilters [
	"ancestor-or-self axis"
	^ self sortOrder
		ancestorOrSelfAxisOn: self
		select: aStringOrBlockOrNodeTestWithFilters
]

{ #category : #enumerating }
XPathNodeSet >> & aNodeSet [
	"redefined here for portability"
	^ self intersection: aNodeSet
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> / aStringOrBlockOrNodeTestWithFilters [
	"child axis"
	^ self sortOrder
		childAxisOn: self
		select: aStringOrBlockOrNodeTestWithFilters
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> // aStringOrBlockOrNodeTestWithFilters [
	"descendant axis"
	^ self sortOrder
		descendantAxisOn: self
		select: aStringOrBlockOrNodeTestWithFilters
]

{ #category : #private }
XPathNodeSet >> //!= anObject [
	^ anObject xPathNotEqualsNodeSet: self
]

{ #category : #private }
XPathNodeSet >> //* anObject [
	^ self asXPathNumber * anObject asXPathNumber
]

{ #category : #private }
XPathNodeSet >> //+ anObject [
	^ self asXPathNumber + anObject asXPathNumber
]

{ #category : #private }
XPathNodeSet >> //- anObject [
	^ self asXPathNumber - anObject asXPathNumber
]

{ #category : #private }
XPathNodeSet >> /// anObject [
	^ self asXPathNumber / anObject asXPathNumber
]

{ #category : #private }
XPathNodeSet >> //< anObject [
	^ anObject xPathGreaterThanNodeSet: self
]

{ #category : #private }
XPathNodeSet >> //<= anObject [
	^ (anObject xPathGreaterThanNodeSet: self)
		or: [anObject xPathEqualsNodeSet: self]
]

{ #category : #private }
XPathNodeSet >> //= anObject [
	^ anObject xPathEqualsNodeSet: self
]

{ #category : #private }
XPathNodeSet >> //> anObject [
	^ anObject xPathLessThanNodeSet: self
]

{ #category : #private }
XPathNodeSet >> //>= anObject [
	^ (anObject xPathLessThanNodeSet: self)
		or: [anObject xPathEqualsNodeSet: self]
]

{ #category : #private }
XPathNodeSet >> //? aThreeArgumentBlockOrNumber [
	^ self sort filterWith: aThreeArgumentBlockOrNumber
]

{ #category : #private }
XPathNodeSet >> //\\ anObject [
	^ self asXPathNumber \\ anObject asXPathNumber
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> //~ aStringOrBlockOrNodeTestWithFilters [
	"descendant-or-self axis"
	^ self sortOrder
		descendantOrSelfAxisOn: self
		select: aStringOrBlockOrNodeTestWithFilters
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> << aStringOrBlockOrNodeTestWithFilters [
	"preceding axis"
	^ self sortOrder
		precedingAxisOn: self
		select: aStringOrBlockOrNodeTestWithFilters
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> <<< aStringOrBlockOrNodeTestWithFilters [
	"preceding-sibling axis"
	^ self sortOrder
		precedingSiblingAxisOn: self
		select: aStringOrBlockOrNodeTestWithFilters
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> >> aStringOrBlockOrNodeTestWithFilters [
	"following axis"
	^ self sortOrder
		followingAxisOn: self
		select: aStringOrBlockOrNodeTestWithFilters
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> >>> aStringOrBlockOrNodeTestWithFilters [
	"following-sibling axis"
	^ self sortOrder
		followingSiblingAxisOn: self
		select: aStringOrBlockOrNodeTestWithFilters
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> @ aStringOrBlockOrNodeTestWithFilters [
	"attribute axis"
	^ self sortOrder
		attributeAxisOn: self
		select: aStringOrBlockOrNodeTestWithFilters
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> @@ aStringOrBlockOrNodeTestWithFilters [
	"namespace axis"
	^ self sortOrder
		namespaceAxisOn: self
		select: aStringOrBlockOrNodeTestWithFilters
]

{ #category : #enumerating }
XPathNodeSet >> \ aNodeSet [
	"redefined here for portability"
	^ self difference: aNodeSet
]

{ #category : #private }
XPathNodeSet >> addAllIfNotPresentTo: aCollection [
	"this inverts addAll: because addAll: uses do: and to:do: is needed for speed
	and an includes: test avoids adding an already present element to the end of
	a node set which requires left shifting everything after it by one"
	1 to: self size do: [:i | | node |
		node := self at: i.
		(aCollection includes: node)
			ifFalse: [aCollection addLast: node]]
]

{ #category : #private }
XPathNodeSet >> addAllTo: aCollection [
	"this inverts addAll: because addAll: uses do: and to:do: is needed for speed"
	1 to: self size do: [:i | aCollection addLast: (self at: i)]
]

{ #category : #private }
XPathNodeSet >> afterAdding: aNode at: anIndex [
	| oldSize |

	oldSize := self set size.
	(self set
		add: aNode;
		size) > oldSize
		ifFalse: [self movedNode: aNode to: anIndex].
	sortOrder := nil.
	super
		afterAdding: aNode
		at: anIndex.
]

{ #category : #private }
XPathNodeSet >> afterAddingLast: aNode [
	| oldSize |

	oldSize := self set size.
	(self set
		add: aNode;
		size) > oldSize
		ifFalse: [self movedNode: aNode to: oldSize].
	sortOrder := nil.
	super afterAddingLast: aNode.
]

{ #category : #private }
XPathNodeSet >> afterRemoving: aNode [
	self set remove: aNode.
	"removing does not change order"
	super afterRemoving: aNode.
]

{ #category : #converting }
XPathNodeSet >> asXPathBoolean [
	^ self notEmpty
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

{ #category : #enumerating }
XPathNodeSet >> difference: aNodeSet [
	^ (self copyWithoutAll: aNodeSet) sort
]

{ #category : #private }
XPathNodeSet >> filterEachInSeparateContextWith: aThreeArgumentBlockOrNumber [
	| copy |

	aThreeArgumentBlockOrNumber isNumber
		ifTrue: [
			aThreeArgumentBlockOrNumber rounded = 1
				ifTrue: [copy := self]
				ifFalse: [copy := self copyEmpty]]
		ifFalse: [
			copy := self copyEmpty.
			1 to: self size do: [:i | | node result |
				node := self at: i.
				(result :=
					aThreeArgumentBlockOrNumber
						value: node
						value: 1
						value: 1) isNumber
						ifTrue: [
							result rounded = 1
								ifTrue: [copy addLast: node]]
						ifFalse: [
							result asXPathBoolean
								ifTrue: [copy addLast: node]]]].
	"filtering cannot change the sort order"
	^ copy sortOrderFrom: self.
]

{ #category : #private }
XPathNodeSet >> filterEachInSeparateContextWithAll: aFilterCollection [
	| filteredNodeSet |

	filteredNodeSet := self.
	"to:do: for speed"
	1 to: aFilterCollection size do: [:i |
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
			copy addLast:
				(self
					at: aThreeArgumentBlockOrNumber rounded
					ifAbsent: [^ copy])]
		ifFalse: [| contextSize |
			contextSize := self size.
			1 to: contextSize do: [:i | | node result |
				node := self at: i.
				(result :=
					aThreeArgumentBlockOrNumber
						value: node
						value: i
						value: contextSize) isNumber
					ifTrue: [
						result rounded = i
							ifTrue: [copy addLast: node]]
					ifFalse: [
						result asXPathBoolean
							ifTrue: [copy addLast: node]]]].
	"filtering cannot change the sort order"
	^ copy sortOrderFrom: self.
]

{ #category : #private }
XPathNodeSet >> filterWithAll: aFilterCollection [
	| filteredNodeSet |

	filteredNodeSet := self.
	"to:do: for speed"
	1 to: aFilterCollection size do: [:i |
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

{ #category : #testing }
XPathNodeSet >> includes: aNode [
	^ self set includes: aNode
]

{ #category : #enumerating }
XPathNodeSet >> intersection: aNodeSet [
	^ (self select: [:each | aNodeSet includes: each]) sort
]

{ #category : #private }
XPathNodeSet >> movedNode: aNode to: anIndex [
	| i |

	(i :=
		self
			indexOf: aNode
			otherThan: anIndex) > 0
		ifTrue: [
			"since a node is just being moved, the collection
			is changed directly without notifying observers"
			collection removeAt: i]
]

{ #category : #enumerating }
XPathNodeSet >> reject: aBlock [
	"reject doesn't change sort order"
	^ (super reject: aBlock) sortOrderFrom: self
]

{ #category : #private }
XPathNodeSet >> reverseInPlace [
	| start end |

	start := 1.
	end := self size.
	[start < end]
		whileTrue: [
			self swap: start with: end.
			start := start + 1.
			end := end - 1].
]

{ #category : #enumerating }
XPathNodeSet >> select: aBlock [
	"select doesn't change sort order"
	^ (super select: aBlock) sortOrderFrom: self
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

{ #category : #private }
XPathNodeSet >> xPathEqualsBoolean: aBoolean [
	^ self asXPathBoolean = aBoolean
]

{ #category : #private }
XPathNodeSet >> xPathEqualsNodeSet: aNodeSet [
	| stringValues |

	stringValues := Set new: self size.
	self do: [:each | stringValues add: each stringValue].
	^ aNodeSet anySatisfy: [:node | stringValues includes: node stringValue].
]

{ #category : #private }
XPathNodeSet >> xPathEqualsNumber: aNumber [
	^ self anySatisfy: [:each | each stringValue asXPathNumber = aNumber]
]

{ #category : #private }
XPathNodeSet >> xPathEqualsString: aString [
	^ self anySatisfy: [:each | each stringValue = aString]
]

{ #category : #private }
XPathNodeSet >> xPathGreaterThanBoolean: aBoolean [
	^ self asXPathBoolean asXPathNumber > aBoolean asXPathNumber
]

{ #category : #private }
XPathNodeSet >> xPathGreaterThanNodeSet: aNodeSet [
	| least |

	aNodeSet do: [:each | | number |
		number := each stringValue asXPathNumber.
		(least isNil
			or: [number < least])
			ifTrue: [least := number]].
	^ least notNil
		and: [self anySatisfy: [:each | each stringValue asXPathNumber > least]].
]

{ #category : #private }
XPathNodeSet >> xPathGreaterThanNumber: aNumber [
	^ self anySatisfy: [:each | each stringValue asXPathNumber > aNumber]
]

{ #category : #private }
XPathNodeSet >> xPathGreaterThanString: aString [
	| number |

	number := aString asXPathNumber.
	^ self anySatisfy: [:each | each stringValue asXPathNumber > number]
]

{ #category : #private }
XPathNodeSet >> xPathLessThanBoolean: aBoolean [
	^ self asXPathBoolean asXPathNumber < aBoolean asXPathNumber
]

{ #category : #private }
XPathNodeSet >> xPathLessThanNodeSet: aNodeSet [
	| greatest |

	aNodeSet do: [:each | | number |
		number := each stringValue asXPathNumber.
		(greatest isNil
			or: [number > greatest])
			ifTrue: [greatest := number]].
	^ greatest notNil
		and: [self anySatisfy: [:each | each stringValue asXPathNumber < greatest]].
]

{ #category : #private }
XPathNodeSet >> xPathLessThanNumber: aNumber [
	^ self anySatisfy: [:each | each stringValue asXPathNumber < aNumber]
]

{ #category : #private }
XPathNodeSet >> xPathLessThanString: aString [
	| number |

	number := aString asXPathNumber.
	^ self anySatisfy: [:each | each asXPathNumber < number]
]

{ #category : #private }
XPathNodeSet >> xPathNotEqualsBoolean: aBoolean [
	^ self asXPathBoolean ~= aBoolean
]

{ #category : #private }
XPathNodeSet >> xPathNotEqualsNodeSet: aNodeSet [
	| stringValues |

	"should return true according to spec when aNodeSet and self each have at least
	one node that don't have the same string-values"
	stringValues := self collect: [:each | each stringValue].
	aNodeSet do: [:node | | stringValue |
		stringValue := node stringValue.
		stringValues do: [:each |
			each = stringValue
				ifFalse: [^ true]]].
	^ false.
]

{ #category : #private }
XPathNodeSet >> xPathNotEqualsNumber: aNumber [
	^ self anySatisfy: [:each | each stringValue asXPathNumber ~= aNumber]
]

{ #category : #private }
XPathNodeSet >> xPathNotEqualsString: aString [
	^ self anySatisfy: [:each | each stringValue ~= aString]
]

{ #category : #enumerating }
XPathNodeSet >> | aNodeSet [
	"redefined here for portability"
	^ self union: aNodeSet
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> ~ aStringOrBlockOrNodeTestWithFilters [
	"self axis"
	^ self sortOrder
		selfAxisOn: self
		select: aStringOrBlockOrNodeTestWithFilters
]
