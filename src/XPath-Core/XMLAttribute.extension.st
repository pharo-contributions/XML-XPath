Extension { #name : #XMLAttribute }

{ #category : #'*XPath-Core-DOM' }
XMLAttribute >> asXPathString [
	^ self value
]

{ #category : #'*XPath-Core-DOM' }
XMLAttribute >> hasExpandedName [
	^ true
]

{ #category : #'*XPath-Core-DOM' }
XMLAttribute >> hasPrefixedNamespaceURI: aNamespaceUri [
	"unprefixed attributes cannot be namespaced"
	^ self namespaceURI = aNamespaceUri
]

{ #category : #'*XPath-Core-DOM' }
XMLAttribute >> isPrincipalNode [
	^ true
]

{ #category : #'*XPath-Core-DOM' }
XMLAttribute >> occursInParentAfterAttribute: anAttribute [
	self element attributeNodesDo: [:each |
		each = anAttribute
			ifTrue: [^ true]].
	^ false.
]

{ #category : #'*XPath-Core-DOM' }
XMLAttribute >> occursInParentBeforeNode: aNode [
	^ aNode occursInParentAfterAttribute: self
]

{ #category : #'*XPath-Core-DOM' }
XMLAttribute >> position [
	self hasParent
		ifTrue: [^ self parent attributeNodes indexOf: self]
		ifFalse: [^ 1]
]
