"
A context for parsing the arguments of an attribute() type test.
"
Class {
	#name : #XPathNodeTestParserAttributeTypeTestContext,
	#superclass : #XPathNodeTestParserAttributeContext,
	#category : #'XPath-Core-Parsers'
}

{ #category : #handling }
XPathNodeTestParserAttributeTypeTestContext >> handleEmptyTestWith: aHandler [
	aHandler handleAttributeTest
]
