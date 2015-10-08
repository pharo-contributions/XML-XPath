Extension { #name : #XMLNodeWithElements }

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNodeWithElements >> / aStringOrBlockOrNodeTestWithFilters [
	"child axis"
	| nodeSet nodeTestBlock |

	nodeSet := self nodeSetClass new.
	nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asNodeTestBlock.
	self hasChildren
		ifTrue: [
			self nodesDo: [:each |
				(nodeTestBlock value: each)
					ifTrue: [nodeSet addLast: each]]].
	^ nodeSet
		sortOrder: XPathDocumentSortOrder new;
		filterWithAll: aStringOrBlockOrNodeTestWithFilters asNodeSetFilters.
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNodeWithElements >> // aStringOrBlockOrNodeTestWithFilters [
	"descendant axis"
	| nodeSet nodeTestBlock |

	nodeSet := self nodeSetClass new.
	nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asNodeTestBlock.
	self descendentNodesDo: [:each |
		(nodeTestBlock value: each)
			ifTrue: [nodeSet addLast: each]].
	^ nodeSet
		sortOrder: XPathDocumentSortOrder new;
		filterWithAll: aStringOrBlockOrNodeTestWithFilters asNodeSetFilters.
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNodeWithElements >> //~ aStringOrBlockOrNodeTestWithFilters [
	"descendant-or-self axis"
	| nodeSet nodeTestBlock |

	nodeSet := self nodeSetClass new.
	nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asNodeTestBlock.
	self allNodesDo: [:each |
		(nodeTestBlock value: each)
			ifTrue: [nodeSet addLast: each]].
	^ nodeSet
		sortOrder: XPathDocumentSortOrder new;
		filterWithAll: aStringOrBlockOrNodeTestWithFilters asNodeSetFilters.
]

{ #category : #'*XPath-Core-accessing' }
XMLNodeWithElements >> stringValue [
	"spec says the string-value of documents and elements is all text
	descendants concatenated, so contentString can't be used because it
	inserts spaces"
	^ self rawContentString
]
