"
A context for parsing the arguments of a namespace() type test.
"
Class {
	#name : #XPathNodeTestParserNamespaceTypeTestContext,
	#superclass : #XPathNodeTestParserNamespaceContext,
	#category : #'XPath-Core-Parsers'
}

{ #category : #handling }
XPathNodeTestParserNamespaceTypeTestContext >> handleEmptyNodeTestWith: aHandler [
	aHandler handleNamespaceNodeTest
]
