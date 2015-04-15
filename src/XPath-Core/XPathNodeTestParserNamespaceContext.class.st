"
A context for parsing node tests where namespaces are the principal node type.
"
Class {
	#name : #XPathNodeTestParserNamespaceContext,
	#superclass : #XPathNodeTestParserContext,
	#category : #'XPath-Core-Parsers'
}

{ #category : #handling }
XPathNodeTestParserNamespaceContext >> handleTestForAnyNameWith: aHandler [
	aHandler handleTestForNamespaceWithAnyName
]

{ #category : #handling }
XPathNodeTestParserNamespaceContext >> handleTestForLocalName: aLocalName with: aHandler [
	aHandler handleTestForNamespaceWithLocalName: aLocalName
]

{ #category : #handling }
XPathNodeTestParserNamespaceContext >> handleTestForName: aName with: aHandler [
	aHandler handleTestForNamespaceWithName: aName
]

{ #category : #handling }
XPathNodeTestParserNamespaceContext >> handleTestForNamespaceURI: aURI localName: aLocalName with: aHandler [
	aHandler
		handleTestForNamespaceWithNamespaceURI: aURI
		localName: aLocalName
]

{ #category : #handling }
XPathNodeTestParserNamespaceContext >> handleTestForNamespaceURI: aURI with: aHandler [
	aHandler handleTestForNamespaceWithNamespaceURI: aURI
]

{ #category : #handling }
XPathNodeTestParserNamespaceContext >> handleTestForPrefix: aPrefix localName: aLocalName with: aHandler [
	aHandler
		handleTestForNamespaceWithPrefix: aPrefix
		localName: aLocalName
]

{ #category : #handling }
XPathNodeTestParserNamespaceContext >> handleTestForPrefix: aPrefix with: aHandler [
	aHandler handleTestForNamespaceWithPrefix: aPrefix
]
