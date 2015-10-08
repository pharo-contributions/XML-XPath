"
This class stores a node test block and one or more filter blocks or numbers.
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

{ #category : #enumerating }
XPathNodeTestWithFilters >> //? aThreeArgumentBlockOrNumber [
	self filters addLast: aThreeArgumentBlockOrNumber
]

{ #category : #converting }
XPathNodeTestWithFilters >> asAttributeNodeTestBlock [
	^ self nodeTest
]

{ #category : #converting }
XPathNodeTestWithFilters >> asNamespaceNodeTestBlock [
	^ self nodeTest
]

{ #category : #converting }
XPathNodeTestWithFilters >> asNodeSetFilters [
	^ self filters
]

{ #category : #converting }
XPathNodeTestWithFilters >> asNodeTestBlock [
	^ self nodeTest
]

{ #category : #accessing }
XPathNodeTestWithFilters >> filters [
	^ filters
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
