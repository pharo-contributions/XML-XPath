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
	#category : #'XPath-Core-Evaluation'
}

{ #category : #'instance creation' }
XPathNodeTestWithFilters class >> nodeTest: aNodeTestBlock [
	^ self new nodeTest: aNodeTestBlock
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

{ #category : #private }
XPathNodeTestWithFilters >> filterWithAll: aFilterCollection [
	filters := aFilterCollection
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
XPathNodeTestWithFilters >> nodeTest: aNodeTestBlock [
	nodeTest := aNodeTestBlock
]
