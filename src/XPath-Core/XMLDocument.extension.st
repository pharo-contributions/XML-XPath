Extension { #name : #XMLDocument }

{ #category : #'*XPath-Core-DOM' }
XMLDocument >> documentRoot [
	^ self
]

{ #category : #'*XPath-Core-DOM' }
XMLDocument >> occursInParentAfterAttribute: aNode [
	^ false
]

{ #category : #'*XPath-Core-DOM' }
XMLDocument >> occursInParentAfterNamespace: aNode [
	^ false
]

{ #category : #'*XPath-Core-DOM' }
XMLDocument >> occursInParentAfterSibling: aNode [
	^ false
]
