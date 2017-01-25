"
A context for parsing node tests where namespaces are the principal node type.
"
Class {
	#name : #XPathNodeTestParserNamespaceContext,
	#superclass : #XPathNodeTestParserContext,
	#category : #'XPath-Core-Parsers'
}

{ #category : #handling }
XPathNodeTestParserNamespaceContext >> handleTestForLocalName: aLocalName with: aHandler [
	aHandler handleNamespaceTestForLocalName: aLocalName
]

{ #category : #handling }
XPathNodeTestParserNamespaceContext >> handleTestForName: aName with: aHandler [
	aHandler handleNamespaceTestForName: aName
]

{ #category : #handling }
XPathNodeTestParserNamespaceContext >> handleTestForNamespaceURI: aURI localName: aLocalName with: aHandler [
	aHandler
		handleNamespaceTestForNamespaceURI: aURI
		localName: aLocalName
]

{ #category : #handling }
XPathNodeTestParserNamespaceContext >> handleTestForNamespaceURI: aURI with: aHandler [
	aHandler handleNamespaceTestForNamespaceURI: aURI
]

{ #category : #handling }
XPathNodeTestParserNamespaceContext >> handleTestForPrefix: aPrefix localName: aLocalName with: aHandler [
	aHandler
		handleNamespaceTestForPrefix: aPrefix
		localName: aLocalName
]

{ #category : #handling }
XPathNodeTestParserNamespaceContext >> handleTestForPrefix: aPrefix with: aHandler [
	aHandler handleNamespaceTestForPrefix: aPrefix
]

{ #category : #handling }
XPathNodeTestParserNamespaceContext >> handleWildcardTestWith: aHandler [
	aHandler handleNamespaceTest
]
