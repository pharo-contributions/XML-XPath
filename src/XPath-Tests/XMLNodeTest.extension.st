Extension { #name : #XMLNodeTest }

{ #category : #'*XPath-Tests' }
XMLNodeTest >> assertList: aList hasSortOrder: aSortOrder [
	self assert: (aList sortOrder class == aSortOrder)
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testAllNodesReverseDo [
	| node |

	node := self nodeClass new.
	self
		should: [:block | node allNodesReverseDo: block]
		enumerate: (Array with: node).
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testAncestorAxis [
	self
		assert: (self nodeClass new %% 'node()') isEmpty;
		assert: (self nodeClass new %% '*') isEmpty
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testAncestorOrSelfAxis [
	| node list |

	node := self nodeClass new.
	list := node %%~ 'node()'.
	self
		assert: list = (XPathNodeSet with: node);
		assertList: list hasSortOrder: XPathReverseDocumentSortOrder.

	list := node %%~ '*'.
	node isElement
		ifTrue: [
			self
				assert: list = (XPathNodeSet with: node);
				assertList: list hasSortOrder: XPathReverseDocumentSortOrder]
		ifFalse: [self assert: list isEmpty].
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testAsXPathBoolean [
	self
		should: [self nodeClass new asXPathBoolean]
		raise: XPathTypeException
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testAsXPathLocationPathRoot [
	| node |

	node := self nodeClass new.
	self assert: node asXPathLocationPathRoot == node.
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testAsXPathNodeSet [
	self
		should: [self nodeClass new asXPathNodeSet]
		raise: XPathTypeException
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testAsXPathNumber [
	self
		should: [self nodeClass new asXPathNumber]
		raise: XPathTypeException
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testAsXPathString [
	self
		should: [self nodeClass new asXPathString]
		raise: XPathTypeException
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testAttributeAxis [
	self
		assert: (self nodeClass new @ 'node()') isEmpty;
		assert: (self nodeClass new @ '*') isEmpty
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testChildAxis [
	self
		assert: (self nodeClass new / 'node()') isEmpty;
		assert: (self nodeClass new / '*') isEmpty
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testDescendantAxis [
	self
		assert: (self nodeClass new // 'node()') isEmpty;
		assert: (self nodeClass new // '*') isEmpty
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testDescendantOrSelfAxis [
	| node list |

	node := self nodeClass new.
	list := node //~ 'node()'.
	self
		assert: list = (XPathNodeSet with: node);
		assertList: list hasSortOrder: XPathDocumentSortOrder.

	list := node //~ '*'.
	node isElement
		ifTrue: [
			self
				assert: list = (XPathNodeSet with: node);
				assertList: list hasSortOrder: XPathDocumentSortOrder]
		ifFalse: [self assert: list isEmpty].
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testDocumentRoot [
	| node |

	node := self nodeClass new.
	self assert: node documentRoot == node.
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testFollowingAxis [
	self
		assert: (self nodeClass new >> 'node()') isEmpty;
		assert: (self nodeClass new >> '*') isEmpty
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testFollowingNodesDo [
	| node |

	node := self nodeClass new.
	self
		should: [:block | node followingNodesDo: block]
		enumerate: #().
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testFollowingSiblingAxis [
	self
		assert: (self nodeClass new >>> 'node()') isEmpty;
		assert: (self nodeClass new >>> '*') isEmpty
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testFollowingSiblingNodesDo [
	| node |

	node := self nodeClass new.
	self
		should: [:block | node followingSiblingNodesDo: block]
		enumerate: #().
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testHasExpandedName [
	self deny: self nodeClass new hasExpandedName
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testIsNamespace [
	self deny: self nodeClass new isNamespace
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testNamespaceAxis [
	self
		assert: (self nodeClass new @@ 'node()') isEmpty;
		assert: (self nodeClass new @@ '*') isEmpty
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testParentAxis [
	self
		assert: (self nodeClass new % 'node()') isEmpty;
		assert: (self nodeClass new % '*') isEmpty
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testPrecedingAxis [
	self
		assert: (self nodeClass new << 'node()') isEmpty;
		assert: (self nodeClass new << '*') isEmpty
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testPrecedingNodesDo [
	| node |

	node := self nodeClass new.
	self
		should: [:block | node precedingNodesDo: block]
		enumerate: #().
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testPrecedingSiblingAxis [
	self
		assert: (self nodeClass new <<< 'node()') isEmpty;
		assert: (self nodeClass new <<< '*') isEmpty
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testPrecedingSiblingNodesDo [
	| node |

	node := self nodeClass new.
	self
		should: [:block | node precedingSiblingNodesDo: block]
		enumerate: #().
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testSelfAxis [
	| node list |

	node := self nodeClass new.
	list := node ~ 'node()'.
	self
		assert: list = (XPathNodeSet with: node);
		assertList: list hasSortOrder: XPathDocumentSortOrder.

	list := node ~ '*'.
	node isElement
		ifTrue: [
			self
				assert: list = (XPathNodeSet with: node);
				assertList: list hasSortOrder: XPathDocumentSortOrder]
		ifFalse: [self assert: list isEmpty].
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testStringValue [
	self assert: self nodeClass new stringValue isEmpty
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testXPath [
	| node |

	node := self nodeClass new.
	self
		assert: (node xPath: '.') = (XPathNodeSet with: node);
		assert: (node xPath: (XPath for: '.')) = (XPathNodeSet with: node).
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testXPathContext [
	| node context |

	node := self nodeClass new.
	(context := XPathContext new)
		variableAt: 'var' put: 'test'.
	self
		assert: (node xPath: '$var' context: context) = 'test';
		assert: (node xPath: (XPath for: '$var') context: context) = 'test'.
]
