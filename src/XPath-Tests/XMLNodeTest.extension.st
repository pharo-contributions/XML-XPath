Extension { #name : #XMLNodeTest }

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testHasExpandedName [
	self deny: self nodeClass new hasExpandedName
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testIsNamespace [
	self deny: self nodeClass new isNamespace
]

{ #category : #'*XPath-Tests' }
XMLNodeTest >> testIsPrincipalNode [
	self deny: self nodeClass new isPrincipalNode
]
