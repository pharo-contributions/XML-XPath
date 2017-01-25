"
This is an AST node class for the 'attribute(Q{namespaceURI}localName)' type test or for the 'Q{namespaceURI}localName' type test when the principal node type of the axis is 'attribute'.
"
Class {
	#name : #XPathASTAttributeTestForNamespaceURIAndLocalNameNode,
	#superclass : #XPathASTAttributeTestForNamespaceURINode,
	#instVars : [
		'localName'
	],
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #'instance creation' }
XPathASTAttributeTestForNamespaceURIAndLocalNameNode class >> namespaceURI: aURI localName: aLocalName [
	^ (self namespaceURI: aURI) localName: aLocalName
]

{ #category : #visiting }
XPathASTAttributeTestForNamespaceURIAndLocalNameNode >> acceptNodeVisitor: aNodeVisitor [
	^ aNodeVisitor visitAttributeTestForNamespaceURIAndLocalName: self
]

{ #category : #testing }
XPathASTAttributeTestForNamespaceURIAndLocalNameNode >> isAttributeTestForNamespaceURIAndLocalName [
	^ true
]

{ #category : #accessing }
XPathASTAttributeTestForNamespaceURIAndLocalNameNode >> localName [
	^ localName ifNil: [localName := '']
]

{ #category : #accessing }
XPathASTAttributeTestForNamespaceURIAndLocalNameNode >> localName: aLocalName [
	localName := aLocalName
]
