Extension { #name : #XMLElement }

{ #category : #'*XPath-Core-private' }
XMLElement >> attributeAxisSelect: anAttributeNodeTestBlock into: aNodeSet [
	self hasAttributes
		ifTrue: [
			self attributeNodesDo: [:each |
				(anAttributeNodeTestBlock value: each)
					ifTrue: [aNodeSet addLast: each]]].
	^ aNodeSet.
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

{ #category : #'*XPath-Core-private' }
XMLElement >> namespaceAxisSelect: aNamespaceNodeTestBlock into: aNodeSet [
	self hasNamespaceNodes
		ifTrue: [
			self namespaceNodesDo: [:each |
				(aNamespaceNodeTestBlock value: each)
					ifTrue: [aNodeSet addLast: each]]].
	^ aNodeSet.
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
