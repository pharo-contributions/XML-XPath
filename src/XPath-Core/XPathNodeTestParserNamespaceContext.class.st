"
A context for parsing node tests where namespaces are the principal node type.
"
Class {
	#name : #XPathNodeTestParserNamespaceContext,
	#superclass : #XPathNodeTestParserContext,
	#category : #'XPath-Core-Parsers'
}

{ #category : #handling }
XPathNodeTestParserNamespaceContext >> handleNodeTestForLocalName: aLocalName with: aHandler [
	aHandler handleNamespaceNodeTestForLocalName: aLocalName
]

{ #category : #handling }
XPathNodeTestParserNamespaceContext >> handleNodeTestForName: aName with: aHandler [
	aHandler handleNamespaceNodeTestForName: aName
]

{ #category : #handling }
XPathNodeTestParserNamespaceContext >> handleNodeTestForNamespaceURI: aURI localName: aLocalName with: aHandler [
	aHandler
		handleNamespaceNodeTestForNamespaceURI: aURI
		localName: aLocalName
]

{ #category : #handling }
XPathNodeTestParserNamespaceContext >> handleNodeTestForNamespaceURI: aURI with: aHandler [
	aHandler handleNamespaceNodeTestForNamespaceURI: aURI
]

{ #category : #handling }
XPathNodeTestParserNamespaceContext >> handleNodeTestForPrefix: aPrefix localName: aLocalName with: aHandler [
	aHandler
		handleNamespaceNodeTestForPrefix: aPrefix
		localName: aLocalName
]

{ #category : #handling }
XPathNodeTestParserNamespaceContext >> handleNodeTestForPrefix: aPrefix with: aHandler [
	aHandler handleNamespaceNodeTestForPrefix: aPrefix
]

{ #category : #handling }
XPathNodeTestParserNamespaceContext >> handleWildcardNodeTestWith: aHandler [
	aHandler handleNamespaceNodeTest
]
