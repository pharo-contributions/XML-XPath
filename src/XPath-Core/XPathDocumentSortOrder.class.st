"
A sort order for nodes in document order.
"
Class {
	#name : #XPathDocumentSortOrder,
	#superclass : #XPathSortOrder,
	#category : #'XPath-Core-DOM'
}

{ #category : #converting }
XPathDocumentSortOrder >> asDocumentSortOrder [
	^ self
]

{ #category : #private }
XPathDocumentSortOrder >> documentOrderOn: aNodeSet do: aBlock [
	aNodeSet do: aBlock
]

{ #category : #private }
XPathDocumentSortOrder >> documentOrderOn: aNodeSet indexOfNextParentAfterIndex: anIndex [
	anIndex + 1 to: aNodeSet size do: [:i |
		(aNodeSet at: i) hasChildren
			ifTrue: [^ i]].
	^ nil.
]

{ #category : #sorting }
XPathDocumentSortOrder >> documentOrderSort: aNodeSet [
	"already in document order"
]

{ #category : #accessing }
XPathDocumentSortOrder >> firstInDocumentOrderFrom: aNodeSet [
	^ aNodeSet first
]

{ #category : #private }
XPathDocumentSortOrder >> reverseDocumentOrderOn: aNodeSet do: aBlock [
	aNodeSet reverseDo: aBlock
]

{ #category : #sorting }
XPathDocumentSortOrder >> reverseDocumentOrderSort: aNodeSet [
	aNodeSet
		reverseInPlace;
		sortOrder: XPathReverseDocumentSortOrder new
]
