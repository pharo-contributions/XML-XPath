"
A sort order for attribute or namespace nodes in document order.
"
Class {
	#name : #XPathElementMetaNodeDocumentSortOrder,
	#superclass : #XPathDocumentSortOrder,
	#category : #'XPath-Core-DOM'
}

{ #category : #enumerating }
XPathElementMetaNodeDocumentSortOrder >> attributeAxisOn: aNodeSet select: aNodeTestBlock [
	^ aNodeSet copyEmpty
]

{ #category : #enumerating }
XPathElementMetaNodeDocumentSortOrder >> childAxisOn: aNodeSet select: aNodeTestBlock [
	^ aNodeSet copyEmpty
]

{ #category : #enumerating }
XPathElementMetaNodeDocumentSortOrder >> descendantAxisOn: aNodeSet select: aNodeTestBlock [
	^ aNodeSet copyEmpty
]

{ #category : #enumerating }
XPathElementMetaNodeDocumentSortOrder >> descendantOrSelfAxisOn: aNodeSet select: aNodeTestBlock [
	"has no descendants"
	^ self
		selfAxisOn: aNodeSet
		select: aNodeTestBlock
]

{ #category : #enumerating }
XPathElementMetaNodeDocumentSortOrder >> followingAxisOn: aNodeSet select: aNodeTestBlock [
	^ aNodeSet copyEmpty
]

{ #category : #enumerating }
XPathElementMetaNodeDocumentSortOrder >> followingSiblingAxisOn: aNodeSet select: aNodeTestBlock [
	^ aNodeSet copyEmpty
]

{ #category : #enumerating }
XPathElementMetaNodeDocumentSortOrder >> namespaceAxisOn: aNodeSet select: aNodeTestBlock [
	^ aNodeSet copyEmpty
]

{ #category : #enumerating }
XPathElementMetaNodeDocumentSortOrder >> precedingAxisOn: aNodeSet select: aNodeTestBlock [
	^ aNodeSet copyEmpty
]

{ #category : #enumerating }
XPathElementMetaNodeDocumentSortOrder >> precedingSiblingAxisOn: aNodeSet select: aNodeTestBlock [
	^ aNodeSet copyEmpty
]
