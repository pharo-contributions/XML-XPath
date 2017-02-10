"
A context for parsing node tests where elements are the principal node type.
"
Class {
	#name : #XPathNodeTestParserElementContext,
	#superclass : #XPathNodeTestParserContext,
	#category : #'XPath-Core-Parsers'
}

{ #category : #handling }
XPathNodeTestParserElementContext >> handleNodeTestForLocalName: aLocalName with: aHandler [
	aHandler handleElementNodeTestForLocalName: aLocalName
]

{ #category : #handling }
XPathNodeTestParserElementContext >> handleNodeTestForName: aName with: aHandler [
	aHandler handleElementNodeTestForName: aName
]

{ #category : #handling }
XPathNodeTestParserElementContext >> handleNodeTestForNamespaceURI: aURI localName: aLocalName with: aHandler [
	aHandler
		handleElementNodeTestForNamespaceURI: aURI
		localName: aLocalName
]

{ #category : #handling }
XPathNodeTestParserElementContext >> handleNodeTestForNamespaceURI: aURI with: aHandler [
	aHandler handleElementNodeTestForNamespaceURI: aURI
]

{ #category : #handling }
XPathNodeTestParserElementContext >> handleNodeTestForPrefix: aPrefix localName: aLocalName with: aHandler [
	aHandler
		handleElementNodeTestForPrefix: aPrefix
		localName: aLocalName
]

{ #category : #handling }
XPathNodeTestParserElementContext >> handleNodeTestForPrefix: aPrefix with: aHandler [
	aHandler handleElementNodeTestForPrefix: aPrefix
]

{ #category : #handling }
XPathNodeTestParserElementContext >> handleWildcardNodeTestWith: aHandler [
	aHandler handleElementNodeTest
]
