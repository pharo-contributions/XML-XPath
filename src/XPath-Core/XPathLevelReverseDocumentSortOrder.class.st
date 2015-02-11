"
A sort order for nodes in reverse document order all having the same parent, or the children of nodes having the same parent, and so on.
"
Class {
	#name : #XPathLevelReverseDocumentSortOrder,
	#superclass : #XPathReverseDocumentSortOrder,
	#category : #'XPath-Core-DOM'
}

{ #category : #enumerating }
XPathLevelReverseDocumentSortOrder >> childAxisOn: aNodeSet select: aNodeTestBlock [
	^ self
		childAxisOnSiblings: aNodeSet
		select: aNodeTestBlock
]

{ #category : #enumerating }
XPathLevelReverseDocumentSortOrder >> followingAxisOn: aNodeSet select: aNodeTestBlock [
	^ self
		followingAxisOnSiblings: aNodeSet
		select: aNodeTestBlock
]

{ #category : #enumerating }
XPathLevelReverseDocumentSortOrder >> followingSiblingAxisOn: aNodeSet select: aNodeTestBlock [
	^ self
		followingSiblingAxisOnSiblings: aNodeSet
		select: aNodeTestBlock
]

{ #category : #enumerating }
XPathLevelReverseDocumentSortOrder >> precedingAxisOn: aNodeSet select: aNodeTestBlock [
	^ self
		precedingAxisOnSiblings: aNodeSet
		select: aNodeTestBlock
]

{ #category : #enumerating }
XPathLevelReverseDocumentSortOrder >> precedingSiblingAxisOn: aNodeSet select: aNodeTestBlock [
	^ self
		precedingSiblingAxisOnSiblings: aNodeSet
		select: aNodeTestBlock
]
