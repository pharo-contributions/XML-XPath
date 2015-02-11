"
A sort order for nodes in document order all having the same parent, or the children of nodes having the same parent, and so on.
"
Class {
	#name : #XPathLevelDocumentSortOrder,
	#superclass : #XPathDocumentSortOrder,
	#category : #'XPath-Core-DOM'
}

{ #category : #enumerating }
XPathLevelDocumentSortOrder >> childAxisOn: aNodeSet select: aNodeTestBlock [
	^ self
		childAxisOnSiblings: aNodeSet
		select: aNodeTestBlock
]

{ #category : #enumerating }
XPathLevelDocumentSortOrder >> followingAxisOn: aNodeSet select: aNodeTestBlock [
	^ self
		followingAxisOnSiblings: aNodeSet
		select: aNodeTestBlock
]

{ #category : #enumerating }
XPathLevelDocumentSortOrder >> followingSiblingAxisOn: aNodeSet select: aNodeTestBlock [
	^ self
		followingSiblingAxisOnSiblings: aNodeSet
		select: aNodeTestBlock
]

{ #category : #enumerating }
XPathLevelDocumentSortOrder >> precedingAxisOn: aNodeSet select: aNodeTestBlock [
	^ self
		precedingAxisOnSiblings: aNodeSet
		select: aNodeTestBlock
]

{ #category : #enumerating }
XPathLevelDocumentSortOrder >> precedingSiblingAxisOn: aNodeSet select: aNodeTestBlock [
	^ self
		precedingSiblingAxisOnSiblings: aNodeSet
		select: aNodeTestBlock
]
