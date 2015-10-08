"
A sort order for nodes in document order.
"
Class {
	#name : #XPathDocumentSortOrder,
	#superclass : #XPathSortOrder,
	#category : #'XPath-Core-DOM'
}

{ #category : #enumerating }
XPathDocumentSortOrder >> attributeAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	^ (super
		attributeAxisOn: aNodeSet
		select: aStringOrBlockOrNodeTestWithFilters) sortOrderFrom: aNodeSet
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
XPathDocumentSortOrder >> namespaceAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	^ (super
		namespaceAxisOn: aNodeSet
		select: aStringOrBlockOrNodeTestWithFilters) sortOrderFrom: aNodeSet
]

{ #category : #enumerating }
XPathDocumentSortOrder >> parentAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	"this is a document order axis according to the spec"
	^ (super
		parentAxisOn: aNodeSet
		select: aStringOrBlockOrNodeTestWithFilters) sortOrderFrom: aNodeSet
]

{ #category : #enumerating }
XPathDocumentSortOrder >> selfAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	^ (super
		selfAxisOn: aNodeSet
		select: aStringOrBlockOrNodeTestWithFilters) sortOrderFrom: aNodeSet
]
