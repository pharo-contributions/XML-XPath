Class {
	#name : #XPathNodeSetTest,
	#superclass : #XMLNodeListTest,
	#instVars : [
		'document'
	],
	#category : #'XPath-Tests'
}

{ #category : #testing }
XPathNodeSetTest >> allowsDuplicates [
	^ false
]

{ #category : #assertions }
XPathNodeSetTest >> assertList: aList copiedFrom: aSecondList equals: aThirdList [
	super
		assertList: aList
		copiedFrom: aSecondList
		equals: aThirdList.
	self
		assert: aList set size = aList size;
		assert: aList set = aThirdList set;
		deny: aList set == aSecondList set.
]

{ #category : #assertions }
XPathNodeSetTest >> assertList: aList isCopyOf: aSecondList [
	super assertList: aList isCopyOf: aSecondList.
	self
		assert: aList set size = aList size;
		assert: aList set = aSecondList set;
		deny: aList set == aSecondList set.
]

{ #category : #accessing }
XPathNodeSetTest >> listClass [
	^ XPathNodeSet
]

{ #category : #accessing }
XPathNodeSetTest >> listElements [
	| listElements |

	listElements := super listElements.
	document
		ifNil: [(document := XMLDocument new) addNodes: listElements].
	^ listElements.
	
]

{ #category : #accessing }
XPathNodeSetTest >> reverseSortBlock [
	^ [:a :b | b occursInDocumentBeforeNode: a]
]

{ #category : #accessing }
XPathNodeSetTest >> sortBlock [
	^ [:a :b | a = b or: [a occursInDocumentBeforeNode: b]]
]
