"
Sorts an unsorted node set into document order.
"
Class {
	#name : #XPathNodeSetSorter,
	#superclass : #Object,
	#instVars : [
		'nodeSet',
		'sharedParentNode',
		'mustVisitAllNodes',
		'mustVisitNamespaces',
		'mustVisitAttributes'
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
	nodeSet := aNodeSet
]

{ #category : #private }
XPathNodeSetSorter >> prescanNodeSet [
	sharedParentNode := nodeSet first parent.
	mustVisitAllNodes := sharedParentNode isNil.
	mustVisitNamespaces := false.
	mustVisitAttributes := false.
	nodeSet do: [:each |
		mustVisitNamespaces
			ifFalse: [mustVisitNamespaces := each isNamespace].
		mustVisitAttributes
			ifFalse: [mustVisitAttributes := each isAttribute].
		mustVisitAllNodes
			ifFalse: [mustVisitAllNodes := each parent ~= sharedParentNode].

		mustVisitNamespaces & mustVisitAttributes & mustVisitAllNodes
			ifTrue: [^ self]]. "can stop scanning"
]

{ #category : #sorting }
XPathNodeSetSorter >> sort [
	nodeSet size > 1
		ifTrue: [
			self prescanNodeSet.
			mustVisitAllNodes
				ifTrue: [self sortVisitingAllNodes]
				ifFalse: [self sortVisitingNodesWithSharedParent]]
]

{ #category : #private }
XPathNodeSetSorter >> sortVisitingAllNodes [
	| collection set i |

	collection := nodeSet collection.
	set := nodeSet set.
	i := 1.
	collection first documentRoot allNodesDo: [:node |
		(set includes: node)
			ifTrue: [
				collection at: i put: node.
				i := i + 1].
		node isElement
			ifTrue: [
				(mustVisitNamespaces
					and: [node hasNamespaceNodes])
					ifTrue: [
						node namespaceNodesDo: [:each |
							(set includes: each)
								ifTrue: [
									collection at: i put: each.
									i := i + 1]]].
				(mustVisitAttributes
					and: [node hasAttributes])
					ifTrue: [
						node attributeNodesDo: [:each |
							(set includes: each)
								ifTrue: [
									collection at: i put: each.
									i := i + 1]]]]].

	i > nodeSet size
		ifFalse: [self errorNodesLackSharedDocumentRoot].

	nodeSet sortOrder: XPathDocumentSortOrder new.
]

{ #category : #private }
XPathNodeSetSorter >> sortVisitingNodesWithSharedParent [
	| collection set i |

	collection := nodeSet collection.
	set := nodeSet set.
	i := 1.
	sharedParentNode isElement
		ifTrue: [
			(mustVisitNamespaces
				and: [sharedParentNode hasNamespaceNodes])
				ifTrue: [
					sharedParentNode namespaceNodesDo: [:each |
						(set includes: each)
							ifTrue: [
								collection at: i put: each.
								i := i + 1]]].
			(mustVisitAttributes
				and: [sharedParentNode hasAttributes])
				ifTrue: [
					sharedParentNode attributeNodesDo: [:each |
						(set includes: each)
							ifTrue: [
								collection at: i put: each.
								i := i + 1]]]].

	sharedParentNode nodesDo: [:node |
		(set includes: node)
			ifTrue: [
				collection at: i put: node.
				i := i + 1]].

	nodeSet sortOrder:
		(mustVisitNamespaces | mustVisitAttributes
			ifTrue: [XPathDocumentSortOrder new]
			ifFalse: [XPathLevelDocumentSortOrder new]).
]
