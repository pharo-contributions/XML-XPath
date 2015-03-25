"
An XPath node set is an ordered node list that has no duplicates. Node sets produced by XPath expression evaluation will be sorted in either document order or reverse document order.
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
XPathNodeSet class >> xPathNewFrom: anObject [
	"no conversions are specified from other types to node sets"
	(anObject isKindOf: XPathNodeSet)
		ifFalse: [self errorCannotConvert: anObject].
	^ anObject.
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> % aNodeTestStringOrBlock [
	"parent axis"
	self size > 1
		ifTrue: [
			^ self sortOrder
				parentAxisOn: self
				select: aNodeTestStringOrBlock asNodeTestBlock].
	self size = 1
		ifTrue: [^ self first % aNodeTestStringOrBlock].
	^ self copyEmpty.
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> %% aNodeTestStringOrBlock [
	"ancestor axis"
	self size > 1
		ifTrue: [
			^ self sortOrder
				ancestorAxisOn: self
				select: aNodeTestStringOrBlock asNodeTestBlock].
	self size = 1
		ifTrue: [^ self first %% aNodeTestStringOrBlock].
	^ self copyEmpty.
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> %%~ aNodeTestStringOrBlock [
	"ancestor-or-self axis"
	self size > 1
		ifTrue: [
			^ self sortOrder
				ancestorOrSelfAxisOn: self
				select: aNodeTestStringOrBlock asNodeTestBlock].
	self size = 1
		ifTrue: [^ self first %%~ aNodeTestStringOrBlock].
	^ self copyEmpty.
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> / aNodeTestStringOrBlock [
	"child axis"
	self size > 1
		ifTrue: [
			^ self sortOrder
				childAxisOn: self
				select: aNodeTestStringOrBlock asNodeTestBlock].
	self size = 1
		ifTrue: [^ self first / aNodeTestStringOrBlock].
	^ self copyEmpty.
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> // aNodeTestStringOrBlock [
	"descendant axis"
	self size > 1
		ifTrue: [
			^ self sortOrder
				descendantAxisOn: self
				select: aNodeTestStringOrBlock asNodeTestBlock].
	self size = 1
		ifTrue: [^ self first // aNodeTestStringOrBlock].
	^ self copyEmpty.
]

{ #category : #operators }
XPathNodeSet >> //!= anObject [
	^ anObject xPathNotEqualsNodeSet: self
]

{ #category : #operators }
XPathNodeSet >> //* anObject [
	^ self asXPathNumber * anObject asXPathNumber
]

{ #category : #operators }
XPathNodeSet >> //+ anObject [
	^ self asXPathNumber + anObject asXPathNumber
]

{ #category : #operators }
XPathNodeSet >> //- anObject [
	^ self asXPathNumber - anObject asXPathNumber
]

{ #category : #operators }
XPathNodeSet >> /// anObject [
	^ self asXPathNumber / anObject asXPathNumber
]

{ #category : #operators }
XPathNodeSet >> //< anObject [
	^ anObject xPathGreaterThanNodeSet: self
]

{ #category : #operators }
XPathNodeSet >> //<= anObject [
	^ (anObject xPathGreaterThanNodeSet: self)
		or: [anObject xPathEqualsNodeSet: self]
]

{ #category : #operators }
XPathNodeSet >> //= anObject [
	^ anObject xPathEqualsNodeSet: self
]

{ #category : #operators }
XPathNodeSet >> //> anObject [
	^ anObject xPathLessThanNodeSet: self
]

{ #category : #operators }
XPathNodeSet >> //>= anObject [
	^ (anObject xPathLessThanNodeSet: self)
		or: [anObject xPathEqualsNodeSet: self]
]

{ #category : #operators }
XPathNodeSet >> //\\ anObject [
	^ self asXPathNumber \\ anObject asXPathNumber
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> //~ aNodeTestStringOrBlock [
	"descendant-or-self axis"
	self size > 1
		ifTrue: [
			^ self sortOrder
				descendantOrSelfAxisOn: self
				select: aNodeTestStringOrBlock asNodeTestBlock].
	self size = 1
		ifTrue: [^ self first //~ aNodeTestStringOrBlock].
	^ self copyEmpty.
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> << aNodeTestStringOrBlock [
	"preceding axis"
	self size > 1
		ifTrue: [
			^ self sortOrder
				precedingAxisOn: self
				select: aNodeTestStringOrBlock asNodeTestBlock].
	self size = 1
		ifTrue: [^ self first << aNodeTestStringOrBlock].
	^ self copyEmpty.
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> <<< aNodeTestStringOrBlock [
	"preceding-sibling axis"
	self size > 1
		ifTrue: [
			^ self sortOrder
				precedingSiblingAxisOn: self
				select: aNodeTestStringOrBlock asNodeTestBlock].
	self size = 1
		ifTrue: [^ self first <<< aNodeTestStringOrBlock].
	^ self copyEmpty.
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> >> aNodeTestStringOrBlock [
	"following axis"
	self size > 1
		ifTrue: [
			^ self sortOrder
				followingAxisOn: self
				select: aNodeTestStringOrBlock asNodeTestBlock].
	self size = 1
		ifTrue: [^ self first >> aNodeTestStringOrBlock].
	^ self copyEmpty.
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> >>> aNodeTestStringOrBlock [
	"following-sibling axis"
	self size > 1
		ifTrue: [
			^ self sortOrder
				followingSiblingAxisOn: self
				select: aNodeTestStringOrBlock asNodeTestBlock].
	self size = 1
		ifTrue: [^ self first >>> aNodeTestStringOrBlock].
	^ self copyEmpty.
]

{ #category : #enumerating }
XPathNodeSet >> ?? aFilterBlockOrInteger [
	"filters with filter block or index"
	| nodeSet |

	nodeSet := self copyEmpty.
	aFilterBlockOrInteger isNumber
		ifTrue: [
			(self
				at: aFilterBlockOrInteger rounded
				ifAbsent: [nil])
				ifNotNil: [:node | nodeSet addLast: node].
			^ nodeSet].

	1 to: self size do: [:i | | node result |
		node := self at: i.
		(result := aFilterBlockOrInteger value: node value: i) isNumber
			ifTrue: [
				result rounded = i
					ifTrue: [nodeSet addLast: node]]
			ifFalse: [
				result asXPathBoolean
					ifTrue: [nodeSet addLast: node]]].

	^ nodeSet sortOrderFrom: self.
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> @ aNodeTestStringOrBlock [
	"attribute axis"
	self size > 1
		ifTrue: [
			^ self sortOrder
				attributeAxisOn: self
				select: aNodeTestStringOrBlock asNodeTestBlock].
	self size = 1
		ifTrue: [^ self first @ aNodeTestStringOrBlock].
	^ self copyEmpty.
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> @@ aNodeTestStringOrBlock [
	"namespace axis"
	self size > 1
		ifTrue: [
			^ self sortOrder
				namespaceAxisOn: self
				select: aNodeTestStringOrBlock asNodeTestBlock].
	self size = 1
		ifTrue: [^ self first @@ aNodeTestStringOrBlock].
	^ self copyEmpty.
]

{ #category : #private }
XPathNodeSet >> afterAdding: aNode at: anIndex [
	| oldSize |

	oldSize := self set size.
	((self set
		add: aNode;
		size) > oldSize)
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
		ifNotNil: [:node | node stringValue]
		ifNil: ['']
]

{ #category : #copying }
XPathNodeSet >> copy [
	"copies that don't add or replace have same sort order"
	^ super copy sortOrderFrom: self
]

{ #category : #copying }
XPathNodeSet >> copyFrom: aStartIndex to: anEndIndex [
	"copies that don't add or replace have same sort order"
	^ (super
		copyFrom: aStartIndex
		to: anEndIndex) sortOrderFrom: self
]

{ #category : #copying }
XPathNodeSet >> copyUpTo: anObject [
	"copies that don't add or replace have same sort order"
	^ (super copyUpTo: anObject) sortOrderFrom: self
]

{ #category : #copying }
XPathNodeSet >> copyUpToLast: anObject [
	"copies that don't add or replace have same sort order"
	^ (super copyUpToLast: anObject) sortOrderFrom: self
]

{ #category : #copying }
XPathNodeSet >> copyWithout: anObject [
	"copies that don't add or replace have same sort order"
	^ (super copyWithout: anObject) sortOrderFrom: self
]

{ #category : #copying }
XPathNodeSet >> copyWithoutAll: aCollection [
	"copies that don't add or replace have same sort order"
	^ (super copyWithoutAll: aCollection) sortOrderFrom: self
]

{ #category : #accessing }
XPathNodeSet >> firstInDocumentOrder [
	^ self sortOrder firstInDocumentOrderFrom: self
]

{ #category : #testing }
XPathNodeSet >> includes: aNode [
	^ self set includes: aNode
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
	self
		reverseInPlaceFrom: 1
		to: collection size
]

{ #category : #private }
XPathNodeSet >> reverseInPlaceFrom: aStart to: anEnd [
	| start end |

	start := aStart.
	end := anEnd.
	[start < end]
		whileTrue: [
			self swap: start with: end.
			start := start + 1.
			end := end - 1].
]

{ #category : #sorting }
XPathNodeSet >> reverseSort [
	self sortOrder reverseDocumentOrderSort: self
]

{ #category : #sorting }
XPathNodeSet >> reverseSorted [
	^ self copy reverseSort
]

{ #category : #enumerating }
XPathNodeSet >> select: aBlock [
	"select doesn't change sort order"
	^ (super select: aBlock) sortOrderFrom: self
]

{ #category : #private }
XPathNodeSet >> set [
	"IdentitySet is not used because namespace nodes implement ="
	^ set ifNil: [set := Set new: 5]
]

{ #category : #sorting }
XPathNodeSet >> sort [
	self sortOrder documentOrderSort: self
]

{ #category : #private }
XPathNodeSet >> sortOrder [
	sortOrder
		ifNil: [
			self size > 1
				ifTrue: [sortOrder := XPathUnknownSortOrder new]
				ifFalse: [sortOrder := XPathLevelDocumentSortOrder new]].
	^ sortOrder.
]

{ #category : #private }
XPathNodeSet >> sortOrder: aSortOrder [
	sortOrder := aSortOrder
]

{ #category : #private }
XPathNodeSet >> sortOrderFrom: aNodeSet [
	sortOrder := aNodeSet sortOrder copy
]

{ #category : #operators }
XPathNodeSet >> xPathEqualsBoolean: aBoolean [
	^ self asXPathBoolean = aBoolean
]

{ #category : #operators }
XPathNodeSet >> xPathEqualsNodeSet: aNodeSet [
	| stringValues |

	stringValues := Set new: self size.
	self do: [:each | stringValues add: each stringValue].
	^ aNodeSet anySatisfy: [:node | stringValues includes: node stringValue].
]

{ #category : #operators }
XPathNodeSet >> xPathEqualsNumber: aNumber [
	^ self anySatisfy: [:each | each stringValue asXPathNumber = aNumber]
]

{ #category : #operators }
XPathNodeSet >> xPathEqualsString: aString [
	^ self anySatisfy: [:each | each stringValue = aString]
]

{ #category : #operators }
XPathNodeSet >> xPathGreaterThanBoolean: aBoolean [
	^ self asXPathBoolean asXPathNumber > aBoolean asXPathNumber
]

{ #category : #operators }
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

{ #category : #operators }
XPathNodeSet >> xPathGreaterThanNumber: aNumber [
	^ self anySatisfy: [:each | each stringValue asXPathNumber > aNumber]
]

{ #category : #operators }
XPathNodeSet >> xPathGreaterThanString: aString [
	| number |

	number := aString asXPathNumber.
	^ self anySatisfy: [:each | each stringValue asXPathNumber > number]
]

{ #category : #operators }
XPathNodeSet >> xPathLessThanBoolean: aBoolean [
	^ self asXPathBoolean asXPathNumber < aBoolean asXPathNumber
]

{ #category : #operators }
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

{ #category : #operators }
XPathNodeSet >> xPathLessThanNumber: aNumber [
	^ self anySatisfy: [:each | each stringValue asXPathNumber < aNumber]
]

{ #category : #operators }
XPathNodeSet >> xPathLessThanString: aString [
	| number |

	number := aString asXPathNumber.
	^ self anySatisfy: [:each | each asXPathNumber < number]
]

{ #category : #operators }
XPathNodeSet >> xPathNotEqualsBoolean: aBoolean [
	^ self asXPathBoolean ~= aBoolean
]

{ #category : #operators }
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

{ #category : #operators }
XPathNodeSet >> xPathNotEqualsNumber: aNumber [
	^ self anySatisfy: [:each | each stringValue asXPathNumber ~= aNumber]
]

{ #category : #operators }
XPathNodeSet >> xPathNotEqualsString: aString [
	^ self anySatisfy: [:each | each stringValue ~= aString]
]

{ #category : #copying }
XPathNodeSet >> | aNodeSet [
	"XPath node set union"
	^ self copy
		addAll: aNodeSet;
		sort
]

{ #category : #'enumerating - axis' }
XPathNodeSet >> ~ aNodeTestStringOrBlock [
	"self axis"
	self size > 1
		ifTrue: [
			^ self sortOrder
				selfAxisOn: self
				select: aNodeTestStringOrBlock asNodeTestBlock].
	self size = 1
		ifTrue: [^ self first ~ aNodeTestStringOrBlock].
	^ self copyEmpty.
]
