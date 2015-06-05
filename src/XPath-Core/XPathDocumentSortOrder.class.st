"
A sort order for nodes in document order.
"
Class {
	#name : #XPathDocumentSortOrder,
	#superclass : #XPathSortOrder,
	#category : #'XPath-Core-DOM'
}

{ #category : #private }
XPathDocumentSortOrder >> documentOrderOn: aNodeSet do: aBlock [
	aNodeSet do: aBlock
]

{ #category : #private }
XPathDocumentSortOrder >> documentOrderReadStreamOn: aNodeSet [
	^ aNodeSet readStream
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

{ #category : #private }
XPathDocumentSortOrder >> reverseDocumentOrderReadStreamOn: aNodeSet [
	^ aNodeSet reverseReadStream
]
