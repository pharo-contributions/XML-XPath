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
