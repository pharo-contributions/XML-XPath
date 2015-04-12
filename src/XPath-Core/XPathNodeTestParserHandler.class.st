"
An abstract handler for node test parsers.
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
XPathNodeTestParserHandler >> handleEmptyTest [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForAnyNodeType [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForAttributeWithAnyName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForAttributeWithLocalName: aLocalName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForAttributeWithName: aName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForAttributeWithNamespaceURI: aURI localName: aLocalName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForAttributeWithPrefix: aPrefix [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForAttributeWithPrefix: aPrefix localName: aLocalName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForCommentType [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForElementWithAnyName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForElementWithLocalName: aLocalName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForElementWithName: aName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForElementWithNamespaceURI: aURI localName: aLocalName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForElementWithPrefix: aPrefix [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForElementWithPrefix: aPrefix localName: aLocalName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForNamespaceWithAnyName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForNamespaceWithLocalName: aLocalName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForNamespaceWithName: aName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForNamespaceWithNamespaceURI: aURI localName: aLocalName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForNamespaceWithPrefix: aPrefix [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForNamespaceWithPrefix: aPrefix localName: aLocalName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForPIWithAnyName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForPIWithName: aName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForTextType [
]
