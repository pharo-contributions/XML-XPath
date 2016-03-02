Extension { #name : #XMLNodeWithChildren }

{ #category : #'*XPath-Core-enumerating' }
XMLNodeWithChildren >> allNodesReverseDo: aBlock [
	self hasChildren
		ifTrue: [self nodes reverseDo: [:each | each allNodesReverseDo: aBlock]].
	aBlock value: self.
]

{ #category : #'*XPath-Core-private' }
XMLNodeWithChildren >> childAxisSelect: aNodeTestBlock into: aNodeSet [
	self hasChildren
		ifTrue: [| nodeList |
			"use to:do: with direct access for speed"
			nodeList := self nodes.
			1 to: nodeList size do: [:i | | node |
				node := nodeList at: i.
				(aNodeTestBlock value: node)
					ifTrue: [aNodeSet addLast: node]]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNodeWithChildren >> descendantAxisSelect: aNodeTestBlock ifNotPresentInto: aNodeSet [
	self descendantNodesDo: [:each |
		((aNodeSet includes: each) not
			and: [aNodeTestBlock value: each])
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNodeWithChildren >> descendantAxisSelect: aNodeTestBlock into: aNodeSet [
	self descendantNodesDo: [:each |
		(aNodeTestBlock value: each)
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNodeWithChildren >> descendantOrSelfAxisSelect: aNodeTestBlock ifNotPresentInto: aNodeSet [
	self allNodesDo: [:each |
		((aNodeSet includes: each) not
			and: [aNodeTestBlock value: each])
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]

{ #category : #'*XPath-Core-private' }
XMLNodeWithChildren >> descendantOrSelfAxisSelect: aNodeTestBlock into: aNodeSet [
	self allNodesDo: [:each |
		(aNodeTestBlock value: each)
			ifTrue: [aNodeSet addLast: each]].
	^ aNodeSet.
]
