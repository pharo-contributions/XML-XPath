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
		levelOrderChildAxisOn: aNodeSet
		select: aNodeTestBlock
]

{ #category : #enumerating }
XPathLevelReverseDocumentSortOrder >> descendantAxisOn: aNodeSet select: aNodeTestBlock [
	^ self
		levelOrderDescendantAxisOn: aNodeSet
		select: aNodeTestBlock
]

{ #category : #enumerating }
XPathLevelReverseDocumentSortOrder >> descendantOrSelfAxisOn: aNodeSet select: aNodeTestBlock [
	^ self
		levelOrderDescendantOrSelfAxisOn: aNodeSet
		select: aNodeTestBlock
]

{ #category : #enumerating }
XPathLevelReverseDocumentSortOrder >> followingAxisOn: aNodeSet select: aNodeTestBlock [
	^ self
		levelOrderFollowingAxisOn: aNodeSet
		select: aNodeTestBlock
]

{ #category : #enumerating }
XPathLevelReverseDocumentSortOrder >> followingSiblingAxisOn: aNodeSet select: aNodeTestBlock [
	^ self
		levelOrderFollowingSiblingAxisOn: aNodeSet
		select: aNodeTestBlock
]

{ #category : #enumerating }
XPathLevelReverseDocumentSortOrder >> parentAxisOn: aNodeSet select: aNodeTestBlock [
	^ self
		levelOrderParentAxisOn: aNodeSet
		select: aNodeTestBlock
]

{ #category : #enumerating }
XPathLevelReverseDocumentSortOrder >> precedingAxisOn: aNodeSet select: aNodeTestBlock [
	^ self
		levelOrderPrecedingAxisOn: aNodeSet
		select: aNodeTestBlock
]

{ #category : #enumerating }
XPathLevelReverseDocumentSortOrder >> precedingSiblingAxisOn: aNodeSet select: aNodeTestBlock [
	^ self
		levelOrderPrecedingSiblingAxisOn: aNodeSet
		select: aNodeTestBlock
]

{ #category : #enumerating }
XPathLevelReverseDocumentSortOrder >> selfAxisOn: aNodeSet select: aNodeTestBlock [
	^ self
		levelOrderSelfAxisOn: aNodeSet
		select: aNodeTestBlock
]
