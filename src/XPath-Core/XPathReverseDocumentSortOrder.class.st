"
A sort order for node in reverse document order.
"
Class {
	#name : #XPathReverseDocumentSortOrder,
	#superclass : #XPathSortOrder,
	#category : #'XPath-Core-DOM'
}

{ #category : #private }
XPathReverseDocumentSortOrder >> documentOrderOn: aNodeSet do: aBlock [
	aNodeSet reverseDo: aBlock
]

{ #category : #private }
XPathReverseDocumentSortOrder >> documentOrderOn: aNodeSet indexOfNextParentAfterIndex: anIndex [
	| firstIndex |

	firstIndex :=
		anIndex > 0
			ifTrue: [anIndex]
			ifFalse: [aNodeSet size + 1].
	firstIndex - 1 to: 1 by: -1 do: [:i |
		(aNodeSet at: i) hasChildren
			ifTrue: [^ i]].
	^ nil.
]

{ #category : #sorting }
XPathReverseDocumentSortOrder >> documentOrderSort: aNodeSet [
	aNodeSet
		reverseInPlace;
		sortOrder: XPathDocumentSortOrder new
]

{ #category : #accessing }
XPathReverseDocumentSortOrder >> firstInDocumentOrderFrom: aNodeSet [
	^ aNodeSet last
]

{ #category : #private }
XPathReverseDocumentSortOrder >> reverseDocumentOrderOn: aNodeSet do: aBlock [
	aNodeSet do: aBlock
]

{ #category : #sorting }
XPathReverseDocumentSortOrder >> reverseDocumentOrderSort: aNodeSet [
]
