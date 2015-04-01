Extension { #name : #XMLAttribute }

{ #category : #'*XPath-Core-accessing' }
XMLAttribute >> defaultContextPosition [
	self hasParent
		ifTrue: [^ self parent attributeNodes indexOf: self]
		ifFalse: [^ 1]
]

{ #category : #'*XPath-Core-accessing' }
XMLAttribute >> defaultContextSize [
	self hasParent
		ifTrue: [^ self parent attributeNodes size]
		ifFalse: [^ 1]
]

{ #category : #'*XPath-Core-testing' }
XMLAttribute >> hasExpandedName [
	^ true
]

{ #category : #'*XPath-Core-testing' }
XMLAttribute >> hasPrefixedNamespaceURI: aURI [
	"unprefixed attributes cannot be namespaced"
	^ self namespaceURI = aURI
]

{ #category : #'*XPath-Core-testing' }
XMLAttribute >> isPrincipalNode [
	^ true
]

{ #category : #'*XPath-Core-private' }
XMLAttribute >> occursInParentAfterAttribute: anAttribute [
	self hasParent
		ifTrue: [
			self parent attributeNodesDo: [:each |
				each = anAttribute
					ifTrue: [^ true].
				each = self
					ifTrue: [^ false]]].
	^ false.
]

{ #category : #'*XPath-Core-private' }
XMLAttribute >> occursInParentBeforeNode: aNode [
	^ aNode occursInParentAfterAttribute: self
]

{ #category : #'*XPath-Core-accessing' }
XMLAttribute >> stringValue [
	^ self value
]
