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
XPathDocumentSortOrder >> on: aNodeSet attributeAxis: aNodeTestStringOrBlock [
	^ (super
		on: aNodeSet
		attributeAxis: aNodeTestStringOrBlock) sortOrderFrom: aNodeSet
]

{ #category : #enumerating }
XPathDocumentSortOrder >> on: aNodeSet attributeAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ (super
		on: aNodeSet
		attributeAxis: aNodeTestStringOrBlock
		predicates: aPredicateCollection) sortOrderFrom: aNodeSet
]

{ #category : #enumerating }
XPathDocumentSortOrder >> on: aNodeSet namespaceAxis: aNodeTestStringOrBlock [
	^ (super
		on: aNodeSet
		namespaceAxis: aNodeTestStringOrBlock) sortOrderFrom: aNodeSet
]

{ #category : #enumerating }
XPathDocumentSortOrder >> on: aNodeSet namespaceAxis: aNodeTestStringOrBlock predicates: aPredicateCollection [
	^ (super
		on: aNodeSet
		namespaceAxis: aNodeTestStringOrBlock
		predicates: aPredicateCollection) sortOrderFrom: aNodeSet
]

{ #category : #enumerating }
XPathDocumentSortOrder >> on: aNodeSet parentAxis: aNodeTestStringOrBlock [
	"this is a document order axis according to the spec"
	^ (super
		on: aNodeSet
		parentAxis: aNodeTestStringOrBlock) sortOrderFrom: aNodeSet
]

{ #category : #enumerating }
XPathDocumentSortOrder >> on: aNodeSet selfAxis: aNodeTestStringOrBlock [
	^ (super
		on: aNodeSet
		selfAxis: aNodeTestStringOrBlock) sortOrderFrom: aNodeSet
]
