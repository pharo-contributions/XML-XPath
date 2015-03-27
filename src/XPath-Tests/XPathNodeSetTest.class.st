Class {
	#name : #XPathNodeSetTest,
	#superclass : #XMLNodeListTest,
	#instVars : [
		'document'
	],
	#category : #'XPath-Tests'
}

{ #category : #testing }
XPathNodeSetTest >> allowsDuplicates [
	^ false
]

{ #category : #assertions }
XPathNodeSetTest >> assertHasUnknownSortOrder: aList [
	self
		assertList: aList
		hasSortOrder: XPathUnknownSortOrder
]

{ #category : #assertions }
XPathNodeSetTest >> assertList: aList copiedFrom: aSecondList equals: aThirdList [
	super
		assertList: aList
		copiedFrom: aSecondList
		equals: aThirdList.
	self
		assert: aList set size = aList size;
		assert: aList set = aThirdList set;
		deny: aList set == aSecondList set.
]

{ #category : #assertions }
XPathNodeSetTest >> assertList: aFirstList hasSameSortOrderAs: aSecondList [
	self assert: aFirstList sortOrder class == aSecondList sortOrder class
]

{ #category : #assertions }
XPathNodeSetTest >> assertList: aList hasSortOrder: aSortOrder [
	self assert: (aList sortOrder isKindOf: aSortOrder)
]

{ #category : #assertions }
XPathNodeSetTest >> assertList: aList isCopyOf: aSecondList [
	super assertList: aList isCopyOf: aSecondList.
	self
		assert: aList set size = aList size;
		assert: aList set = aSecondList set;
		deny: aList set == aSecondList set.
]

{ #category : #accessing }
XPathNodeSetTest >> listClass [
	^ XPathNodeSet
]

{ #category : #accessing }
XPathNodeSetTest >> listElements [
	| listElements |

	listElements := super listElements.
	document
		ifNil: [
			(document := XMLDocument new)
				addElementNamed: 'root'.
			document root addNodes: listElements].
	^ listElements.
	
]

{ #category : #accessing }
XPathNodeSetTest >> listWithSortOrder [
	^ self listWithElements sortOrder: XPathDocumentSortOrder new
]

{ #category : #accessing }
XPathNodeSetTest >> reverseSortBlock [
	^ [:a :b | b occursInDocumentBeforeNode: a]
]

{ #category : #accessing }
XPathNodeSetTest >> sortBlock [
	^ [:a :b | a = b or: [a occursInDocumentBeforeNode: b]]
]

{ #category : #tests }
XPathNodeSetTest >> testAdd [
	super testAdd.

	self assertHasUnknownSortOrder:
		(self listWithSortOrder
			add: self newElement;
			yourself).
]

{ #category : #tests }
XPathNodeSetTest >> testAddAfter [
	super testAddAfter.

	self assertHasUnknownSortOrder:
		(self listWithSortOrder
			add: self newElement after: self singleElement;
			yourself).
]

{ #category : #tests }
XPathNodeSetTest >> testAddAfterIndex [
	super testAddAfterIndex.

	self assertHasUnknownSortOrder:
		(self listWithSortOrder
			add: self newElement afterIndex: 1;
			yourself).
]

{ #category : #tests }
XPathNodeSetTest >> testAddAll [
	super testAddAll.

	self assertHasUnknownSortOrder:
		(self listWithSortOrder
			addAll: (Array with: self newElement);
			yourself).
]

{ #category : #tests }
XPathNodeSetTest >> testAddAllFirst [
	super testAddAllFirst.

	self assertHasUnknownSortOrder:
		(self listWithSortOrder
			addAllFirst: (Array with: self newElement);
			yourself).
]

{ #category : #tests }
XPathNodeSetTest >> testAddAllLast [
	super testAddAllLast.

	self assertHasUnknownSortOrder:
		(self listWithSortOrder
			addAllLast: (Array with: self newElement);
			yourself).
]

{ #category : #tests }
XPathNodeSetTest >> testAddBefore [
	super testAddBefore.

	self assertHasUnknownSortOrder:
		(self listWithSortOrder
			add: self newElement before: self singleElement;
			yourself).
]

{ #category : #tests }
XPathNodeSetTest >> testAddBeforeIndex [
	super testAddBeforeIndex.

	self assertHasUnknownSortOrder:
		(self listWithSortOrder
			add: self newElement beforeIndex: 1;
			yourself).
]

{ #category : #tests }
XPathNodeSetTest >> testAddFirst [
	super testAddFirst.

	self assertHasUnknownSortOrder:
		(self listWithSortOrder
			addFirst: self newElement;
			yourself).
]

{ #category : #tests }
XPathNodeSetTest >> testAddLast [
	super testAddLast.

	self assertHasUnknownSortOrder:
		(self listWithSortOrder
			addLast: self newElement;
			yourself).
]

{ #category : #tests }
XPathNodeSetTest >> testAllButFirst [
	| list |

	super testAllButFirst.

	list := self listWithSortOrder.
	self
		assertList: list allButFirst
		hasSameSortOrderAs: list.
]

{ #category : #tests }
XPathNodeSetTest >> testAllButFirstFew [
	| list |

	super testAllButFirstFew.

	list := self listWithSortOrder.
	self
		assertList: (list allButFirst: 1)
		hasSameSortOrderAs: list.
]

{ #category : #tests }
XPathNodeSetTest >> testAllButLast [
	| list |

	super testAllButLast.

	list := self listWithSortOrder.
	self
		assertList: list allButLast
		hasSameSortOrderAs: list.
]

{ #category : #tests }
XPathNodeSetTest >> testAllButLastFew [
	| list |

	super testAllButLastFew.

	list := self listWithSortOrder.
	self
		assertList: (list allButLast: 1)
		hasSameSortOrderAs: list.
]

{ #category : #tests }
XPathNodeSetTest >> testAsXPathBoolean [
	self
		deny: self emptyList asXPathBoolean;
		assert: self listWithSingleElement asXPathBoolean
]

{ #category : #tests }
XPathNodeSetTest >> testAsXPathString [
	self
		assert: self emptyList asXPathString isEmpty;
		assert: self listWithElements asXPathString = self singleElement stringValue;
		assert: self listWithElements reversed asXPathString = self singleElement stringValue
]

{ #category : #tests }
XPathNodeSetTest >> testAtPut [
	super testAtPut.

	self assertHasUnknownSortOrder:
		(self listWithSortOrder
			at: 1 put: self newElement;
			yourself).
]

{ #category : #tests }
XPathNodeSetTest >> testCopy [
	| list |

	super testCopy.

	list := self listWithSortOrder.
	self assertList: list copy hasSameSortOrderAs: list.
]

{ #category : #tests }
XPathNodeSetTest >> testCopyAfter [
	| list |

	super testCopyAfter.

	list := self listWithSortOrder.
	self
		assertList: (list copyAfter: list first)
		hasSameSortOrderAs: list.
]

{ #category : #tests }
XPathNodeSetTest >> testCopyAfterLast [
	| list |

	super testCopyAfterLast.

	list := self listWithSortOrder.
	self
		assertList: (list copyAfterLast: list first)
		hasSameSortOrderAs: list.
]

{ #category : #tests }
XPathNodeSetTest >> testCopyEmpty [
	| list |

	super testCopyEmpty.

	list := self listWithSortOrder.
	self
		assertList: list copyEmpty
		hasSameSortOrderAs: self emptyList.
]

{ #category : #tests }
XPathNodeSetTest >> testCopyFromTo [
	| list |

	super testCopyFromTo.

	list := self listWithSortOrder.
	self
		assertList: (list copyFrom: 1 to: list size)
		hasSameSortOrderAs: list.
]

{ #category : #tests }
XPathNodeSetTest >> testCopyReplaceAllWith [
	| list |

	super testCopyReplaceAllWith.

	list := self listWithSortOrder.
	self assertHasUnknownSortOrder:
		(list
			copyReplaceAll: self listElements
			with: self listElements).
]

{ #category : #tests }
XPathNodeSetTest >> testCopyReplaceFromToWith [
	| list |

	super testCopyReplaceFromToWith.

	list := self listWithSortOrder.
	self assertHasUnknownSortOrder:
		(list
			copyReplaceFrom: 1
			to: list size
			with: self listElements).
]

{ #category : #tests }
XPathNodeSetTest >> testCopyUpTo [
	| list |

	super testCopyUpTo.

	list := self listWithSortOrder.
	self
		assertList: (list copyUpTo: list last)
		hasSameSortOrderAs: list.
]

{ #category : #tests }
XPathNodeSetTest >> testCopyUpToLast [
	| list |

	super testCopyUpToLast.

	list := self listWithSortOrder.
	self
		assertList: (list copyUpToLast: list last)
		hasSameSortOrderAs: list.
]

{ #category : #tests }
XPathNodeSetTest >> testCopyWith [
	| list |

	super testCopyWith.

	list := self listWithSortOrder.
	self assertHasUnknownSortOrder: (list copyWith: self newElement).
]

{ #category : #tests }
XPathNodeSetTest >> testCopyWithFirst [
	| list |

	super testCopyWithFirst.

	list := self listWithSortOrder.
	self assertHasUnknownSortOrder: (list copyWithFirst: self newElement).
]

{ #category : #tests }
XPathNodeSetTest >> testCopyWithout [
	| list |

	super testCopyWithout.

	list := self listWithSortOrder.
	self
		assertList: (list copyWithout: self singleElement)
		hasSameSortOrderAs: list.
]

{ #category : #tests }
XPathNodeSetTest >> testCopyWithoutAll [
	| list |

	super testCopyWithoutAll.

	list := self listWithSortOrder.
	self
		assertList: (list copyWithoutAll: (Array with: self singleElement))
		hasSameSortOrderAs: list.
]

{ #category : #tests }
XPathNodeSetTest >> testDefaultSortOrder [
	self
		assertList: self emptyList hasSortOrder: XPathLevelDocumentSortOrder;
		assertList: self listWithSingleElement hasSortOrder: XPathLevelDocumentSortOrder;
		assertHasUnknownSortOrder: self listWithElements
]

{ #category : #tests }
XPathNodeSetTest >> testDifference [
	self assert:
		(self listWithElements \ self listWithElements) =
			self emptyList.
	self assert:
		(self listWithElements reversed \ self emptyList) =
			self listWithElements.
	self assert:
		(self listWithElements \ self listWithSingleElement) =
			self listWithElements allButFirst.
	self assert:
		(self listWithElements reversed \
			(self listElements select: [:each | each isElement])) =
				(self listWithElements reject: [:each | each isElement]).
]

{ #category : #tests }
XPathNodeSetTest >> testFirstFew [
	| list |

	super testFirstFew.

	list := self listWithSortOrder.
	self
		assertList: (list first: list size)
		hasSameSortOrderAs: list.
]

{ #category : #tests }
XPathNodeSetTest >> testFirstInDocumentOrder [
	self
		assert: self emptyList firstInDocumentOrder isNil;
		assert: self listWithSingleElement firstInDocumentOrder = self singleElement;
		assert: self listWithElements firstInDocumentOrder = self listElements first;
		assert: self listWithElements reversed firstInDocumentOrder = self listElements first
]

{ #category : #tests }
XPathNodeSetTest >> testIntersection [
	self assert:
		(self listWithElements reversed & self listWithElements) =
			self listWithElements.
	self assert:
		(self listWithElements & self emptyList) =
			self emptyList.
	self assert:
		(self listWithSingleElement & self listWithElements reversed) =
			self listWithSingleElement.
	self assert:
		(self listWithElements &
			(self listWithElements select: [:each | each isElement])) =
				(self listWithElements select: [:each | each isElement])
]

{ #category : #tests }
XPathNodeSetTest >> testLastFew [
	| list |

	super testLastFew.

	list := self listWithSortOrder.
	self
		assertList: (list last: list size)
		hasSameSortOrderAs: list.
]

{ #category : #tests }
XPathNodeSetTest >> testReject [
	| list |

	super testReject.

	list := self listWithSortOrder.
	self
		assertList: (list reject: [:each | false])
		hasSameSortOrderAs: list.
]

{ #category : #tests }
XPathNodeSetTest >> testRemoveAll [
	| list |

	super testRemoveAll.

	(list := self listWithSortOrder) removeAll.
	self
		assertList: list
		hasSameSortOrderAs: self listWithSortOrder.
]

{ #category : #tests }
XPathNodeSetTest >> testRemoveFirst [
	| list |

	super testRemoveFirst.

	(list := self listWithSortOrder) removeFirst.
	self
		assertList: list
		hasSameSortOrderAs: self listWithSortOrder.
]

{ #category : #tests }
XPathNodeSetTest >> testRemoveFirstFew [
	| list |

	super testRemoveFirstFew.

	(list := self listWithSortOrder) removeFirst: 1.
	self
		assertList: list
		hasSameSortOrderAs: self listWithSortOrder.
]

{ #category : #tests }
XPathNodeSetTest >> testRemoveIfAbsent [
	| list |

	super testRemoveIfAbsent.

	(list := self listWithSortOrder)
		remove: self absentElement ifAbsent: [nil];
		remove: self singleElement ifAbsent: [nil].
	self
		assertList: list
		hasSameSortOrderAs: self listWithSortOrder.
]

{ #category : #tests }
XPathNodeSetTest >> testRemoveLast [
	| list |

	super testRemoveLast.

	(list := self listWithSortOrder) removeLast.
	self
		assertList: list
		hasSameSortOrderAs: self listWithSortOrder.
]

{ #category : #tests }
XPathNodeSetTest >> testRemoveLastFew [
	| list |

	super testRemoveLastFew.

	(list := self listWithSortOrder) removeLast: 1.
	self
		assertList: list
		hasSameSortOrderAs: self listWithSortOrder.
]

{ #category : #tests }
XPathNodeSetTest >> testReplaceFromToWith [
	| list |

	super testReplaceFromToWith.

	(list := self listWithSortOrder)
		replaceFrom: 1
		to: list size
		with: self listElements.
	self assertHasUnknownSortOrder: list.
]

{ #category : #tests }
XPathNodeSetTest >> testReplaceFromToWithStartingAt [
	| list |

	super testReplaceFromToWithStartingAt.

	(list := self listWithSortOrder)
		replaceFrom: 1
		to: list size
		with: self listElements
		startingAt: 1.
	self assertHasUnknownSortOrder: list.
]

{ #category : #tests }
XPathNodeSetTest >> testReverseSort [
	| list |

	list := self listWithElements.
	self
		assert: list reverseSort == list;
		assert: list = self listWithElements reversed;
		assertList: list hasSortOrder: XPathReverseDocumentSortOrder.
]

{ #category : #tests }
XPathNodeSetTest >> testReverseSorted [
	| list reverseSorted |

	list := self listWithElements.
	reverseSorted := self listWithElements reverseSorted.
	self
		assertList: reverseSorted
		copiedFrom: list
		equals: self listWithElements reversed.
	self assertList: reverseSorted hasSortOrder: XPathReverseDocumentSortOrder.
]

{ #category : #tests }
XPathNodeSetTest >> testSelect [
	| list |

	super testSelect.

	list := self listWithSortOrder.
	self
		assertList: (list select: [:each | true])
		hasSameSortOrderAs: list.
]

{ #category : #tests }
XPathNodeSetTest >> testSort [
	super testSort.

	self
		assertList: self listWithElements sort
		hasSortOrder: XPathDocumentSortOrder.
]

{ #category : #tests }
XPathNodeSetTest >> testSorted [
	super testSorted.

	self
		assertList: self listWithElements sorted
		hasSortOrder: XPathDocumentSortOrder.
]

{ #category : #tests }
XPathNodeSetTest >> testStringValues [
	self
		assert: self emptyList stringValues isEmpty;
		assert:
			self listWithElements stringValues =
				(self listWithElements collect: [:each | each stringValue])
]

{ #category : #tests }
XPathNodeSetTest >> testStringValuesDo [
	| list |

	list := self emptyList.
	self
		should: [:block | list stringValuesDo: block]
		enumerate: #().

	list := self listWithElements.
	self
		should: [:block | list stringValuesDo: block]
		enumerate: (self listWithElements collect: [:each | each stringValue]).
]

{ #category : #tests }
XPathNodeSetTest >> testSwapWith [
	| list |

	super testSwapWith.

	(list := self listWithSortOrder)
		swap: 1
		with: list size.
	self assertHasUnknownSortOrder: list.
]

{ #category : #tests }
XPathNodeSetTest >> testUnion [
	self assert:
		(self listWithElements | self listWithElements reversed) =
			self listWithElements.
	self assert:
		(self listWithElements | self emptyList) =
			self listWithElements.
	self assert:
		(self listWithSingleElement | self listWithElements reversed) =
			self listWithElements.
	self assert:
		((self listWithElements select: [:each | each isElement]) reversed |
			(self listWithElements reject: [:each | each isElement])) =
				self listWithElements.
]
