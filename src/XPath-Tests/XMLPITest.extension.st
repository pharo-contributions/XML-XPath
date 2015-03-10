Extension { #name : #XMLPITest }

{ #category : #'*XPath-Tests' }
XMLPITest >> testExpandedName [
	self assert: (self nodeClass target: 'target' data: 'data') expandedName = 'target'
]

{ #category : #'*XPath-Tests' }
XMLPITest >> testHasExpandedName [
	self assert: self nodeClass new hasExpandedName
]

{ #category : #'*XPath-Tests' }
XMLPITest >> testHasNamespaceURI [
	self deny: (self nodeClass target: 'target' data: 'data') hasNamespaceURI
]

{ #category : #'*XPath-Tests' }
XMLPITest >> testHasPrefix [
	self deny: (self nodeClass target: 'target' data: 'data') hasPrefix
]

{ #category : #'*XPath-Tests' }
XMLPITest >> testHasPrefixedNamespaceURI [
	| pi |

	pi := self nodeClass target: 'target' data: 'data'.
	self
		deny: (pi hasPrefixedNamespaceURI: 'target');
		deny: (pi hasPrefixedNamespaceURI: 'data');
		deny: (pi hasPrefixedNamespaceURI: '').
]

{ #category : #'*XPath-Tests' }
XMLPITest >> testLocalName [
	self assert: (self nodeClass target: 'target' data: 'data') localName = 'target'
]

{ #category : #'*XPath-Tests' }
XMLPITest >> testName [
	self assert: (self nodeClass target: 'target' data: 'data') name = 'target'
]

{ #category : #'*XPath-Tests' }
XMLPITest >> testNamespaceURI [
	self assert: (self nodeClass target: 'target' data: 'data') namespaceURI isEmpty
]

{ #category : #'*XPath-Tests' }
XMLPITest >> testPrefix [
	self assert: (self nodeClass target: 'target' data: 'data') prefix isEmpty
]
