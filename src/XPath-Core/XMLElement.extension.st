Extension { #name : #XMLElement }

{ #category : #'*XPath-Core-DOM' }
XMLElement >> @ aNodeTestStringOrBlock [
	"attribute axis"
	| nodeSet nodeTestBlock |

	nodeSet := self newNodeSet.
	nodeTestBlock := aNodeTestStringOrBlock asNodeTestBlock.
	self hasAttributes
		ifTrue: [
			self attributeNodesDo: [:each |
				(nodeTestBlock value: each)
					ifTrue: [nodeSet addLast: each]]].
	^ nodeSet sortOrder: XPathElementMetaNodeDocumentSortOrder new.
]

{ #category : #'*XPath-Core-DOM' }
XMLElement >> @@ aNodeTestStringOrBlock [
	"namespace axis"
	| nodeSet nodeTestBlock |

	nodeSet := self newNodeSet.
	nodeTestBlock := aNodeTestStringOrBlock asNodeTestBlock.
	self hasNamespaceNodes
		ifTrue: [
			self namespaceNodesDo: [:each |
				(nodeTestBlock value: each)
					ifTrue: [nodeSet addLast: each]]].
	^ nodeSet sortOrder: XPathElementMetaNodeDocumentSortOrder new.
]

{ #category : #'*XPath-Core-DOM' }
XMLElement >> hasExpandedName [
	^ true
]

{ #category : #'*XPath-Core-DOM' }
XMLElement >> hasNamespaceNodes [
	"elements have at least one node for the default xml namespace"
	^ self usesNamespaces
]

{ #category : #'*XPath-Core-DOM' }
XMLElement >> hasPrefixedNamespaceURI: aURI [
	^ self hasPrefix
		and: [self namespaceURI = aURI]
]

{ #category : #'*XPath-Core-DOM' }
XMLElement >> isPrincipalNode [
	^ true
]

{ #category : #'*XPath-Core-DOM' }
XMLElement >> namespaceNodesDo: aBlock [
	"every element has a node for the default xml namespace.
	if it isn't explicitly defined, then it's first in order"
	(self hasNamespaces
		and: [self namespaceScope includesPrefix: 'xml'])
		ifFalse: [aBlock value: (XPathNamespaceNode withXMLNamespaceOnElement: self)].

	self hasNamespaces
		ifTrue: [
			self namespaceScope prefixesAndURIsDo: [:prefix :uri |
				aBlock value:
					(XPathNamespaceNode
						element: self
						name: prefix
						uri: uri)]].
]
