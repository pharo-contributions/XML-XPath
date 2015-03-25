Extension { #name : #XMLDocument }

{ #category : #'*XPath-Core-accessing' }
XMLDocument >> documentRoot [
	"returns the root of the DOM tree"
	^ self
]

{ #category : #'*XPath-Core-private' }
XMLDocument >> occursInParentAfterAttribute: aNode [
	^ false
]

{ #category : #'*XPath-Core-private' }
XMLDocument >> occursInParentAfterNamespace: aNode [
	^ false
]

{ #category : #'*XPath-Core-private' }
XMLDocument >> occursInParentAfterSibling: aNode [
	^ false
]
