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
	#category : #'XPath-Core-Compilation'
}

{ #category : #'instance creation' }
XPathNodeTestWithFilters class >> nodeTest: aNodeTestBlock [
	^ self
		nodeTest: aNodeTestBlock
		filters: #()
]

{ #category : #'instance creation' }
XPathNodeTestWithFilters class >> nodeTest: aNodeTestBlock filters: aFilterCollection [
	^ self new
		setNodeTest: aNodeTestBlock
		filters: aFilterCollection
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
	"instead of filtering anything, this stores the filters so the
	node test and filters can be applied by an axis later"
	filters := aFilterCollection
]

{ #category : #testing }
XPathNodeTestWithFilters >> hasXPathNodeSetFilters [
	^ filters notEmpty
]

{ #category : #printing }
XPathNodeTestWithFilters >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: nodeTest.
	filters
		ifNotNil: [
			aStream
				space
				print: filters].
	aStream nextPut: $).
]

{ #category : #initialization }
XPathNodeTestWithFilters >> setNodeTest: aNodeTestBlock filters: aFilterCollection [
	nodeTest := aNodeTestBlock.
	filters := aFilterCollection.
]
