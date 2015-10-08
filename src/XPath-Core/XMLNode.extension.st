Extension { #name : #XMLNode }

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> % aStringOrBlockOrNodeTestWithFilters [
	"parent axis"
	(self hasParent
		and: [aStringOrBlockOrNodeTestWithFilters asNodeTestBlock value: self parent])
		ifTrue: [
			"parent axis is a forward axis unlike ancestor or ancestor-or-self"
			^ (self nodeSetClass with: self parent)
				sortOrder: XPathDocumentSortOrder new;
				filterWithAll: aStringOrBlockOrNodeTestWithFilters asNodeSetFilters]
		ifFalse: [^ self nodeSetClass new]
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> %% aStringOrBlockOrNodeTestWithFilters [
	"ancestor axis"
	| nodeSet nodeTestBlock |

	nodeSet := self nodeSetClass new.
	nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asNodeTestBlock.
	self ancestorNodesDo: [:each |
		(nodeTestBlock value: each)
			ifTrue: [nodeSet addLast: each]].
	^ nodeSet
		sortOrder: XPathReverseDocumentSortOrder new;
		filterWithAll: aStringOrBlockOrNodeTestWithFilters asNodeSetFilters.
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> %%~ aStringOrBlockOrNodeTestWithFilters [
	"ancestor-or-self axis"
	| nodeSet nodeTestBlock |

	nodeSet := self nodeSetClass new.
	nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asNodeTestBlock.
	(nodeTestBlock value: self)
		ifTrue: [nodeSet addLast: self].
	self ancestorNodesDo: [:each |
		(nodeTestBlock value: each)
			ifTrue: [nodeSet addLast: each]].
	^ nodeSet
		sortOrder: XPathReverseDocumentSortOrder new;
		filterWithAll: aStringOrBlockOrNodeTestWithFilters asNodeSetFilters.
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> / aStringOrBlockOrNodeTestWithFilters [
	"child axis"
	^ self nodeSetClass new
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> // aStringOrBlockOrNodeTestWithFilters [
	"descendant axis"
	^ self nodeSetClass new
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> //~ aStringOrBlockOrNodeTestWithFilters [
	"descendant-or-self axis"
	^ self ~ aStringOrBlockOrNodeTestWithFilters
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> << aStringOrBlockOrNodeTestWithFilters [
	"preceding axis"
	| nodeSet nodeTestBlock |

	nodeSet := self nodeSetClass new.
	nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asNodeTestBlock.
	self precedingNodesDo: [:each |
		(nodeTestBlock value: each)
			ifTrue: [nodeSet addLast: each]].
	^ nodeSet
		sortOrder: XPathReverseDocumentSortOrder new;
		filterWithAll: aStringOrBlockOrNodeTestWithFilters asNodeSetFilters.
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> <<< aStringOrBlockOrNodeTestWithFilters [
	"preceding-sibling axis"
	| nodeSet nodeTestBlock |

	nodeSet := self nodeSetClass new.
	nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asNodeTestBlock.
	self precedingSiblingNodesDo: [:each |
		(nodeTestBlock value: each)
			ifTrue: [nodeSet addLast: each]].
	^ nodeSet
		sortOrder: XPathReverseDocumentSortOrder new;
		filterWithAll: aStringOrBlockOrNodeTestWithFilters asNodeSetFilters.
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> >> aStringOrBlockOrNodeTestWithFilters [
	"following axis"
	| nodeSet nodeTestBlock |

	nodeSet := self nodeSetClass new.
	nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asNodeTestBlock.
	self followingNodesDo: [:each |
		(nodeTestBlock value: each)
			ifTrue: [nodeSet addLast: each]].
	^ nodeSet
		sortOrder: XPathDocumentSortOrder new;
		filterWithAll: aStringOrBlockOrNodeTestWithFilters asNodeSetFilters
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> >>> aStringOrBlockOrNodeTestWithFilters [
	"following-sibling axis"
	| nodeSet nodeTestBlock |

	nodeSet := self nodeSetClass new.
	nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asNodeTestBlock.
	self followingSiblingNodesDo: [:each |
		(nodeTestBlock value: each)
			ifTrue: [nodeSet addLast: each]].
	^ nodeSet
		sortOrder: XPathDocumentSortOrder new;
		filterWithAll: aStringOrBlockOrNodeTestWithFilters asNodeSetFilters.
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> @ aNodeTestStringOrBlock [
	"attribute axis"
	^ self nodeSetClass new
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> @@ aNodeTestStringOrBlock [
	"namespace axis"
	^ self nodeSetClass new
]

{ #category : #'*XPath-Core-enumerating' }
XMLNode >> allNodesReverseDo: aBlock [
	aBlock value: self
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

{ #category : #'*XPath-Core-private' }
XMLNode >> lastAncestorOrSelfIn: aNode [
	self parent = aNode parent
		ifFalse: [| lastAncestorOrSelf |
			lastAncestorOrSelf := self.
			[lastAncestorOrSelf hasParent]
				whileTrue: [
					lastAncestorOrSelf parent = aNode
						ifTrue: [^ lastAncestorOrSelf].
					lastAncestorOrSelf := lastAncestorOrSelf parent]].
	^ nil.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> nodeSetClass [
	^ XPathNodeSet
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
XMLNode >> ~ aStringOrBlockOrNodeTestWithFilters [
	"self axis"
	(aStringOrBlockOrNodeTestWithFilters asNodeTestBlock value: self)
		ifTrue: [
			^ (self nodeSetClass with: self)
				sortOrder: XPathDocumentSortOrder new;
				filterWithAll: aStringOrBlockOrNodeTestWithFilters asNodeSetFilters]
		ifFalse: [^ self nodeSetClass new]
]
