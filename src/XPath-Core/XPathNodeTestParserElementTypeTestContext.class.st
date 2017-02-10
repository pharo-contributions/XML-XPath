"
A context for parsing the arguments of an element() type test.
"
Class {
	#name : #XPathNodeTestParserElementTypeTestContext,
	#superclass : #XPathNodeTestParserElementContext,
	#category : #'XPath-Core-Parsers'
}

{ #category : #handling }
XPathNodeTestParserElementTypeTestContext >> handleEmptyNodeTestWith: aHandler [
	aHandler handleElementNodeTest
]
