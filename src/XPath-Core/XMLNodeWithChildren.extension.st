Extension { #name : #XMLNodeWithChildren }

{ #category : #'*XPath-Core-DOM' }
XMLNodeWithChildren >> / aNodeTestStringOrBlock [
	"child axis"
	| nodeSet nodeTestBlock |

	nodeSet := self newNodeSet.
	nodeTestBlock := aNodeTestStringOrBlock asNodeTestBlock.
	self hasChildren
		ifTrue: [
			self nodesDo: [:each |
				(nodeTestBlock value: each)
					ifTrue: [nodeSet addLast: each]]].
	^ nodeSet sortOrder: XPathLevelDocumentSortOrder new.
]

{ #category : #'*XPath-Core-DOM' }
XMLNodeWithChildren >> // aNodeTestStringOrBlock [
	"descendant axis"
	| nodeSet nodeTestBlock |

	nodeSet := self newNodeSet.
	nodeTestBlock := aNodeTestStringOrBlock asNodeTestBlock.
	self descendentNodesDo: [:each |
		(nodeTestBlock value: each)
			ifTrue: [nodeSet addLast: each]].
	^ nodeSet sortOrder: XPathDocumentSortOrder new.
]

{ #category : #'*XPath-Core-DOM' }
XMLNodeWithChildren >> //~ aNodeTestStringOrBlock [
	"descendant-or-self axis"
	| nodeSet nodeTestBlock |

	nodeSet := self newNodeSet.
	nodeTestBlock := aNodeTestStringOrBlock asNodeTestBlock.
	self allNodesDo: [:each |
		(nodeTestBlock value: each)
			ifTrue: [nodeSet addLast: each]].
	^ nodeSet sortOrder: XPathDocumentSortOrder new.
]

{ #category : #'*XPath-Core-DOM' }
XMLNodeWithChildren >> allNodesReverseDo: aBlock [
	self hasChildren
		ifTrue: [self nodes reverseDo: [:each | each allNodesReverseDo: aBlock]].
	aBlock value: self.
]

{ #category : #'*XPath-Core-DOM' }
XMLNodeWithChildren >> asXPathString [
	^ self rawContentString
]
