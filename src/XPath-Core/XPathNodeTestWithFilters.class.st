"
This class stores a node test block and an array of filter blocks or positions.
"
Class {
	#name : #XPathNodeTestWithFilters,
	#superclass : #Object,
	#instVars : [
		'filters',
		'nodeTest'
	],
	#category : #'XPath-Core-Evaluation'
}

{ #category : #'instance creation' }
XPathNodeTestWithFilters class >> nodeTest: aNodeTestBlock [
	^ self new setNodeTest: aNodeTestBlock
]

{ #category : #converting }
XPathNodeTestWithFilters >> asXPathAttributeNodeTestBlock [
	^ nodeTest
]

{ #category : #converting }
XPathNodeTestWithFilters >> asXPathNamespaceNodeTestBlock [
	^ nodeTest
]

{ #category : #converting }
XPathNodeTestWithFilters >> asXPathNodeSetFilters [
	^ filters
]

{ #category : #converting }
XPathNodeTestWithFilters >> asXPathNodeTestBlock [
	^ nodeTest
]

{ #category : #private }
XPathNodeTestWithFilters >> filterWithAll: aFilterCollection [
	filters := aFilterCollection
]

{ #category : #testing }
XPathNodeTestWithFilters >> hasXPathNodeSetFilters [
	^ filters notEmpty
]

{ #category : #initialization }
XPathNodeTestWithFilters >> setNodeTest: aNodeTestBlock [
	nodeTest := aNodeTestBlock
]
