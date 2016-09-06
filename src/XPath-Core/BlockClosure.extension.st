Extension { #name : #BlockClosure }

{ #category : #'*XPath-Core-converting' }
BlockClosure >> asXPathAttributeNodeTestBlock [
	^ self
]

{ #category : #'*XPath-Core-converting' }
BlockClosure >> asXPathFilterable [
	"assume the receiver is some kind of node test block"
	^ XPathNodeTestWithFilters nodeTest: self
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
