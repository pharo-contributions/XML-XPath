"
Unit tests for XPathNamespaceNode
"
Class {
	#name : #XPathNamespaceNodeTest,
	#superclass : #XMLNodeTest,
	#category : #'XPath-Tests'
}

{ #category : #'instance creation' }
XPathNamespaceNodeTest >> newElementWithNamespaceNode [
	^ self newElementWithAttributes
		declarePrefix: 'prefix'
		uri: 'prefixNS'
]

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
	self assert: firstNamespace equals: firstNamespace.

	secondNamespace :=
		self nodeClass
			element: firstNamespace element
			name: firstNamespace name
			uri: firstNamespace uri.
	self assert: firstNamespace equals: secondNamespace.

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
	self deny: firstNamespace = secondNamespace
]

{ #category : #tests }
XPathNamespaceNodeTest >> testExpandedName [
	self assert: self newNamespaceNode expandedName equals: 'prefix'
]

{ #category : #tests }
XPathNamespaceNodeTest >> testHasExpandedName [
	self assert: self newNode hasExpandedName
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
XPathNamespaceNodeTest >> testIsNamespace [
	self assert: self newNode isNamespace
]

{ #category : #tests }
XPathNamespaceNodeTest >> testLocalName [
	self assert: self newNamespaceNode localName equals: 'prefix'
]

{ #category : #tests }
XPathNamespaceNodeTest >> testName [
	self assert: self newNamespaceNode name equals: 'prefix'
]

{ #category : #tests }
XPathNamespaceNodeTest >> testNamespaceURI [
	self assert: self newNamespaceNode namespaceURI equals: ''
]

{ #category : #tests }
XPathNamespaceNodeTest >> testPrefix [
	"namespace nodes model prefixes, but cannot be prefixed themselves"
	self assert: self newNamespaceNode prefix equals: ''
]

{ #category : #tests }
XPathNamespaceNodeTest >> testStringValue [
	super testStringValue.

	self assert: self newNamespaceNode stringValue equals: 'prefixNS'
]

{ #category : #tests }
XPathNamespaceNodeTest >> testURI [
	self assert: self newNamespaceNode uri equals: 'prefixNS'
]

{ #category : #tests }
XPathNamespaceNodeTest >> testWriteXMLOn [
	self assert: self newNamespaceNode printString equals: 'xmlns:prefix="prefixNS"'.
	self assert:
		(self nodeClass withXMLNamespaceOnElement: nil) printString equals:
			('xmlns:xml="', XMLNamespaceScope xmlNamespaceURI, '"').
	self assert:
		(self nodeClass
			element: nil
			name: ''
			uri: 'defaultNS') printString equals: 'xmlns="defaultNS"'
]
