"
An initial context for node test parsers.
"
Class {
	#name : #XPathInitialNodeTestParserContext,
	#superclass : #XPathNodeTestParserContext,
	#category : #'XPath-Core-Parsers'
}

{ #category : #handling }
XPathInitialNodeTestParserContext >> handleEmptyTestWith: aHandler [
	aHandler handleEmptyTest
]

{ #category : #handling }
XPathInitialNodeTestParserContext >> handleTestForAnyNameWith: aHandler [
	aHandler handleTestForAnyName
]

{ #category : #handling }
XPathInitialNodeTestParserContext >> handleTestForAnyNodeTypeWith: aHandler [
	aHandler handleTestForAnyNodeType
]

{ #category : #handling }
XPathInitialNodeTestParserContext >> handleTestForCommentTypeWith: aHandler [
	aHandler handleTestForCommentType
]

{ #category : #handling }
XPathInitialNodeTestParserContext >> handleTestForLocalName: aLocalName with: aHandler [
	aHandler handleTestForLocalName: aLocalName
]

{ #category : #handling }
XPathInitialNodeTestParserContext >> handleTestForName: aName with: aHandler [
	aHandler handleTestForName: aName
]

{ #category : #handling }
XPathInitialNodeTestParserContext >> handleTestForNamespaceTypeWith: aHandler [
	aHandler handleTestForNamespaceType
]

{ #category : #handling }
XPathInitialNodeTestParserContext >> handleTestForNamespaceURI: aNamespaceUri localName: aLocalName with: aHandler [
	aHandler
		handleTestForNamespaceURI: aNamespaceUri
		localName: aLocalName
]

{ #category : #handling }
XPathInitialNodeTestParserContext >> handleTestForPITypeWith: aHandler [
	aHandler handleTestForPIType
]

{ #category : #handling }
XPathInitialNodeTestParserContext >> handleTestForPIWithName: aName with: aHandler [
	aHandler handleTestForPIWithName: aName
]

{ #category : #handling }
XPathInitialNodeTestParserContext >> handleTestForPrefix: aPrefix localName: aLocalName with: aHandler [
	aHandler
		handleTestForPrefix: aPrefix
		localName: aLocalName
]

{ #category : #handling }
XPathInitialNodeTestParserContext >> handleTestForPrefix: aPrefix with: aHandler [
	aHandler handleTestForPrefix: aPrefix
]

{ #category : #handling }
XPathInitialNodeTestParserContext >> handleTestForTextTypeWith: aHandler [
	aHandler handleTestForTextType
]

{ #category : #testing }
XPathInitialNodeTestParserContext >> isTypeTestParserContext [
	^ false
]
