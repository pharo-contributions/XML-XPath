"
A context for parsing node tests where attributes are the principal node type.
"
Class {
	#name : #XPathNodeTestParserAttributeContext,
	#superclass : #XPathNodeTestParserContext,
	#category : #'XPath-Core-Parsers'
}

{ #category : #handling }
XPathNodeTestParserAttributeContext >> handleTestForLocalName: aLocalName with: aHandler [
	aHandler handleAttributeTestForLocalName: aLocalName
]

{ #category : #handling }
XPathNodeTestParserAttributeContext >> handleTestForName: aName with: aHandler [
	aHandler handleAttributeTestForName: aName
]

{ #category : #handling }
XPathNodeTestParserAttributeContext >> handleTestForNamespaceURI: aURI localName: aLocalName with: aHandler [
	aHandler
		handleAttributeTestForNamespaceURI: aURI
		localName: aLocalName
]

{ #category : #handling }
XPathNodeTestParserAttributeContext >> handleTestForNamespaceURI: aURI with: aHandler [
	aHandler handleAttributeTestForNamespaceURI: aURI
]

{ #category : #handling }
XPathNodeTestParserAttributeContext >> handleTestForPrefix: aPrefix localName: aLocalName with: aHandler [
	aHandler
		handleAttributeTestForPrefix: aPrefix
		localName: aLocalName
]

{ #category : #handling }
XPathNodeTestParserAttributeContext >> handleTestForPrefix: aPrefix with: aHandler [
	aHandler handleAttributeTestForPrefix: aPrefix
]

{ #category : #handling }
XPathNodeTestParserAttributeContext >> handleWildcardTestWith: aHandler [
	aHandler handleAttributeTest
]
