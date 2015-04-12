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
					assertList: list hasSortOrder: XPathLevelDocumentSortOrder.

				list := each / '*'.
				self
					assert: list = each elements;
					assertList: list hasSortOrder: XPathLevelDocumentSortOrder.]
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
					assert: list = each descendentNodes;
					assertList: list hasSortOrder: XPathDocumentSortOrder.

				list := each // '*'.
				self
					assert: list = each descendentElements;
					assertList: list hasSortOrder: XPathDocumentSortOrder]
			ifFalse: [
				self
					assert: (each // 'node()') isEmpty;
					assert: (each // '*') isEmpty]].
]

{ #category : #'*XPath-Tests' }
XMLNodeWithElementsTest >> testDescendantOrSelfAxis [
	| nodeWithElements |

	super testDescendantAxis.

	nodeWithElements := self newNodeWithElements.
	nodeWithElements allNodesDo: [:each |
		each hasChildren
			ifTrue: [| list |
				list := each //~ 'node()'.
				self
					assert: list = (each descendentNodes copyWithFirst: each);
					assertList: list hasSortOrder: XPathDocumentSortOrder.

				list := each //~ '*'.
				each isElement
					ifTrue: [self assert: list = (each descendentElements copyWithFirst: each)]
					ifFalse: [self assert: list = each descendentElements].
				self assertList: list hasSortOrder: XPathDocumentSortOrder]
			ifFalse: [
				self assert: (each //~ 'node()') = (XPathNodeSet with: each).
				each isElement
					ifTrue: [self assert: (each //~ '*') = (XPathNodeSet with: each)]
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
					each parent descendentNodes copyAfter:
						(each hasChildren
							ifTrue: [each descendentNodes last]
							ifFalse: [each])]
				ifFalse: [XPathNodeSet new].
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
				ifFalse: [XPathNodeSet new].
		self
			assert: list = followingSiblings;
			assertList: list hasSortOrder: XPathLevelDocumentSortOrder.

		list := each >>> '*'.
		self
			assert: list = followingSiblings elements;
			assertList: list hasSortOrder: XPathLevelDocumentSortOrder].
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
				ifTrue: [(each parent descendentNodes copyUpTo: each) reversed]
				ifFalse: [XPathNodeSet new].
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
				ifFalse: [XPathNodeSet new].
		self
			assert: list = precedingSiblings;
			assertList: list hasSortOrder: XPathLevelReverseDocumentSortOrder.

		list := each <<< '*'.
		self
			assert: list = precedingSiblings elements;
			assertList: list hasSortOrder: XPathLevelReverseDocumentSortOrder].
]
