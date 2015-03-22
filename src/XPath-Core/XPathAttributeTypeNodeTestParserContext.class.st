"
A context for parsing the arguments of an attribute type test.
"
Class {
	#name : #XPathAttributeTypeNodeTestParserContext,
	#superclass : #XPathNodeTestParserContext,
	#category : #'XPath-Core-Parsers'
}

{ #category : #handling }
XPathAttributeTypeNodeTestParserContext >> handleEmptyTestWith: aHandler [
	aHandler handleTestForAttributeWithAnyName
]

{ #category : #handling }
XPathAttributeTypeNodeTestParserContext >> handleTestForAnyNameWith: aHandler [
	aHandler handleTestForAttributeWithAnyName
]

{ #category : #handling }
XPathAttributeTypeNodeTestParserContext >> handleTestForLocalName: aLocalName with: aHandler [
	aHandler handleTestForAttributeWithLocalName: aLocalName
]

{ #category : #handling }
XPathAttributeTypeNodeTestParserContext >> handleTestForName: aName with: aHandler [
	aHandler handleTestForAttributeWithName: aName
]

{ #category : #handling }
XPathAttributeTypeNodeTestParserContext >> handleTestForNamespaceURI: aURI localName: aLocalName with: aHandler [
	aHandler
		handleTestForAttributeWithNamespaceURI: aURI
		localName: aLocalName
]

{ #category : #handling }
XPathAttributeTypeNodeTestParserContext >> handleTestForPrefix: aPrefix localName: aLocalName with: aHandler [
	aHandler
		handleTestForAttributeWithPrefix: aPrefix
		localName: aLocalName
]

{ #category : #handling }
XPathAttributeTypeNodeTestParserContext >> handleTestForPrefix: aPrefix with: aHandler [
	aHandler handleTestForAttributeWithPrefix: aPrefix
]

{ #category : #testing }
XPathAttributeTypeNodeTestParserContext >> isTypeTestParserContext [
	^ true
]
