"
This class sorts an unsorted node set into document order in linear time by visiting every node in the document or visiting every node of a shared parent.
"
Class {
	#name : #XPathNodeSetSorter,
	#superclass : #Object,
	#instVars : [
		'nodeSet',
		'nodeSetSize',
		'nodeSetCollection',
		'nodeSetSet',
		'mustVisitNamespaces',
		'mustVisitAttributes',
		'totalSorted'
	],
	#category : #'XPath-Core-DOM'
}

{ #category : #'instance creation' }
XPathNodeSetSorter class >> on: aNodeSet [
	^ self new on: aNodeSet
]

{ #category : #private }
XPathNodeSetSorter >> errorNodesLackSharedDocumentRoot [
	XPathDOMException signal: 'Cannot sort nodes without shared document root'
]

{ #category : #initialization }
XPathNodeSetSorter >> on: aNodeSet [
	nodeSet := aNodeSet.
	nodeSetSize := aNodeSet size.
	nodeSetCollection := aNodeSet collection.
	nodeSetSet := aNodeSet set.
	totalSorted := 0.
]

{ #category : #private }
XPathNodeSetSorter >> prescanNodesForSharedParent [
	| sharedParent |

	sharedParent := nodeSetCollection first parent.
	mustVisitNamespaces := false.
	mustVisitAttributes := false.
	nodeSetCollection do: [:each |
		each isNamespace
			ifTrue: [mustVisitNamespaces := true].
		each isAttribute
			ifTrue: [mustVisitAttributes := true].
		sharedParent
			ifNotNil: [
				each parent == sharedParent
					ifFalse: [sharedParent := nil]]].
	^ sharedParent.
]

{ #category : #sorting }
XPathNodeSetSorter >> sort [
	nodeSetSize > 1
		ifTrue: [
			self prescanNodesForSharedParent
				ifNil: [self sortVisitingAllNodes]
				ifNotNil: [:sharedParent | self sortVisitingNodesOfSharedParent: sharedParent]]
]

{ #category : #private }
XPathNodeSetSorter >> sortNode: aNode [
	(nodeSetSet includes: aNode)
		ifTrue: [
			nodeSetCollection
				at: (totalSorted := totalSorted + 1)
				put: aNode]
]

{ #category : #private }
XPathNodeSetSorter >> sortVisitingAllNodes [
	nodeSetCollection first documentRoot allNodesDo: [:node |
		self sortNode: node.
		node isElement
			ifTrue: [
				(mustVisitNamespaces
					and: [node hasNamespaceNodes])
					ifTrue: [node namespaceNodesDo: [:each | self sortNode: each]].
				(mustVisitAttributes
					and: [node hasAttributes])
					ifTrue: [node attributeNodesDo: [:each |self sortNode: each]]].
		totalSorted = nodeSetSize
			ifTrue: [
				nodeSet sortOrder: XPathDocumentSortOrder new.
				^ self]].

	self errorNodesLackSharedDocumentRoot.
]

{ #category : #private }
XPathNodeSetSorter >> sortVisitingNodesOfSharedParent: aSharedParent [
	(mustVisitNamespaces
		and: [aSharedParent hasNamespaceNodes])
		ifTrue: [aSharedParent namespaceNodesDo: [:each | self sortNode: each]].
	(mustVisitAttributes
		and: [aSharedParent hasAttributes])
		ifTrue: [aSharedParent attributeNodesDo: [:each | self sortNode: each]].
	aSharedParent hasChildren
		ifTrue: [aSharedParent nodesDo: [:each | self sortNode: each]].

	nodeSet sortOrder: XPathDocumentSortOrder new.
]
