"
An abstract handler for node test parsers.
"
Class {
	#name : #XPathNodeTestParserHandler,
	#superclass : #XPathParserHandler,
	#category : #'XPath-Core-Parsers'
}

{ #category : #handling }
XPathNodeTestParserHandler >> handleEmptyTest [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForAnyLocalNameAfterPrefix: aPrefix [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForAnyName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForAnyPrefixBeforeLocalName: aLocalName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForCommentType [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForLocalName: aName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForNamespaceURI: aNamespaceUri localName: aLocalName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForNodeType [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForPIType: aName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForPrefix: aPrefix localName: aLocalName [
]

{ #category : #handling }
XPathNodeTestParserHandler >> handleTestForTextType [
]
