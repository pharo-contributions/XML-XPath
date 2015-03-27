Extension { #name : #XMLElementTest }

{ #category : #'*XPath-Tests' }
XMLElementTest >> testHasExpandedName [
	self assert: self nodeClass new hasExpandedName
]

{ #category : #'*XPath-Tests' }
XMLElementTest >> testHasNamespaceNodes [
	| element |

	element := self nodeClass new.
	self assert: element hasNamespaceNodes.

	element declareNamespaces: self namespaces.
	self assert: element hasNamespaceNodes.

	element configuration usesNamespaces: false.
	self deny: element hasNamespaceNodes.
]

{ #category : #'*XPath-Tests' }
XMLElementTest >> testHasPrefixedNamespaceURI [
	| element |

	element := self nodeClass name: 'test' namespaces: self namespaces.
	self
		assert: element namespaceURI notEmpty;
		assert: element prefix isEmpty;
		deny: (element hasPrefixedNamespaceURI: '').

	element name: 'prefix:test'.
	self assert: (element hasPrefixedNamespaceURI: 'prefixNS').
]

{ #category : #'*XPath-Tests' }
XMLElementTest >> testIsPrincipalNode [
	self assert: self nodeClass new isPrincipalNode
]

{ #category : #'*XPath-Tests' }
XMLElementTest >> testNamespaceNodes [
	| element nodes |

	element := self nodeClass new.
	nodes :=
		XMLNodeList with:
			(XPathNamespaceNode withXMLNamespaceOnElement: element).
	self assert: element namespaceNodes = nodes.

	element configuration usesNamespaces: false.
	self assert: element namespaceNodes isEmpty.

	element configuration usesNamespaces: true.
	element declareNamespaces: self namespaces.
	self namespaces keysAndValuesDo: [:prefix :uri |
		nodes addLast:
			(XPathNamespaceNode
				element: element
				name: prefix
				uri: uri)].
	self assert: element namespaceNodes = nodes.

	element declarePrefix: 'xml' uri: XMLNamespaceScope xmlNamespaceURI.
	nodes addLast: nodes removeFirst.
	self assert: element namespaceNodes = nodes.
]

{ #category : #'*XPath-Tests' }
XMLElementTest >> testNamespaceNodesDo [
	| element |

	element := self nodeClass new.
	self
		should: [:block | element namespaceNodesDo: block]
		enumerate: element namespaceNodes.

	element configuration usesNamespaces: false.
	self
		should: [:block | element namespaceNodesDo: block]
		enumerate: #().

	element configuration usesNamespaces: true.
	element declareNamespaces: self namespaces.
	self
		should: [:block | element namespaceNodesDo: block]
		enumerate: element namespaceNodes.

	element declarePrefix: 'xml' uri: XMLNamespaceScope xmlNamespaceURI.
	self
		should: [:block | element namespaceNodesDo: block]
		enumerate: element namespaceNodes.
]

{ #category : #'*XPath-Tests' }
XMLElementTest >> testStringValue [
	super testStringValue.

	self assert:
		(self nodeClass new
			addContent: 'before';
			addNode:
				((self nodeClass named: 'element')
					addContent: 'content';
					yourself);
			addContent: 'after';
			yourself) stringValue = 'beforecontentafter'.
]
