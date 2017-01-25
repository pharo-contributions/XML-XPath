"
A context for parsing node tests where elements are the principal node type.
"
Class {
	#name : #XPathNodeTestParserElementContext,
	#superclass : #XPathNodeTestParserContext,
	#category : #'XPath-Core-Parsers'
}

{ #category : #handling }
XPathNodeTestParserElementContext >> handleTestForLocalName: aLocalName with: aHandler [
	aHandler handleElementTestForLocalName: aLocalName
]

{ #category : #handling }
XPathNodeTestParserElementContext >> handleTestForName: aName with: aHandler [
	aHandler handleElementTestForName: aName
]

{ #category : #handling }
XPathNodeTestParserElementContext >> handleTestForNamespaceURI: aURI localName: aLocalName with: aHandler [
	aHandler
		handleElementTestForNamespaceURI: aURI
		localName: aLocalName
]

{ #category : #handling }
XPathNodeTestParserElementContext >> handleTestForNamespaceURI: aURI with: aHandler [
	aHandler handleElementTestForNamespaceURI: aURI
]

{ #category : #handling }
XPathNodeTestParserElementContext >> handleTestForPrefix: aPrefix localName: aLocalName with: aHandler [
	aHandler
		handleElementTestForPrefix: aPrefix
		localName: aLocalName
]

{ #category : #handling }
XPathNodeTestParserElementContext >> handleTestForPrefix: aPrefix with: aHandler [
	aHandler handleElementTestForPrefix: aPrefix
]

{ #category : #handling }
XPathNodeTestParserElementContext >> handleWildcardTestWith: aHandler [
	aHandler handleElementTest
]
