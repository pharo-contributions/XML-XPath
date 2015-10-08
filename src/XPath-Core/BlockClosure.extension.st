Extension { #name : #BlockClosure }

{ #category : #'*XPath-Core-enumerating' }
BlockClosure >> //? aThreeArgumentBlockOrNumber [
	^ XPathNodeTestWithFilters
		nodeTest: self
		filter: aThreeArgumentBlockOrNumber
]

{ #category : #'*XPath-Core-converting' }
BlockClosure >> asAttributeNodeTestBlock [
	^ self
]

{ #category : #'*XPath-Core-converting' }
BlockClosure >> asNamespaceNodeTestBlock [
	^ self
]

{ #category : #'*XPath-Core-converting' }
BlockClosure >> asNodeSetFilters [
	^ #()
]

{ #category : #'*XPath-Core-converting' }
BlockClosure >> asNodeTestBlock [
	^ self
]
