"
A context for parsing the arguments of an element type test.
"
Class {
	#name : #XPathElementTypeNodeTestParserContext,
	#superclass : #XPathNodeTestParserContext,
	#category : #'XPath-Core-Parsers'
}

{ #category : #handling }
XPathElementTypeNodeTestParserContext >> handleEmptyTestWith: aHandler [
	aHandler handleTestForElementWithAnyName
]

{ #category : #handling }
XPathElementTypeNodeTestParserContext >> handleTestForAnyNameWith: aHandler [
	aHandler handleTestForElementWithAnyName
]

{ #category : #handling }
XPathElementTypeNodeTestParserContext >> handleTestForLocalName: aLocalName with: aHandler [
	aHandler handleTestForElementWithLocalName: aLocalName
]

{ #category : #handling }
XPathElementTypeNodeTestParserContext >> handleTestForName: aName with: aHandler [
	aHandler handleTestForElementWithName: aName
]

{ #category : #handling }
XPathElementTypeNodeTestParserContext >> handleTestForNamespaceURI: aNamespaceUri localName: aLocalName with: aHandler [
	aHandler
		handleTestForElementWithNamespaceURI: aNamespaceUri
		localName: aLocalName
]

{ #category : #handling }
XPathElementTypeNodeTestParserContext >> handleTestForPrefix: aPrefix localName: aLocalName with: aHandler [
	aHandler
		handleTestForElementWithPrefix: aPrefix
		localName: aLocalName
]

{ #category : #handling }
XPathElementTypeNodeTestParserContext >> handleTestForPrefix: aPrefix with: aHandler [
	aHandler handleTestForElementWithPrefix: aPrefix
]

{ #category : #testing }
XPathElementTypeNodeTestParserContext >> isTypeTestParserContext [
	^ true
]
