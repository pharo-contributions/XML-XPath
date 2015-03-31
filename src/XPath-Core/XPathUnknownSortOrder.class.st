"
A sort order for unsorted nodes or nodes in an unknown sort order.
"
Class {
	#name : #XPathUnknownSortOrder,
	#superclass : #XPathSortOrder,
	#category : #'XPath-Core-DOM'
}

{ #category : #private }
XPathUnknownSortOrder >> documentOrderOn: aNodeSet do: aBlock [
	aNodeSet sorted do: aBlock
]

{ #category : #private }
XPathUnknownSortOrder >> documentOrderReadStreamOn: aNodeSet [
	^ aNodeSet sorted readStream
]

{ #category : #sorting }
XPathUnknownSortOrder >> documentOrderSort: aNodeSet [
	aNodeSet
		sort: [:a :b | a = b or: [a occursInDocumentBeforeNode: b]];
		sortOrder: XPathDocumentSortOrder new
]

{ #category : #accessing }
XPathUnknownSortOrder >> firstInDocumentOrderFrom: aNodeSet [
	^ aNodeSet sorted first
]

{ #category : #private }
XPathUnknownSortOrder >> reverseDocumentOrderOn: aNodeSet do: aBlock [
	aNodeSet reverseSorted do: aBlock
]

{ #category : #sorting }
XPathUnknownSortOrder >> reverseDocumentOrderSort: aNodeSet [
	aNodeSet
		sort: [:a :b | b occursInDocumentBeforeNode: a];
		sortOrder: XPathReverseDocumentSortOrder new
]
