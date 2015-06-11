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
	(XPathNodeSetSorter on: aNodeSet) sort
]

{ #category : #accessing }
XPathUnknownSortOrder >> firstInDocumentOrderFrom: aNodeSet [
	^ aNodeSet sorted first
]

{ #category : #private }
XPathUnknownSortOrder >> reverseDocumentOrderOn: aNodeSet do: aBlock [
	aNodeSet sorted reverseDo: aBlock
]

{ #category : #private }
XPathUnknownSortOrder >> reverseDocumentOrderReadStreamOn: aNodeSet [
	^ aNodeSet sorted reverseReadStream
]
