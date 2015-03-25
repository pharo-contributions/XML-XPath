Extension { #name : #XMLDocument }

{ #category : #'*XPath-Core-accessing' }
XMLDocument >> documentRoot [
	"returns the root of the DOM tree"
	^ self
]

{ #category : #'*XPath-Core-private' }
XMLDocument >> occursInParentAfterAttribute: anAttribute [
	^ false
]

{ #category : #'*XPath-Core-private' }
XMLDocument >> occursInParentAfterNamespace: aNamespaceNode [
	^ false
]

{ #category : #'*XPath-Core-private' }
XMLDocument >> occursInParentAfterSibling: aNode [
	^ false
]
