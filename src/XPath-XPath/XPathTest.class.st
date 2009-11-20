Class {
	#name : #XPathTest,
	#superclass : #TestCase,
	#instVars : [
		'xml',
		'document'
	],
	#category : #'XPath-Tests'
}

{ #category : #'as yet unclassified' }
XPathTest >> setUp [
	"Need this for VW parser"
	| parser |
	xml := XMLTokenizer addressBookXML.
	"This is for the basic XML parser (what's it called again?)"
	document := XMLDOMParser parseDocumentFrom: xml readStream.
	"This is for the ported VW parser
	parser := VWXMLXMLParser on: XMLTokenizer addressBookXML readStream.
	parser validate: false.
	parser scanDocument.
	document := parser documentNode root"
]

{ #category : #'as yet unclassified' }
XPathTest >> testAttribute [
	| path results |
	path := XPath for: 'person/address/@city'.
	results := path in: document.
	self assert: results size = 4 & (results size > 0).
	self assert: (results at: 1)
			= 'Los Angeles'
]

{ #category : #'as yet unclassified' }
XPathTest >> testCount [
	| path results |
	path := XPath for: 'count(person)'.
	results := path in: document.
	self assert: results size = 1.
	self assert: ((results at: 1) = 4).
]

{ #category : #'as yet unclassified' }
XPathTest >> testDescendant [
	| path results |
	path := XPath for: '//address/@city'.
	results := path in: document.
	self assert: results size = 4 & (results size > 0).
	self assert: (results at: 1)
			= 'Los Angeles'.

]

{ #category : #'as yet unclassified' }
XPathTest >> testDot [
	| path results |
	path := XPath for: 'person/address/./@city'.
	results := path in: document.
	self assert: results size = 4 & (results size > 0).
	self assert: (results at: 1)
			= 'Los Angeles'.

]

{ #category : #'as yet unclassified' }
XPathTest >> testDotDot [
	| path results |
	path := XPath for: 'person/address/../address/@city'.
	results := path in: document.
	self assert: results size = 4 & (results size > 0).
	self assert: (results at: 1)
			= 'Los Angeles'.

]

{ #category : #'as yet unclassified' }
XPathTest >> testDotDotTooHigh [
	| path results |
	path := XPath for: 'person/address/../../../address/@city'.
	results := path in: document.
	self assert: (results size = 0).
]

{ #category : #'as yet unclassified' }
XPathTest >> testLast [
	| path results |
	path := XPath for: 'person/last()'.
	results := path in: document.
	self assert: (results size = 4).
]

{ #category : #'as yet unclassified' }
XPathTest >> testOneLevel [
	| path results |
	path := XPath for: 'person'.
	results := path in: document.
	self assert: (results size = 4).
]

{ #category : #'as yet unclassified' }
XPathTest >> testThreeLevel [
	| path results |
	path := XPath for: 'person/contact-info/email'.
	results := path in: document.
	self assert: (results size = 2).
]

{ #category : #'as yet unclassified' }
XPathTest >> testTwoLevel [
	| path results |
	path := XPath for: 'person/address'.
	results := path in: document.
	self assert: (results size = 4).
]

{ #category : #'as yet unclassified' }
XPathTest >> testWildcard [
	| path results |
	path := XPath for: '/*'.
	results := path in: document.
	self assert: (results size = 4).
]

{ #category : #'as yet unclassified' }
XPathTest >> testWildcardDescendant [
	| path results |
	path := XPath for: '//*'.
	results := path in: document.
	self assert: (results size = 27).
]

{ #category : #'as yet unclassified' }
XPathTest >> testWildcardDescendantAttribute [
	| path results |
	path := XPath for: '//*/@city'.
	results := path in: document.
	self assert: results size = 4 & (results size > 0).
	self assert: (results at: 1)
			= 'Los Angeles'.

]
