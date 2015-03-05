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
		levelOrderChildAxisOn: aNodeSet
		select: aNodeTestBlock
]

{ #category : #enumerating }
XPathLevelDocumentSortOrder >> followingAxisOn: aNodeSet select: aNodeTestBlock [
	^ self
		levelOrderFollowingAxisOn: aNodeSet
		select: aNodeTestBlock
]

{ #category : #enumerating }
XPathLevelDocumentSortOrder >> followingSiblingAxisOn: aNodeSet select: aNodeTestBlock [
	^ self
		levelOrderFollowingSiblingAxisOn: aNodeSet
		select: aNodeTestBlock
]

{ #category : #enumerating }
XPathLevelDocumentSortOrder >> precedingAxisOn: aNodeSet select: aNodeTestBlock [
	^ self
		levelOrderPrecedingAxisOn: aNodeSet
		select: aNodeTestBlock
]

{ #category : #enumerating }
XPathLevelDocumentSortOrder >> precedingSiblingAxisOn: aNodeSet select: aNodeTestBlock [
	^ self
		levelOrderPrecedingSiblingAxisOn: aNodeSet
		select: aNodeTestBlock
]
