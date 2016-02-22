"
A sort order for nodes in document order.
"
Class {
	#name : #XPathDocumentSortOrder,
	#superclass : #XPathSortOrder,
	#category : #'XPath-Core-DOM'
}

{ #category : #converting }
XPathDocumentSortOrder >> asReversedSortOrder [
	^ XPathReverseDocumentSortOrder new
]

{ #category : #sorting }
XPathDocumentSortOrder >> documentOrderSort: aNodeSet [
	"already in document order"
]

{ #category : #accessing }
XPathDocumentSortOrder >> firstInDocumentOrderFrom: aNodeSet [
	^ aNodeSet first
]

{ #category : #enumerating }
XPathDocumentSortOrder >> on: aNodeSet attributeAxis: aStringOrBlockOrNodeTestWithFilters [
	^ (super
		on: aNodeSet
		attributeAxis: aStringOrBlockOrNodeTestWithFilters) sortOrderFrom: aNodeSet
]

{ #category : #enumerating }
XPathDocumentSortOrder >> on: aNodeSet namespaceAxis: aStringOrBlockOrNodeTestWithFilters [
	^ (super
		on: aNodeSet
		namespaceAxis: aStringOrBlockOrNodeTestWithFilters) sortOrderFrom: aNodeSet
]

{ #category : #enumerating }
XPathDocumentSortOrder >> on: aNodeSet parentAxis: aStringOrBlockOrNodeTestWithFilters [
	"this is a document order axis according to the spec"
	^ (super
		on: aNodeSet
		parentAxis: aStringOrBlockOrNodeTestWithFilters) sortOrderFrom: aNodeSet
]

{ #category : #enumerating }
XPathDocumentSortOrder >> on: aNodeSet selfAxis: aStringOrBlockOrNodeTestWithFilters [
	^ (super
		on: aNodeSet
		selfAxis: aStringOrBlockOrNodeTestWithFilters) sortOrderFrom: aNodeSet
]
