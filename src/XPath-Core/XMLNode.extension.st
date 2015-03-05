Extension { #name : #XMLNode }

{ #category : #'*XPath-Core-DOM' }
XMLNode >> % aNodeTestStringOrBlock [
	"parent axis"
	(self hasParent
		and: [aNodeTestStringOrBlock asNodeTestBlock value: self parent])
		ifTrue: [^ self newNodeSetWith: self parent]
		ifFalse: [^ self newNodeSet]
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> %% aNodeTestStringOrBlock [
	"ancestor axis"
	| nodeSet nodeTestBlock |

	nodeSet := self newNodeSet.
	nodeTestBlock := aNodeTestStringOrBlock asNodeTestBlock.
	self ancestorNodesDo: [:each |
		(nodeTestBlock value: each)
			ifTrue: [nodeSet addLast: each]].
	^ nodeSet sortOrder: XPathReverseDocumentSortOrder new.
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> %%~ aNodeTestStringOrBlock [
	"ancestor-or-self axis"
	| nodeSet nodeTestBlock |

	nodeSet := self newNodeSet.
	nodeTestBlock := aNodeTestStringOrBlock asNodeTestBlock.
	(nodeTestBlock value: self)
		ifTrue: [nodeSet addLast: self].
	self ancestorNodesDo: [:each |
		(nodeTestBlock value: each)
			ifTrue: [nodeSet addLast: each]].
	^ nodeSet sortOrder: XPathReverseDocumentSortOrder new.
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> / aNodeTestStringOrBlock [
	"child axis"
	^ self newNodeSet
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> // aNodeTestStringOrBlock [
	"descendant axis"
	^ self newNodeSet
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> //~ aNodeTestStringOrBlock [
	"descendant-or-self axis"
	(aNodeTestStringOrBlock asNodeTestBlock value: self)
		ifTrue: [^ self newNodeSetWith: self]
		ifFalse: [^ self newNodeSet]
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> << aNodeTestStringOrBlock [
	"preceding axis"
	| nodeSet nodeTestBlock |

	nodeSet := self newNodeSet.
	nodeTestBlock := aNodeTestStringOrBlock asNodeTestBlock.
	self precedingNodesDo: [:each |
		(nodeTestBlock value: each)
			ifTrue: [nodeSet addLast: each]].
	^ nodeSet sortOrder: XPathReverseDocumentSortOrder new.
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> <<< aNodeTestStringOrBlock [
	"preceding-sibling axis"
	| nodeSet nodeTestBlock |

	nodeSet := self newNodeSet.
	nodeTestBlock := aNodeTestStringOrBlock asNodeTestBlock.
	self precedingSiblingNodesDo: [:each |
		(nodeTestBlock value: each)
			ifTrue: [nodeSet addLast: each]].
	^ nodeSet sortOrder: XPathLevelReverseDocumentSortOrder new.
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> >> aNodeTestStringOrBlock [
	"following axis"
	| nodeSet nodeTestBlock |

	nodeSet := self newNodeSet.
	nodeTestBlock := aNodeTestStringOrBlock asNodeTestBlock.
	self followingNodesDo: [:each |
		(nodeTestBlock value: each)
			ifTrue: [nodeSet addLast: each]].
	^ nodeSet sortOrder: XPathDocumentSortOrder new.
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> >>> aNodeTestStringOrBlock [
	"following-sibling axis"
	| nodeSet nodeTestBlock |

	nodeSet := self newNodeSet.
	nodeTestBlock := aNodeTestStringOrBlock asNodeTestBlock.
	self followingSiblingNodesDo: [:each |
		(nodeTestBlock value: each)
			ifTrue: [nodeSet addLast: each]].
	^ nodeSet sortOrder: XPathLevelDocumentSortOrder new.
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> @ aNodeTestStringOrBlock [
	"attribute axis"
	^ self newNodeSet
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> @@ aNodeTestStringOrBlock [
	"namespace axis"
	^ self newNodeSet
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> allNodesReverseDo: aBlock [
	aBlock value: self
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> asXPathString [
	 ^ ''
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> documentRoot [
	| documentRoot |

	documentRoot := self.
	self ancestorNodesDo: [:each | documentRoot := each].
	^ documentRoot.
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> followingNodesDo: aBlock [
	self hasParent
		ifTrue: [| visitedSelf |
			visitedSelf := false.
			self parent nodesDo: [:each |
				visitedSelf
					ifTrue: [each allNodesDo: aBlock]
					ifFalse: [
						each = self
							ifTrue: [visitedSelf := true]]]]
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> followingSiblingNodesDo: aBlock [
	self hasParent
		ifTrue: [| visitedSelf |
			visitedSelf := false.
			self parent nodesDo: [:each |
				visitedSelf
					ifTrue: [aBlock value: each]
					ifFalse: [
						each = self
							ifTrue: [visitedSelf := true]]]]
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> hasExpandedName [
	^ false
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> isNamespace [
	^ false
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> isPrincipalNode [
	^ false
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> newNodeSet [
	^ XPathNodeSet new
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> newNodeSetWith: aNode [
	^ XPathNodeSet with: aNode
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> occursInDocumentBeforeNode: aNode [
	| selfAncestors aNodeAncestors selfLastAncestor aNodeLastAncestor selfAncestorOffset aNodeAncestorOffset |

	self = aNode
		ifTrue: [^ false].

	"handle easy cases where one is a root or one is the parent of the other
	or they share parents"
	(self hasParent not
		or: [aNode parent = self])
		ifTrue: [^ true].
	(aNode hasParent not
		or: [self parent = aNode])
		ifTrue: [^ false].
	self parent = aNode parent
		ifTrue: [^ self occursInParentBeforeNode: aNode].

	selfAncestors := OrderedCollection new.
	self ancestorNodesDo: [:each |
		each = aNode
			ifTrue: [^ false].
		selfAncestors addLast: each].

	aNodeAncestors := OrderedCollection new.
	aNode ancestorNodesDo: [:each |
		each = self
			ifTrue: [^ true].
		aNodeAncestors addLast: each].

	selfAncestorOffset := (selfAncestors size - aNodeAncestors size) max: 0.
	selfLastAncestor := selfAncestors at: selfAncestorOffset ifAbsent: [self].
	aNodeAncestorOffset := (aNodeAncestors size - selfAncestors size) max: 0.
	aNodeLastAncestor := aNodeAncestors at: aNodeAncestorOffset ifAbsent: [aNode].
	1
		to: selfAncestors size - selfAncestorOffset
		do: [:i | | selfAncestor aNodeAncestor |
			selfAncestor := selfAncestors at: i + selfAncestorOffset.
			aNodeAncestor := aNodeAncestors at: i + aNodeAncestorOffset.
			selfAncestor = aNodeAncestor
				ifTrue: [^ selfLastAncestor occursInParentBeforeNode: aNodeLastAncestor].

			selfLastAncestor := selfAncestor.
			aNodeLastAncestor := aNodeAncestor].
	^ false.
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> occursInParentAfterAttribute: anAttribute [
	^ true
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> occursInParentAfterNamespace: aNamespace [
	^ true
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> occursInParentAfterSibling: aNode [
	self parent nodesDo: [:each |
		each = aNode
			ifTrue: [^ true].
		each = self
			ifTrue: [^ false]].
	^ false.
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> occursInParentBeforeNode: aNode [
	^ aNode occursInParentAfterSibling: self
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> parentSize [
	self hasParent
		ifTrue: [^ self parent nodes size]
		ifFalse: [^ 1]
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> position [
	self hasParent
		ifTrue: [^ self parent nodes indexOf: self]
		ifFalse: [^ 1]
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> precedingNodesDo: aBlock [
	self hasParent
		ifTrue: [| visitedSelf |
			visitedSelf := false.
			self parent nodes reverseDo: [:each |
				visitedSelf
					ifTrue: [each allNodesReverseDo: aBlock]
					ifFalse: [
						each = self
							ifTrue: [visitedSelf := true]]]]
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> precedingSiblingNodesDo: aBlock [
	self hasParent
		ifTrue: [| visitedSelf |
			visitedSelf := false.
			self parent nodes reverseDo: [:each |
				visitedSelf
					ifTrue: [aBlock value: each]
					ifFalse: [
						each = self
							ifTrue: [visitedSelf := true]]]]
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> xPath: anXPathString [
	^ XPath
		for: anXPathString
		in: self
]

{ #category : #'*XPath-Core-DOM' }
XMLNode >> ~ aNameOrBlock [
	"self axis"
	((aNameOrBlock asNodeTestBlock value: self)
		ifTrue: [^ self newNodeSetWith: self]
		ifFalse: [^ self newNodeSet])
]
