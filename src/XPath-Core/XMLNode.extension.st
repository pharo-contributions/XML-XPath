Extension { #name : #XMLNode }

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> % aStringOrBlockOrNodeTestWithFilters [
	^ self parentAxis: aStringOrBlockOrNodeTestWithFilters
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> %% aStringOrBlockOrNodeTestWithFilters [
	^ self ancestorAxis: aStringOrBlockOrNodeTestWithFilters
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> %%~ aStringOrBlockOrNodeTestWithFilters [
	^ self ancestorOrSelfAxis: aStringOrBlockOrNodeTestWithFilters
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> / aStringOrBlockOrNodeTestWithFilters [
	^ self childAxis: aStringOrBlockOrNodeTestWithFilters
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> // aStringOrBlockOrNodeTestWithFilters [
	^ self descendantAxis: aStringOrBlockOrNodeTestWithFilters
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> //~ aStringOrBlockOrNodeTestWithFilters [
	^ self descendantOrSelfAxis: aStringOrBlockOrNodeTestWithFilters
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> << aStringOrBlockOrNodeTestWithFilters [
	^ self precedingAxis: aStringOrBlockOrNodeTestWithFilters
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> <<< aStringOrBlockOrNodeTestWithFilters [
	^ self precedingSiblingAxis: aStringOrBlockOrNodeTestWithFilters
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> >> aStringOrBlockOrNodeTestWithFilters [
	^ self followingAxis: aStringOrBlockOrNodeTestWithFilters
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> >>> aStringOrBlockOrNodeTestWithFilters [
	^ self followingSiblingAxis: aStringOrBlockOrNodeTestWithFilters
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> @ aStringOrBlockOrNodeTestWithFilters [
	^ self attributeAxis: aStringOrBlockOrNodeTestWithFilters
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> @@ aStringOrBlockOrNodeTestWithFilters [
	^ self namespaceAxis: aStringOrBlockOrNodeTestWithFilters
]

{ #category : #'*XPath-Core-enumerating' }
XMLNode >> allNodesReverseDo: aBlock [
	aBlock value: self
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> ancestorAxis: aStringOrBlockOrNodeTestWithFilters [
	^ (self
		ancestorAxisSelect: aStringOrBlockOrNodeTestWithFilters asXPathNodeTestBlock
		into: self nodeSetClass new)
			sortOrder: XPathReverseDocumentSortOrder new;
			filterWithAll: aStringOrBlockOrNodeTestWithFilters asXPathNodeSetFilters
]

{ #category : #'*XPath-Core-private' }
XMLNode >> ancestorAxisSelect: aNodeTestBlock ifNotPresentInto: aNodeSet [
	self ancestorNodesDo: [:each |
		((aNodeSet includes: each) not
			and: [aNodeTestBlock value: each])
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> ancestorAxisSelect: aNodeTestBlock into: aNodeSet [
	self ancestorNodesDo: [:each |
		(aNodeTestBlock value: each)
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> ancestorOrSelfAxis: aStringOrBlockOrNodeTestWithFilters [
	^ (self
		ancestorOrSelfAxisSelect: aStringOrBlockOrNodeTestWithFilters asXPathNodeTestBlock
		into: self nodeSetClass new)
			sortOrder: XPathReverseDocumentSortOrder new;
			filterWithAll: aStringOrBlockOrNodeTestWithFilters asXPathNodeSetFilters
]

{ #category : #'*XPath-Core-private' }
XMLNode >> ancestorOrSelfAxisSelect: aNodeTestBlock ifNotPresentInto: aNodeSet [
	((aNodeSet includes: self) not
		and: [aNodeTestBlock value: self])
		ifTrue: [aNodeSet addLast: self].
	self ancestorNodesDo: [:each |
		((aNodeSet includes: each) not
			and: [aNodeTestBlock value: each])
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> ancestorOrSelfAxisSelect: aNodeTestBlock into: aNodeSet [
	(aNodeTestBlock value: self)
		ifTrue: [aNodeSet addLast: self].
	self ancestorNodesDo: [:each |
		(aNodeTestBlock value: each)
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-converting' }
XMLNode >> asXPathLocationPathRoot [
	^ self
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> attributeAxis: aStringOrBlockOrNodeTestWithFilters [
	^ (self
		attributeAxisSelect:
			aStringOrBlockOrNodeTestWithFilters asXPathAttributeNodeTestBlock
		into: self nodeSetClass new)
			sortOrder: XPathDocumentSortOrder new;
			filterWithAll: aStringOrBlockOrNodeTestWithFilters asXPathNodeSetFilters
]

{ #category : #'*XPath-Core-private' }
XMLNode >> attributeAxisSelect: anAttributeNodeTestBlock into: aNodeSet [
	^ aNodeSet
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> childAxis: aStringOrBlockOrNodeTestWithFilters [
	^ (self
		childAxisSelect: aStringOrBlockOrNodeTestWithFilters asXPathNodeTestBlock
		into: self nodeSetClass new)
			sortOrder: XPathDocumentSortOrder new;
			filterWithAll: aStringOrBlockOrNodeTestWithFilters asXPathNodeSetFilters
]

{ #category : #'*XPath-Core-private' }
XMLNode >> childAxisSelect: aNodeTestBlock into: aNodeSet [
	^ aNodeSet
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> descendantAxis: aStringOrBlockOrNodeTestWithFilters [
	^ (self
		descendantAxisSelect: aStringOrBlockOrNodeTestWithFilters asXPathNodeTestBlock
		into: self nodeSetClass new)
			sortOrder: XPathDocumentSortOrder new;
			filterWithAll: aStringOrBlockOrNodeTestWithFilters asXPathNodeSetFilters
]

{ #category : #'*XPath-Core-private' }
XMLNode >> descendantAxisSelect: aNodeTestBlock ifNotPresentInto: aNodeSet [
	^ aNodeSet
]

{ #category : #'*XPath-Core-private' }
XMLNode >> descendantAxisSelect: aNodeTestBlock into: aNodeSet [
	^ aNodeSet
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> descendantOrSelfAxis: aStringOrBlockOrNodeTestWithFilters [
	^ (self
		descendantOrSelfAxisSelect: aStringOrBlockOrNodeTestWithFilters asXPathNodeTestBlock
		into: self nodeSetClass new)
			sortOrder: XPathDocumentSortOrder new;
			filterWithAll: aStringOrBlockOrNodeTestWithFilters asXPathNodeSetFilters
]

{ #category : #'*XPath-Core-private' }
XMLNode >> descendantOrSelfAxisSelect: aNodeTestBlock ifNotPresentInto: aNodeSet [
	((aNodeSet includes: self) not
		and: [aNodeTestBlock value: self])
		ifTrue: [aNodeSet addLast: self].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> descendantOrSelfAxisSelect: aNodeTestBlock into: aNodeSet [
	(aNodeTestBlock value: self)
		ifTrue: [aNodeSet addLast: self].
	^ aNodeSet.
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

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> followingAxis: aStringOrBlockOrNodeTestWithFilters [
	^ (self
		followingAxisSelect: aStringOrBlockOrNodeTestWithFilters asXPathNodeTestBlock
		into: self nodeSetClass new)
			sortOrder: XPathDocumentSortOrder new;
			filterWithAll: aStringOrBlockOrNodeTestWithFilters asXPathNodeSetFilters
]

{ #category : #'*XPath-Core-private' }
XMLNode >> followingAxisSelect: aNodeTestBlock ifNotPresentInto: aNodeSet [
	self followingNodesDo: [:each |
		((aNodeSet includes: each) not
			and: [aNodeTestBlock value: each])
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> followingAxisSelect: aNodeTestBlock into: aNodeSet [
	self followingNodesDo: [:each |
		(aNodeTestBlock value: each)
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
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

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> followingSiblingAxis: aStringOrBlockOrNodeTestWithFilters [
	^ (self
		followingSiblingAxisSelect: aStringOrBlockOrNodeTestWithFilters asXPathNodeTestBlock
		into: self nodeSetClass new)
			sortOrder: XPathDocumentSortOrder new;
			filterWithAll: aStringOrBlockOrNodeTestWithFilters asXPathNodeSetFilters
]

{ #category : #'*XPath-Core-private' }
XMLNode >> followingSiblingAxisSelect: aNodeTestBlock ifNotPresentInto: aNodeSet [
	self followingSiblingNodesDo: [:each |
		((aNodeSet includes: each) not
			and: [aNodeTestBlock value: each])
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> followingSiblingAxisSelect: aNodeTestBlock into: aNodeSet [
	self followingSiblingNodesDo: [:each |
		(aNodeTestBlock value: each)
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
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

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> namespaceAxis: aStringOrBlockOrNodeTestWithFilters [
	^ (self
		namespaceAxisSelect:
			aStringOrBlockOrNodeTestWithFilters asXPathNamespaceNodeTestBlock
		into: self nodeSetClass new)
			sortOrder: XPathDocumentSortOrder new;
			filterWithAll: aStringOrBlockOrNodeTestWithFilters asXPathNodeSetFilters
]

{ #category : #'*XPath-Core-private' }
XMLNode >> namespaceAxisSelect: aNamespaceNodeTestBlock into: aNodeSet [
	^ aNodeSet
]

{ #category : #'*XPath-Core-private' }
XMLNode >> nodeSetClass [
	^ XPathNodeSet
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> parentAxis: aStringOrBlockOrNodeTestWithFilters [
	^ (self
		parentAxisSelect: aStringOrBlockOrNodeTestWithFilters asXPathNodeTestBlock
		into: self nodeSetClass new)
			"this is a document order axis according to spec"
			sortOrder: XPathDocumentSortOrder new;
			filterEachInSeparateContextWithAll:
				aStringOrBlockOrNodeTestWithFilters asXPathNodeSetFilters
]

{ #category : #'*XPath-Core-private' }
XMLNode >> parentAxisSelect: aNodeTestBlock ifNotPresentInto: aNodeSet [
	(self hasParent
		and: [(aNodeSet includes: self parent) not
			and: [aNodeTestBlock value: self parent]])
		ifTrue: [aNodeSet addLast: self parent].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> parentAxisSelect: aNodeTestBlock into: aNodeSet [
	(self hasParent
		and: [aNodeTestBlock value: self parent])
		ifTrue: [aNodeSet addLast: self parent].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> precedingAxis: aStringOrBlockOrNodeTestWithFilters [
	^ (self
		precedingAxisSelect: aStringOrBlockOrNodeTestWithFilters asXPathNodeTestBlock
		into: self nodeSetClass new)
			sortOrder: XPathReverseDocumentSortOrder new;
			filterWithAll: aStringOrBlockOrNodeTestWithFilters asXPathNodeSetFilters
]

{ #category : #'*XPath-Core-private' }
XMLNode >> precedingAxisSelect: aNodeTestBlock ifNotPresentInto: aNodeSet [
	self precedingNodesDo: [:each |
		((aNodeSet includes: each) not
			and: [aNodeTestBlock value: each])
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> precedingAxisSelect: aNodeTestBlock into: aNodeSet [
	self precedingNodesDo: [:each |
		(aNodeTestBlock value: each)
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
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

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> precedingSiblingAxis: aStringOrBlockOrNodeTestWithFilters [
	^ (self
		precedingSiblingAxisSelect: aStringOrBlockOrNodeTestWithFilters asXPathNodeTestBlock
		into: self nodeSetClass new)
			sortOrder: XPathReverseDocumentSortOrder new;
			filterWithAll: aStringOrBlockOrNodeTestWithFilters asXPathNodeSetFilters
]

{ #category : #'*XPath-Core-private' }
XMLNode >> precedingSiblingAxisSelect: aNodeTestBlock ifNotPresentInto: aNodeSet [
	self precedingSiblingNodesDo: [:each |
		((aNodeSet includes: each) not
			and: [aNodeTestBlock value: each])
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNode >> precedingSiblingAxisSelect: aNodeTestBlock into: aNodeSet [
	self precedingSiblingNodesDo: [:each |
		(aNodeTestBlock value: each)
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
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

{ #category : #'*XPath-Core-enumerating - axis' }
XMLNode >> selfAxis: aStringOrBlockOrNodeTestWithFilters [
	^ (self
		selfAxisSelect: aStringOrBlockOrNodeTestWithFilters asXPathNodeTestBlock
		into: self nodeSetClass new)
			sortOrder: XPathDocumentSortOrder new;
			filterEachInSeparateContextWithAll:
				aStringOrBlockOrNodeTestWithFilters asXPathNodeSetFilters
]

{ #category : #'*XPath-Core-private' }
XMLNode >> selfAxisSelect: aNodeTestBlock into: aNodeSet [
	(aNodeTestBlock value: self)
		ifTrue: [aNodeSet addLast: self].
	^ aNodeSet.
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
	^ self selfAxis: aStringOrBlockOrNodeTestWithFilters
]
