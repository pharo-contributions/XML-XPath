Extension { #name : #XMLNodeWithChildren }

{ #category : #'*XPath-Core-enumerating' }
XMLNodeWithChildren >> allNodesReverseDo: aBlock [
	self hasChildren
		ifTrue: [self nodes reverseDo: [:each | each allNodesReverseDo: aBlock]].
	aBlock value: self.
]
