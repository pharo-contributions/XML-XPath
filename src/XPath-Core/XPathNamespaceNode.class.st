"
This class models an element namespace mapping as a DOM node for compatibility with the XPath standard.
"
Class {
	#name : #XPathNamespaceNode,
	#superclass : #XMLNode,
	#instVars : [
		'name',
		'uri'
	],
	#category : #'XPath-Core-DOM'
}

{ #category : #'instance creation' }
XPathNamespaceNode class >> element: anElement name: aPrefixName uri: aNamespaceUri [
	^ self new
		setElement: anElement
		name: aPrefixName
		uri: aNamespaceUri
]

{ #category : #'instance creation' }
XPathNamespaceNode class >> withXMLNamespaceOnElement: anElement [
	^ self
		element: anElement
		name: 'xml'
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
		and: [self name = anObject name
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
	"this returns true only if the name is prefixed, and namespace
	names cannot be prefixed"
	^ false
]

{ #category : #testing }
XPathNamespaceNode >> hasPrefixedNamespaceURI: aNamespaceUri [
	^ false
]

{ #category : #comparing }
XPathNamespaceNode >> hash [
	^ self name hash bitXor: self uri hash
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
	^ self name
]

{ #category : #accessing }
XPathNamespaceNode >> name [
	^ name ifNil: [name := '']
]

{ #category : #namespaces }
XPathNamespaceNode >> namespaceURI [
	"spec says namespace nodes cannot be namespaced
	(the namespace part of the expanded name is null)"
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
	"the name of a namespace node cannot be prefixed"
	^ ''
]

{ #category : #initialization }
XPathNamespaceNode >> setElement: anElement name: aPrefixName uri: aNamespaceUri [
	"reuse parent inst var, like in XMLAttribute"
	parent := anElement.
	name := aPrefixName.
	uri := aNamespaceUri.
]

{ #category : #namespaces }
XPathNamespaceNode >> uri [
	^ uri ifNil: [uri := '']
]

{ #category : #printing }
XPathNamespaceNode >> writeXMLOn: aWriter [
	aWriter
		writeName:
			(self name
				ifEmpty: ['xmlns']
				ifNotEmpty: ['xmlns:', self name])
		escapedContentValue: self uri
]
