Extension { #name : #XMLNodeWithElementsTest }

{ #category : #'*XPath-Tests' }
XMLNodeWithElementsTest >> testAncestorAxis [
	| nodeWithElements |

	super testAncestorAxis.

	nodeWithElements := self newNodeWithElements.
	nodeWithElements allNodesDo: [:each | | list |
		list := each %% 'node()'.
		self
			assert: list = each ancestorNodes;
			assertList: list hasSortOrder: XPathReverseDocumentSortOrder.

		list := each %% '*'.
		self
			assert: list = each ancestorElements;
			assertList: list hasSortOrder: XPathReverseDocumentSortOrder].
]

{ #category : #'*XPath-Tests' }
XMLNodeWithElementsTest >> testAncestorOrSelfAxis [
	| nodeWithElements |

	super testAncestorOrSelfAxis.

	nodeWithElements := self newNodeWithElements.
	nodeWithElements allNodesDo: [:each | | list |
		list := each %%~ 'node()'.
		self
			assert: list = (each ancestorNodes copyWithFirst: each);
			assertList: list hasSortOrder: XPathReverseDocumentSortOrder.

		list := each %%~ '*'.
		each isElement
			ifTrue: [self assert: list = (each ancestorElements copyWithFirst: each)]
			ifFalse: [self assert: list = each ancestorElements].
		self assertList: list hasSortOrder: XPathReverseDocumentSortOrder].
]

{ #category : #'*XPath-Tests' }
XMLNodeWithElementsTest >> testChildAxis [
	| nodeWithElements |

	super testChildAxis.

	nodeWithElements := self newNodeWithElements.
	nodeWithElements allNodesDo: [:each |
		each hasChildren
			ifTrue: [| list |
				list := each / 'node()'.
				self
					assert: list = each nodes;
					assertList: list hasSortOrder: XPathDocumentSortOrder.

				list := each / '*'.
				self
					assert: list = each elements;
					assertList: list hasSortOrder: XPathDocumentSortOrder.]
			ifFalse: [
				self
					assert: (each / 'node()') isEmpty;
					assert: (each / '*') isEmpty]].
]

{ #category : #'*XPath-Tests' }
XMLNodeWithElementsTest >> testDescendantAxis [
	| nodeWithElements |

	super testDescendantAxis.

	nodeWithElements := self newNodeWithElements.
	nodeWithElements allNodesDo: [:each |
		each hasChildren
			ifTrue: [| list |
				list := each // 'node()'.
				self
					assert: list = each descendantNodes;
					assertList: list hasSortOrder: XPathDocumentSortOrder.

				list := each // '*'.
				self
					assert: list = each descendantElements;
					assertList: list hasSortOrder: XPathDocumentSortOrder]
			ifFalse: [
				self
					assert: (each // 'node()') isEmpty;
					assert: (each // '*') isEmpty]].
]

{ #category : #'*XPath-Tests' }
XMLNodeWithElementsTest >> testDescendantOrSelfAxis [
	| nodeWithElements |

	super testDescendantOrSelfAxis.

	nodeWithElements := self newNodeWithElements.
	nodeWithElements allNodesDo: [:each |
		each hasChildren
			ifTrue: [| list |
				list := each //~ 'node()'.
				self
					assert: list = (each descendantNodes copyWithFirst: each);
					assertList: list hasSortOrder: XPathDocumentSortOrder.

				list := each //~ '*'.
				each isElement
					ifTrue: [self assert: list = (each descendantElements copyWithFirst: each)]
					ifFalse: [self assert: list = each descendantElements].
				self assertList: list hasSortOrder: XPathDocumentSortOrder]
			ifFalse: [
				self assert: (each //~ 'node()') = (self nodeSetClass with: each).
				each isElement
					ifTrue: [self assert: (each //~ '*') = (self nodeSetClass with: each)]
					ifFalse: [self assert: (each //~ '*') isEmpty]]].
]

{ #category : #'*XPath-Tests' }
XMLNodeWithElementsTest >> testFollowingAxis [
	| nodeWithElements |

	super testFollowingAxis.

	nodeWithElements := self newNodeWithElements.
	nodeWithElements allNodesDo: [:each | | list followingNodes |
		list := each >> 'node()'.
		followingNodes := 
			each hasParent
				ifTrue: [
					each parent descendantNodes copyAfter:
						(each hasChildren
							ifTrue: [each descendantNodes last]
							ifFalse: [each])]
				ifFalse: [self newNodeSet].
		self
			assert: list = followingNodes;
			assertList: list hasSortOrder: XPathDocumentSortOrder.

		list := each >> '*'.
		self
			assert: list = followingNodes elements;
			assertList: list hasSortOrder: XPathDocumentSortOrder].
]

{ #category : #'*XPath-Tests' }
XMLNodeWithElementsTest >> testFollowingSiblingAxis [
	| nodeWithElements |

	super testFollowingSiblingAxis.

	nodeWithElements := self newNodeWithElements.
	nodeWithElements allNodesDo: [:each | | list followingSiblings |
		list := each >>> 'node()'.
		followingSiblings :=
			each hasParent
				ifTrue: [each parent nodes copyAfter: each]
				ifFalse: [self newNodeSet].
		self
			assert: list = followingSiblings;
			assertList: list hasSortOrder: XPathDocumentSortOrder.

		list := each >>> '*'.
		self
			assert: list = followingSiblings elements;
			assertList: list hasSortOrder: XPathDocumentSortOrder].
]

{ #category : #'*XPath-Tests' }
XMLNodeWithElementsTest >> testPrecedingAxis [
	| nodeWithElements |

	super testPrecedingAxis.

	nodeWithElements := self newNodeWithElements.
	nodeWithElements allNodesDo: [:each | | list precedingNodes |
		list := each << 'node()'.
		precedingNodes :=
			each hasParent
				ifTrue: [(each parent descendantNodes copyUpTo: each) reversed]
				ifFalse: [self newNodeSet].
		self
			assert: list = precedingNodes;
			assertList: list hasSortOrder: XPathReverseDocumentSortOrder.

		list := each << '*'.
		self
			assert: list = precedingNodes elements;
			assertList: list hasSortOrder: XPathReverseDocumentSortOrder].
]

{ #category : #'*XPath-Tests' }
XMLNodeWithElementsTest >> testPrecedingSiblingAxis [
	| nodeWithElements |

	super testPrecedingSiblingAxis.

	nodeWithElements := self newNodeWithElements.
	nodeWithElements allNodesDo: [:each | | list precedingSiblings |
		list := each <<< 'node()'.
		precedingSiblings :=
			each hasParent
				ifTrue: [(each parent nodes copyUpTo: each) reversed]
				ifFalse: [self newNodeSet].
		self
			assert: list = precedingSiblings;
			assertList: list hasSortOrder: XPathReverseDocumentSortOrder.

		list := each <<< '*'.
		self
			assert: list = precedingSiblings elements;
			assertList: list hasSortOrder: XPathReverseDocumentSortOrder].
]
