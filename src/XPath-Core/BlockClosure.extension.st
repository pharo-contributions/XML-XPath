Extension { #name : #BlockClosure }

{ #category : #'*XPath-Core-private' }
BlockClosure >> //? aThreeArgumentBlockOrNumber [
	^ XPathNodeTestWithFilters
		nodeTest: self
		filter: aThreeArgumentBlockOrNumber
]

{ #category : #'*XPath-Core-private' }
BlockClosure >> asAttributeNodeTestBlock [
	^ self
]

{ #category : #'*XPath-Core-private' }
BlockClosure >> asNamespaceNodeTestBlock [
	^ self
]

{ #category : #'*XPath-Core-private' }
BlockClosure >> asNodeSetFilters [
	^ #()
]

{ #category : #'*XPath-Core-private' }
BlockClosure >> asNodeTestBlock [
	^ self
]

{ #category : #'*XPath-Core-private' }
BlockClosure >> hasNodeSetFilters [
	^ false
]
