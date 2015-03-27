Extension { #name : #XMLNode }

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> % aNodeTestStringOrBlock [
	"parent axis"
	(self hasParent
		and: [aNodeTestStringOrBlock asNodeTestBlock value: self parent])
		ifTrue: [^ self newNodeSetWith: self parent]
		ifFalse: [^ self newNodeSet]
]

{ #category : #'*XPath-Core-enumerating - axis' }
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

{ #category : #'*XPath-Core-enumerating - axis' }
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

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> / aNodeTestStringOrBlock [
	"child axis"
	^ self newNodeSet
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> // aNodeTestStringOrBlock [
	"descendant axis"
	^ self newNodeSet
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> //~ aNodeTestStringOrBlock [
	"descendant-or-self axis"
	(aNodeTestStringOrBlock asNodeTestBlock value: self)
		ifTrue: [^ self newNodeSetWith: self]
		ifFalse: [^ self newNodeSet]
]

{ #category : #'*XPath-Core-enumerating - axis' }
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

{ #category : #'*XPath-Core-enumerating - axis' }
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

{ #category : #'*XPath-Core-enumerating - axis' }
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

{ #category : #'*XPath-Core-enumerating - axis' }
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

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> @ aNodeTestStringOrBlock [
	"attribute axis"
	^ self newNodeSet
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> @@ aNodeTestStringOrBlock [
	"namespace axis"
	^ self newNodeSet
]

{ #category : #'*XPath-Core-enumerating' }
XMLNode >> allNodesReverseDo: aBlock [
	aBlock value: self
]

{ #category : #'*XPath-Core-private' }
XMLNode >> ancestorOrSelfChildOfParent: aParent [
	self parent = aParent
		ifTrue: [^ self].
	self parent = aParent parent
		ifTrue: [^ nil].
	self ancestorNodesDo: [:each |
		(each parent = aParent)
			ifTrue: [^ each]].
	^ nil.
]

{ #category : #'*XPath-Core-accessing' }
XMLNode >> defaultContextPosition [
	self hasParent
		ifTrue: [^ self parent nodes indexOf: self]
		ifFalse: [^ 1]
]

{ #category : #'*XPath-Core-accessing' }
XMLNode >> defaultContextSize [
	self hasParent
		ifTrue: [^ self parent nodes size]
		ifFalse: [^ 1]
]

{ #category : #'*XPath-Core-accessing' }
XMLNode >> documentRoot [
	"returns the root of the DOM tree, a document node if there is one or the
	last ancestor or self otherwise"
	| documentRoot |

	documentRoot := self.
	self ancestorNodesDo: [:each | documentRoot := each].
	^ documentRoot.
]

{ #category : #'*XPath-Core-enumerating' }
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

{ #category : #'*XPath-Core-enumerating' }
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

{ #category : #'*XPath-Core-testing' }
XMLNode >> hasExpandedName [
	^ false
]

{ #category : #'*XPath-Core-testing' }
XMLNode >> isNamespace [
	^ false
]

{ #category : #'*XPath-Core-testing' }
XMLNode >> isPrincipalNode [
	^ false
]

{ #category : #'*XPath-Core-private' }
XMLNode >> newNodeSet [
	^ XPathNodeSet new
]

{ #category : #'*XPath-Core-private' }
XMLNode >> newNodeSetWith: aNode [
	^ XPathNodeSet with: aNode
]

{ #category : #'*XPath-Core-testing' }
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

{ #category : #'*XPath-Core-private' }
XMLNode >> occursInParentAfterAttribute: anAttribute [
	^ true
]

{ #category : #'*XPath-Core-private' }
XMLNode >> occursInParentAfterNamespace: aNamespaceNode [
	^ true
]

{ #category : #'*XPath-Core-private' }
XMLNode >> occursInParentAfterSibling: aNode [
	self parent nodesDo: [:each |
		each = aNode
			ifTrue: [^ true].
		each = self
			ifTrue: [^ false]].
	^ false.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> occursInParentBeforeNode: aNode [
	^ aNode occursInParentAfterSibling: self
]

{ #category : #'*XPath-Core-enumerating' }
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

{ #category : #'*XPath-Core-enumerating' }
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

{ #category : #'*XPath-Core-accessing' }
XMLNode >> stringValue [
	"returns XPath node string-value"
	 ^ ''
]

{ #category : #'*XPath-Core-evaluating' }
XMLNode >> xPath: anXPathOrXPathString [
	^ anXPathOrXPathString asXPath in: self
]

{ #category : #'*XPath-Core-evaluating' }
XMLNode >> xPath: anXPathOrXPathString context: aContext [
	^ anXPathOrXPathString asXPath
		in: self
		context: aContext
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> ~ aNameOrBlock [
	"self axis"
	((aNameOrBlock asNodeTestBlock value: self)
		ifTrue: [^ self newNodeSetWith: self]
		ifFalse: [^ self newNodeSet])
]
