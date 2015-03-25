Extension { #name : #XMLNodeWithElements }

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNodeWithElements >> / aNodeTestStringOrBlock [
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

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNodeWithElements >> // aNodeTestStringOrBlock [
	"descendant axis"
	| nodeSet nodeTestBlock |

	nodeSet := self newNodeSet.
	nodeTestBlock := aNodeTestStringOrBlock asNodeTestBlock.
	self descendentNodesDo: [:each |
		(nodeTestBlock value: each)
			ifTrue: [nodeSet addLast: each]].
	^ nodeSet sortOrder: XPathDocumentSortOrder new.
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNodeWithElements >> //~ aNodeTestStringOrBlock [
	"descendant-or-self axis"
	| nodeSet nodeTestBlock |

	nodeSet := self newNodeSet.
	nodeTestBlock := aNodeTestStringOrBlock asNodeTestBlock.
	self allNodesDo: [:each |
		(nodeTestBlock value: each)
			ifTrue: [nodeSet addLast: each]].
	^ nodeSet sortOrder: XPathDocumentSortOrder new.
]

{ #category : #'*XPath-Core-accessing' }
XMLNodeWithElements >> stringValue [
	"spec says the string-value of documents and elements is all text
	descendants concatenated, so contentString can't be used because it
	inserts spaces"
	^ self rawContentString
]
