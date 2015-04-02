Extension { #name : #XMLNodeTest }

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testAllNodesReverseDo [
	| node |

	node := self nodeClass new.
	self
		should: [:block | node allNodesReverseDo: block]
		enumerate: (Array with: node).
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testDefaultContextPosition [
	self assert: self nodeClass new defaultContextPosition = 1
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testDefaultContextSize [
	self assert: self nodeClass new defaultContextSize = 1
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testDocumentRoot [
	| node |

	node := self nodeClass new.
	self assert: node documentRoot == node.
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
XMLNodeTest >> testIsPrincipalNode [
	self deny: self nodeClass new isPrincipalNode
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testLastAncestorOrSelfInNode [
	self assert: (self nodeClass new lastAncestorOrSelfInNode: self nodeClass new) isNil
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testOccursInDocumentBeforeNode [
	| node |

	node := self nodeClass new.
	self
		deny: (node occursInDocumentBeforeNode: node);
		deny: (self nodeClass new occursInDocumentBeforeNode: self nodeClass new).
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
XMLNodeTest >> testPrecedingSiblingNodesDo [
	| node |

	node := self nodeClass new.
	self
		should: [:block | node precedingSiblingNodesDo: block]
		enumerate: #().
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testStringValue [
	self assert: self nodeClass new stringValue isEmpty
]
