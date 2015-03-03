"
This class models an element namespace mapping as a DOM node for compatibility with the XPath standard.
"
Class {
	#name : #XPathNamespaceNode,
	#superclass : #XMLNode,
	#instVars : [
		'prefix',
		'uri'
	],
	#category : #'XPath-Core-DOM'
}

{ #category : #'instance creation' }
XPathNamespaceNode class >> element: anElement prefix: aPrefix uri: aNamespaceUri [
	^ self new
		setElement: anElement
		prefix: aPrefix
		uri: aNamespaceUri
]

{ #category : #'instance creation' }
XPathNamespaceNode class >> withXMLNamespaceOnElement: anElement [
	^ self
		element: anElement
		prefix: 'xml'
		uri: XMLNamespaceScope xmlNamespaceURI
]

{ #category : #comparing }
XPathNamespaceNode >> = anObject [
	"This is needed because namespace nodes are not part of the DOM
	tree and are created dynamically by XPath, so unless = is defined
	the union of two node sets could contain duplicate namespace nodes
	for the same namespace of the same element"

	self == anObject
		ifTrue: [^ true].

	self class == anObject class
		ifFalse: [^ false].

	"elements don't share namespace nodes according to the spec"
	^ self element = anObject element
		and: [self prefix = anObject prefix
			and: [self uri = anObject uri]].
]

{ #category : #converting }
XPathNamespaceNode >> asXPathString [
	^ self uri
]

{ #category : #accessing }
XPathNamespaceNode >> element [
	^ parent
]

{ #category : #namespaces }
XPathNamespaceNode >> expandedName [
	^ self localName expandWithNamespaceURI: self namespaceURI
]

{ #category : #testing }
XPathNamespaceNode >> hasExpandedName [
	^ true
]

{ #category : #testing }
XPathNamespaceNode >> hasNamespaceURI [
	^ false
]

{ #category : #testing }
XPathNamespaceNode >> hasPrefix [
	^ false
]

{ #category : #testing }
XPathNamespaceNode >> hasPrefixedNamespaceURI: aNamespaceUri [
	^ false
]

{ #category : #comparing }
XPathNamespaceNode >> hash [
	^ self prefix hash bitXor: self uri hash
]

{ #category : #testing }
XPathNamespaceNode >> isNamespace [
	^ true
]

{ #category : #testing }
XPathNamespaceNode >> isPrincipalNode [
	^ true
]

{ #category : #accessing }
XPathNamespaceNode >> localName [
	^ self prefix
]

{ #category : #accessing }
XPathNamespaceNode >> name [
	^ self localName
]

{ #category : #namespaces }
XPathNamespaceNode >> namespaceURI [
	"namespace nodes cannot be namespaced.
	the spec says their namespace is null"
	^ ''
]

{ #category : #private }
XPathNamespaceNode >> occursInParentAfterAttribute: anAttribute [
	^ false
]

{ #category : #private }
XPathNamespaceNode >> occursInParentAfterNamespace: aNamespace [
	self parent namespaceNodesDo: [:each |
		each = aNamespace
			ifTrue: [^ true].
		each = self
			ifTrue: [^ false]].
	^ false.
]

{ #category : #private }
XPathNamespaceNode >> occursInParentBeforeNode: aNode [
	^ aNode occursInParentAfterNamespace: self
]

{ #category : #accessing }
XPathNamespaceNode >> position [
	self hasParent
		ifTrue: [^ self parent namespaceScope prefixMappings indexOfKey: self]
		ifFalse: [^ 1]
]

{ #category : #namespaces }
XPathNamespaceNode >> prefix [
	^ prefix ifNil: [prefix := '']
]

{ #category : #initialization }
XPathNamespaceNode >> setElement: anElement prefix: aPrefix uri: aUri [
	"reuse parent inst var, like in XMLAttribute"
	parent := anElement.
	prefix := aPrefix.
	uri := aUri.
]

{ #category : #namespaces }
XPathNamespaceNode >> uri [
	^ uri ifNil: [uri := '']
]

{ #category : #printing }
XPathNamespaceNode >> writeXMLOn: aWriter [
	aWriter
		writeName:
			(self prefix
				ifEmpty: ['xmlns']
				ifNotEmpty: ['xmlns:', self prefix])
		escapedContentValue: self uri
]
