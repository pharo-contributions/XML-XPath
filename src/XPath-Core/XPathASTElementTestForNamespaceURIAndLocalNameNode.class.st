"
This is an AST node class for the 'element(Q{namespaceURI}localName)' type test or for the 'Q{namespaceURI}localName' type test when the principal node type of the axis is 'element'.
"
Class {
	#name : #XPathASTElementTestForNamespaceURIAndLocalNameNode,
	#superclass : #XPathASTElementTestForNamespaceURINode,
	#instVars : [
		'localName'
	],
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #'instance creation' }
XPathASTElementTestForNamespaceURIAndLocalNameNode class >> namespaceURI: aURI localName: aLocalName [
	^ (self namespaceURI: aURI) localName: aLocalName
]

{ #category : #visiting }
XPathASTElementTestForNamespaceURIAndLocalNameNode >> acceptNodeVisitor: aNodeVisitor [
	^ aNodeVisitor visitElementTestForNamespaceURIAndLocalName: self
]

{ #category : #testing }
XPathASTElementTestForNamespaceURIAndLocalNameNode >> isElementTestForNamespaceURIAndLocalName [
	^ true
]

{ #category : #accessing }
XPathASTElementTestForNamespaceURIAndLocalNameNode >> localName [
	^ localName ifNil: [localName := '']
]

{ #category : #accessing }
XPathASTElementTestForNamespaceURIAndLocalNameNode >> localName: aLocalName [
	localName := aLocalName
]

{ #category : #printing }
XPathASTElementTestForNamespaceURIAndLocalNameNode >> printTypeTestArgumentsOn: aStream [
	aStream nextPutAll:
		(self localName expandWithXMLNamespaceURI: self namespaceURI)
]
