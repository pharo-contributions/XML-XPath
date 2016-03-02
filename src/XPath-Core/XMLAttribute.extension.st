Extension { #name : #XMLAttribute }

{ #category : #'*XPath-Core-testing' }
XMLAttribute >> hasExpandedName [
	^ true
]

{ #category : #'*XPath-Core-testing' }
XMLAttribute >> hasPrefixedNamespaceURI: aURI [
	"unprefixed attributes have no namespace (not even the default), so any
	namespace URI is a prefixed URI"
	^ self namespaceURI = aURI
]

{ #category : #'*XPath-Core-accessing' }
XMLAttribute >> stringValue [
	^ self value
]
