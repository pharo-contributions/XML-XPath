Class {
	#name : #XPathNamespaceNodeTest,
	#superclass : #XMLNodeTest,
	#category : #'XPath-Tests'
}

{ #category : #'instance creation' }
XPathNamespaceNodeTest >> newNamespaceNode [
	^ self nodeClass
		element: self newElementWithAttributes
		name: 'prefix'
		uri: 'prefixNS'
]

{ #category : #accessing }
XPathNamespaceNodeTest >> nodeClass [
	^ XPathNamespaceNode
]

{ #category : #tests }
XPathNamespaceNodeTest >> testEquals [
	| firstNamespace secondNamespace |

	firstNamespace := self newNamespaceNode.
	self assert: firstNamespace = firstNamespace.

	secondNamespace :=
		self nodeClass
			element: firstNamespace element
			name: firstNamespace name
			uri: firstNamespace uri.
	self assert: firstNamespace = secondNamespace.

	secondNamespace :=
		self nodeClass
			element: self newElementWithAttributes
			name: firstNamespace name
			uri: firstNamespace uri.
	self deny: firstNamespace = secondNamespace.

	secondNamespace :=
		self nodeClass
			element: firstNamespace element
			name: 'newPrefix'
			uri: firstNamespace uri.
	self deny: firstNamespace = secondNamespace.

	secondNamespace :=
		self nodeClass
			element: firstNamespace element
			name: firstNamespace name
			uri: 'newURI'.
	self deny: firstNamespace = secondNamespace.
]

{ #category : #tests }
XPathNamespaceNodeTest >> testExpandedName [
	self assert: self newNamespaceNode expandedName = 'prefix'
]

{ #category : #tests }
XPathNamespaceNodeTest >> testHasExpandedName [
	self assert: self nodeClass new hasExpandedName
]

{ #category : #tests }
XPathNamespaceNodeTest >> testHasNamespaceURI [
	self deny: self newNamespaceNode hasNamespaceURI
]

{ #category : #tests }
XPathNamespaceNodeTest >> testHasPrefix [
	self deny: self newNamespaceNode hasPrefix
]

{ #category : #tests }
XPathNamespaceNodeTest >> testHasPrefixedNamespaceURI [
	| namespace |

	namespace := self newNamespaceNode.
	self deny: (namespace hasPrefixedNamespaceURI: namespace uri).
]

{ #category : #tests }
XPathNamespaceNodeTest >> testIsNamespace [
	self assert: self nodeClass new isNamespace
]

{ #category : #tests }
XPathNamespaceNodeTest >> testIsPrincipalNode [
	self assert: self nodeClass new isPrincipalNode
]

{ #category : #tests }
XPathNamespaceNodeTest >> testLocalName [
	self assert: self newNamespaceNode localName = 'prefix'
]

{ #category : #tests }
XPathNamespaceNodeTest >> testName [
	self assert: self newNamespaceNode name = 'prefix'
]

{ #category : #tests }
XPathNamespaceNodeTest >> testNamespaceURI [
	self assert: self newNamespaceNode namespaceURI isEmpty
]

{ #category : #tests }
XPathNamespaceNodeTest >> testPrefix [
	self assert: self newNamespaceNode prefix isEmpty
]

{ #category : #tests }
XPathNamespaceNodeTest >> testURI [
	self assert: self newNamespaceNode uri = 'prefixNS'
]

{ #category : #tests }
XPathNamespaceNodeTest >> testWriteXMLOn [
	self assert: self newNamespaceNode printString = 'xmlns:prefix="prefixNS"'.
	self assert:
		(self nodeClass withXMLNamespaceOnElement: nil) printString =
			('xmlns:xml="', XMLNamespaceScope xmlNamespaceURI, '"').
	self assert:
		(self nodeClass
			element: nil
			name: ''
			uri: 'defaultNS') printString = 'xmlns="defaultNS"'.
]
