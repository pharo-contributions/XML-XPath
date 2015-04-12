"
A context for parsing node tests where attributes are the principal node type.
"
Class {
	#name : #XPathNodeTestParserAttributeContext,
	#superclass : #XPathNodeTestParserContext,
	#category : #'XPath-Core-Parsers'
}

{ #category : #handling }
XPathNodeTestParserAttributeContext >> handleTestForAnyNameWith: aHandler [
	aHandler handleTestForAttributeWithAnyName
]

{ #category : #handling }
XPathNodeTestParserAttributeContext >> handleTestForLocalName: aLocalName with: aHandler [
	aHandler handleTestForAttributeWithLocalName: aLocalName
]

{ #category : #handling }
XPathNodeTestParserAttributeContext >> handleTestForName: aName with: aHandler [
	aHandler handleTestForAttributeWithName: aName
]

{ #category : #handling }
XPathNodeTestParserAttributeContext >> handleTestForNamespaceURI: aURI localName: aLocalName with: aHandler [
	aHandler
		handleTestForAttributeWithNamespaceURI: aURI
		localName: aLocalName
]

{ #category : #handling }
XPathNodeTestParserAttributeContext >> handleTestForPrefix: aPrefix localName: aLocalName with: aHandler [
	aHandler
		handleTestForAttributeWithPrefix: aPrefix
		localName: aLocalName
]

{ #category : #handling }
XPathNodeTestParserAttributeContext >> handleTestForPrefix: aPrefix with: aHandler [
	aHandler handleTestForAttributeWithPrefix: aPrefix
]
