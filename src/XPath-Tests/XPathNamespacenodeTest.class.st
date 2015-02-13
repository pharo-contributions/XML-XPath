Class {
	#name : #XPathNamespacenodeTest,
	#superclass : #XMLNodeTest,
	#category : #'XPath-Tests'
}

{ #category : #'instance creation' }
XPathNamespacenodeTest >> newNamespaceNode [
	^ self nodeClass
		element: self newElementWithAttributes
		prefix: 'prefix'
		uri: 'prefixNS'
]

{ #category : #accessing }
XPathNamespacenodeTest >> nodeClass [
	^ XPathNamespaceNode
]

{ #category : #tests }
XPathNamespacenodeTest >> testEquals [
	| firstNamespace secondNamespace |

	firstNamespace := self newNamespaceNode.
	self assert: firstNamespace = firstNamespace.

	secondNamespace :=
		self nodeClass
			element: firstNamespace element
			prefix: firstNamespace prefix
			uri: firstNamespace uri.
	self assert: firstNamespace = secondNamespace.

	secondNamespace :=
		self nodeClass
			element: self newElementWithAttributes
			prefix: firstNamespace prefix
			uri: firstNamespace uri.
	self deny: firstNamespace = secondNamespace.

	secondNamespace :=
		self nodeClass
			element: firstNamespace element
			prefix: 'newPrefix'
			uri: firstNamespace uri.
	self deny: firstNamespace = secondNamespace.

	secondNamespace :=
		self nodeClass
			element: firstNamespace element
			prefix: firstNamespace prefix
			uri: 'newURI'.
	self deny: firstNamespace = secondNamespace.
]
