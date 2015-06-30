Extension { #name : #XMLElement }

{ #category : #'*XPath-Core-enumerating - axis' }
XMLElement >> @ aNodeTestStringOrBlock [
	"attribute axis"
	| nodeSet nodeTestBlock |

	nodeSet := self nodeSetClass new.
	nodeTestBlock := aNodeTestStringOrBlock asAttributeNodeTestBlock.
	self hasAttributes
		ifTrue: [
			self attributeNodesDo: [:each |
				(nodeTestBlock value: each)
					ifTrue: [nodeSet addLast: each]]].
	^ nodeSet sortOrder: XPathElementMetaNodeDocumentSortOrder new.
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLElement >> @@ aNodeTestStringOrBlock [
	"namespace axis"
	| nodeSet nodeTestBlock |

	nodeSet := self nodeSetClass new.
	nodeTestBlock := aNodeTestStringOrBlock asNamespaceNodeTestBlock.
	self hasNamespaceNodes
		ifTrue: [
			self namespaceNodesDo: [:each |
				(nodeTestBlock value: each)
					ifTrue: [nodeSet addLast: each]]].
	^ nodeSet sortOrder: XPathElementMetaNodeDocumentSortOrder new.
]

{ #category : #'*XPath-Core-testing' }
XMLElement >> hasExpandedName [
	^ true
]

{ #category : #'*XPath-Core-testing' }
XMLElement >> hasNamespaceNodes [
	"elements have at least one node for the default xml namespace"
	^ self usesNamespaces
]

{ #category : #'*XPath-Core-testing' }
XMLElement >> hasPrefixedNamespaceURI: aURI [
	^ self hasPrefix
		and: [self namespaceURI = aURI]
]

{ #category : #'*XPath-Core-accessing' }
XMLElement >> namespaceNodes [
	| namespaceNodes |

	namespaceNodes := self newListForSelect.
	self namespaceNodesDo: [:each | namespaceNodes addLast: each].
	^ namespaceNodes.
]

{ #category : #'*XPath-Core-enumerating' }
XMLElement >> namespaceNodesDo: aBlock [
	"every element has a node for the default xml namespace.
	if it isn't explicitly defined, then it's first in order"
	self usesNamespaces
		ifFalse: [^ self].

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
