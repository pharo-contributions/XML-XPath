Extension { #name : #XMLNodeTest }

{ #category : #'*XPath-Tests' }
XMLNodeTest >> assertList: aList hasSortOrder: aSortOrder [
	self assert: (aList sortOrder class == aSortOrder)
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> contextClass [
	^ XPathContext
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> newContext [
	^ self contextClass new
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> newNodeSet [
	^ self nodeSetClass new
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> nodeSetClass [
	^ XPathNodeSet
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testAllNodesReverseDo [
	| node |

	node := self newNode.
	self
		should: [:block | node allNodesReverseDo: block]
		enumerate: (Array with: node).
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testAncestorAxis [
	self
		assert: (self newNode %% 'node()') isEmpty;
		assert: (self newNode %% '*') isEmpty
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testAncestorOrSelfAxis [
	| node list |

	node := self newNode.
	list := node %%~ 'node()'.
	self
		assert: list = (self nodeSetClass with: node);
		assertList: list hasSortOrder: XPathReverseDocumentSortOrder.

	list := node %%~ '*'.
	node isElement
		ifTrue: [
			self
				assert: list = (self nodeSetClass with: node);
				assertList: list hasSortOrder: XPathReverseDocumentSortOrder]
		ifFalse: [self assert: list isEmpty].
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testAsXPathLocationPathRoot [
	| node |

	node := self newNode.
	self assert: node asXPathLocationPathRoot == node.
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testAttributeAxis [
	self
		assert: (self newNode @ 'node()') isEmpty;
		assert: (self newNode @ '*') isEmpty
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testChildAxis [
	self
		assert: (self newNode / 'node()') isEmpty;
		assert: (self newNode / '*') isEmpty
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testDescendantAxis [
	self
		assert: (self newNode // 'node()') isEmpty;
		assert: (self newNode // '*') isEmpty
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testDescendantOrSelfAxis [
	| node list |

	node := self newNode.
	list := node //~ 'node()'.
	self
		assert: list = (self nodeSetClass with: node);
		assertList: list hasSortOrder: XPathDocumentSortOrder.

	list := node //~ '*'.
	node isElement
		ifTrue: [
			self
				assert: list = (self nodeSetClass with: node);
				assertList: list hasSortOrder: XPathDocumentSortOrder]
		ifFalse: [self assert: list isEmpty].
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testFollowingAxis [
	self
		assert: (self newNode >> 'node()') isEmpty;
		assert: (self newNode >> '*') isEmpty
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testFollowingNodesDo [
	| node |

	node := self newNode.
	self
		should: [:block | node followingNodesDo: block]
		enumerate: #().
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testFollowingSiblingAxis [
	self
		assert: (self newNode >>> 'node()') isEmpty;
		assert: (self newNode >>> '*') isEmpty
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testFollowingSiblingNodesDo [
	| node |

	node := self newNode.
	self
		should: [:block | node followingSiblingNodesDo: block]
		enumerate: #().
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testHasExpandedName [
	self deny: self newNode hasExpandedName
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testIsNamespace [
	self deny: self newNode isNamespace
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testNamespaceAxis [
	self
		assert: (self newNode @@ 'node()') isEmpty;
		assert: (self newNode @@ '*') isEmpty
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testParentAxis [
	self
		assert: (self newNode % 'node()') isEmpty;
		assert: (self newNode % '*') isEmpty
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testPrecedingAxis [
	self
		assert: (self newNode << 'node()') isEmpty;
		assert: (self newNode << '*') isEmpty
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testPrecedingNodesDo [
	| node |

	node := self newNode.
	self
		should: [:block | node precedingNodesDo: block]
		enumerate: #().
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testPrecedingSiblingAxis [
	self
		assert: (self newNode <<< 'node()') isEmpty;
		assert: (self newNode <<< '*') isEmpty
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testPrecedingSiblingNodesDo [
	| node |

	node := self newNode.
	self
		should: [:block | node precedingSiblingNodesDo: block]
		enumerate: #().
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testSelfAxis [
	| node list |

	node := self newNode.
	list := node ~ 'node()'.
	self
		assert: list = (self nodeSetClass with: node);
		assertList: list hasSortOrder: XPathDocumentSortOrder.

	list := node ~ '*'.
	node isElement
		ifTrue: [
			self
				assert: list = (self nodeSetClass with: node);
				assertList: list hasSortOrder: XPathDocumentSortOrder]
		ifFalse: [self assert: list isEmpty].
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testStringValue [
	self assert: self newNode stringValue = ''
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testXPath [
	| node |

	node := self newNode.
	self
		assert: (node xPath: '.') = (self nodeSetClass with: node);
		assert: (node xPath: (XPath for: '.')) = (self nodeSetClass with: node).
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testXPathContext [
	| node context |

	node := self newNode.
	context := self newContext.
	context
		variableAt: 'var'
		put: 'test'.
	self
		assert: (node xPath: '$var' context: context) = 'test';
		assert: (node xPath: (XPath for: '$var') context: context) = 'test'.
]
