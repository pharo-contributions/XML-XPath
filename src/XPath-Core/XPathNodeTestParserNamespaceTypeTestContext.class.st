"
A context for parsing the arguments of a namespace() type test.
"
Class {
	#name : #XPathNodeTestParserNamespaceTypeTestContext,
	#superclass : #XPathNodeTestParserNamespaceContext,
	#category : #'XPath-Core-Parsers'
}

{ #category : #testing }
XPathNodeTestParserNamespaceTypeTestContext >> canHandleTypeTests [
	^ false
]

{ #category : #handling }
XPathNodeTestParserNamespaceTypeTestContext >> handleEmptyTestWith: aHandler [
	aHandler handleTestForNamespaceWithAnyName
]
