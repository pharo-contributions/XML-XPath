Extension { #name : #BlockClosure }

{ #category : #'*XPath-Core-private' }
BlockClosure >> //? aThreeArgumentBlockOrNumber [
	^ XPathNodeTestWithFilters
		nodeTest: self
		filter: aThreeArgumentBlockOrNumber
]

{ #category : #'*XPath-Core-converting' }
BlockClosure >> asXPathAttributeNodeTestBlock [
	^ self
]

{ #category : #'*XPath-Core-converting' }
BlockClosure >> asXPathNamespaceNodeTestBlock [
	^ self
]

{ #category : #'*XPath-Core-converting' }
BlockClosure >> asXPathNodeSetFilters [
	^ #()
]

{ #category : #'*XPath-Core-converting' }
BlockClosure >> asXPathNodeTestBlock [
	^ self
]

{ #category : #'*XPath-Core-testing' }
BlockClosure >> hasXPathNodeSetFilters [
	^ false
]
