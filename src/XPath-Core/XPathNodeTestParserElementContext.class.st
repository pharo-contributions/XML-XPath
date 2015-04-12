"
A context for parsing node tests where elements are the principal node type.
"
Class {
	#name : #XPathNodeTestParserElementContext,
	#superclass : #XPathNodeTestParserContext,
	#category : #'XPath-Core-Parsers'
}

{ #category : #handling }
XPathNodeTestParserElementContext >> handleTestForAnyNameWith: aHandler [
	aHandler handleTestForElementWithAnyName
]

{ #category : #handling }
XPathNodeTestParserElementContext >> handleTestForLocalName: aLocalName with: aHandler [
	aHandler handleTestForElementWithLocalName: aLocalName
]

{ #category : #handling }
XPathNodeTestParserElementContext >> handleTestForName: aName with: aHandler [
	aHandler handleTestForElementWithName: aName
]

{ #category : #handling }
XPathNodeTestParserElementContext >> handleTestForNamespaceURI: aURI localName: aLocalName with: aHandler [
	aHandler
		handleTestForElementWithNamespaceURI: aURI
		localName: aLocalName
]

{ #category : #handling }
XPathNodeTestParserElementContext >> handleTestForPrefix: aPrefix localName: aLocalName with: aHandler [
	aHandler
		handleTestForElementWithPrefix: aPrefix
		localName: aLocalName
]

{ #category : #handling }
XPathNodeTestParserElementContext >> handleTestForPrefix: aPrefix with: aHandler [
	aHandler handleTestForElementWithPrefix: aPrefix
]
