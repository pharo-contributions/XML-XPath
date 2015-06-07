Extension { #name : #XMLAttribute }

{ #category : #'*XPath-Core-testing' }
XMLAttribute >> hasExpandedName [
	^ true
]

{ #category : #'*XPath-Core-testing' }
XMLAttribute >> hasPrefixedNamespaceURI: aURI [
	"unprefixed attributes cannot be namespaced"
	^ self namespaceURI = aURI
]

{ #category : #'*XPath-Core-accessing' }
XMLAttribute >> stringValue [
	^ self value
]
