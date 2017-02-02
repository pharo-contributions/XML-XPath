"
This is an AST node class for the 'element(prefix:localName)' type test or for the 'prefix:localName' type test when the principal node type of the axis is 'element'.
"
Class {
	#name : #XPathASTElementTestForPrefixAndLocalNameNode,
	#superclass : #XPathASTElementTestForPrefixNode,
	#instVars : [
		'localName'
	],
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #'instance creation' }
XPathASTElementTestForPrefixAndLocalNameNode class >> prefix: aPrefix localName: aLocalName [
	^ (self prefix: aPrefix) localName: aLocalName
]

{ #category : #visiting }
XPathASTElementTestForPrefixAndLocalNameNode >> acceptNodeVisitor: aNodeVisitor [
	^ aNodeVisitor visitElementTestForPrefixAndLocalName: self
]

{ #category : #testing }
XPathASTElementTestForPrefixAndLocalNameNode >> isElementTestForPrefixAndLocalName [
	^ true
]

{ #category : #accessing }
XPathASTElementTestForPrefixAndLocalNameNode >> localName [
	^ localName ifNil: [localName := '']
]

{ #category : #accessing }
XPathASTElementTestForPrefixAndLocalNameNode >> localName: aLocalName [
	localName := aLocalName
]

{ #category : #printing }
XPathASTElementTestForPrefixAndLocalNameNode >> printTypeTestArgumentsOn: aStream [
	aStream
		nextPutAll: self prefix;
		nextPut: $:;
		nextPutAll: self localName
]
