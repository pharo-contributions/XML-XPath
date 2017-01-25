"
An abstract class for node test parser handlers. Parsing is controlled by XPathNodeTestParserContext classes.
"
Class {
	#name : #XPathNodeTestParserHandler,
	#superclass : #XPathParserHandler,
	#category : #'XPath-Core-Parsers'
}

{ #category : #accessing }
XPathNodeTestParserHandler >> defaultNodeTestParserContextClass [
	self subclassResponsibility
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleAnyNodeTest [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleAttributeTest [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleAttributeTestForLocalName: aLocalName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleAttributeTestForName: aName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleAttributeTestForNamespaceURI: aURI [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleAttributeTestForNamespaceURI: aURI localName: aLocalName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleAttributeTestForPrefix: aPrefix [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleAttributeTestForPrefix: aPrefix localName: aLocalName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleCommentTest [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleElementTest [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleElementTestForLocalName: aLocalName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleElementTestForName: aName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleElementTestForNamespaceURI: aURI [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleElementTestForNamespaceURI: aURI localName: aLocalName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleElementTestForPrefix: aPrefix [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleElementTestForPrefix: aPrefix localName: aLocalName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleEmptyTest [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleNamespaceTest [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleNamespaceTestForLocalName: aLocalName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleNamespaceTestForName: aName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleNamespaceTestForNamespaceURI: aURI [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleNamespaceTestForNamespaceURI: aURI localName: aLocalName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleNamespaceTestForPrefix: aPrefix [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleNamespaceTestForPrefix: aPrefix localName: aLocalName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handlePITest [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handlePITestForName: aName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTextTest [
]
