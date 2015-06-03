"
A sort order for nodes in reverse document order.
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
XPathReverseDocumentSortOrder >> documentOrderReadStreamOn: aNodeSet [
	^ aNodeSet reverseReadStream
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

{ #category : #private }
XPathReverseDocumentSortOrder >> reverseDocumentOrderReadStreamOn: aNodeSet [
	^ aNodeSet readStream
]

{ #category : #sorting }
XPathReverseDocumentSortOrder >> reverseDocumentOrderSort: aNodeSet [
	"already in reverse document order"
]
