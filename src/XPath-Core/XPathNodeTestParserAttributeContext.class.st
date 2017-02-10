"
A context for parsing node tests where attributes are the principal node type.
"
Class {
	#name : #XPathNodeTestParserAttributeContext,
	#superclass : #XPathNodeTestParserContext,
	#category : #'XPath-Core-Parsers'
}

{ #category : #handling }
XPathNodeTestParserAttributeContext >> handleNodeTestForLocalName: aLocalName with: aHandler [
	aHandler handleAttributeNodeTestForLocalName: aLocalName
]

{ #category : #handling }
XPathNodeTestParserAttributeContext >> handleNodeTestForName: aName with: aHandler [
	aHandler handleAttributeNodeTestForName: aName
]

{ #category : #handling }
XPathNodeTestParserAttributeContext >> handleNodeTestForNamespaceURI: aURI localName: aLocalName with: aHandler [
	aHandler
		handleAttributeNodeTestForNamespaceURI: aURI
		localName: aLocalName
]

{ #category : #handling }
XPathNodeTestParserAttributeContext >> handleNodeTestForNamespaceURI: aURI with: aHandler [
	aHandler handleAttributeNodeTestForNamespaceURI: aURI
]

{ #category : #handling }
XPathNodeTestParserAttributeContext >> handleNodeTestForPrefix: aPrefix localName: aLocalName with: aHandler [
	aHandler
		handleAttributeNodeTestForPrefix: aPrefix
		localName: aLocalName
]

{ #category : #handling }
XPathNodeTestParserAttributeContext >> handleNodeTestForPrefix: aPrefix with: aHandler [
	aHandler handleAttributeNodeTestForPrefix: aPrefix
]

{ #category : #handling }
XPathNodeTestParserAttributeContext >> handleWildcardNodeTestWith: aHandler [
	aHandler handleAttributeNodeTest
]
