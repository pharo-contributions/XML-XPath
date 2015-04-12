"
A context for parsing the arguments of an attribute() type test.
"
Class {
	#name : #XPathNodeTestParserAttributeTypeTestContext,
	#superclass : #XPathNodeTestParserAttributeContext,
	#category : #'XPath-Core-Parsers'
}

{ #category : #testing }
XPathNodeTestParserAttributeTypeTestContext >> canHandleTypeTests [
	^ false
]

{ #category : #handling }
XPathNodeTestParserAttributeTypeTestContext >> handleEmptyTestWith: aHandler [
	aHandler handleTestForAttributeWithAnyName
]
