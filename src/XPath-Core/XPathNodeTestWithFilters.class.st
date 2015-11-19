"
This class stores a node test block and one or more filter blocks or positions.
"
Class {
	#name : #XPathNodeTestWithFilters,
	#superclass : #Object,
	#instVars : [
		'filters',
		'nodeTest'
	],
	#classInstVars : [
		'filters'
	],
	#category : #'XPath-Core-Parsers'
}

{ #category : #'instance creation' }
XPathNodeTestWithFilters class >> nodeTest: aNodeTestBlock filter: aThreeArgumentBlockOrNumber [
	^ self new
		setNodeTest: aNodeTestBlock
		filter: aThreeArgumentBlockOrNumber
]

{ #category : #private }
XPathNodeTestWithFilters >> //? aThreeArgumentBlockOrNumber [
	self filters addLast: aThreeArgumentBlockOrNumber
]

{ #category : #converting }
XPathNodeTestWithFilters >> asXPathAttributeNodeTestBlock [
	^ self nodeTest
]

{ #category : #converting }
XPathNodeTestWithFilters >> asXPathNamespaceNodeTestBlock [
	^ self nodeTest
]

{ #category : #converting }
XPathNodeTestWithFilters >> asXPathNodeSetFilters [
	^ self filters
]

{ #category : #converting }
XPathNodeTestWithFilters >> asXPathNodeTestBlock [
	^ self nodeTest
]

{ #category : #accessing }
XPathNodeTestWithFilters >> filters [
	^ filters
]

{ #category : #testing }
XPathNodeTestWithFilters >> hasXPathNodeSetFilters [
	^ self filters notEmpty
]

{ #category : #accessing }
XPathNodeTestWithFilters >> nodeTest [
	^ nodeTest
]

{ #category : #initialization }
XPathNodeTestWithFilters >> setNodeTest: aNodeTestBlock filter: aThreeArgumentBlockOrNumber [
	nodeTest := aNodeTestBlock.
	filters := OrderedCollection with: aThreeArgumentBlockOrNumber.
]
