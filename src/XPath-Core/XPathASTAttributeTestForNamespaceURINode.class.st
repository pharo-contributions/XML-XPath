"
This is an AST node class for the 'attribute(Q{namespaceURI}*)' type test or for the 'Q{namespaceURI}*' type test when the principal node type of the axis is 'attribute'.
"
Class {
	#name : #XPathASTAttributeTestForNamespaceURINode,
	#superclass : #XPathASTAttributeTestNode,
	#instVars : [
		'namespaceURI'
	],
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #'instance creation' }
XPathASTAttributeTestForNamespaceURINode class >> namespaceURI: aURI [
	^ self new namespaceURI: aURI
]

{ #category : #visiting }
XPathASTAttributeTestForNamespaceURINode >> acceptNodeVisitor: aNodeVisitor [
	^ aNodeVisitor visitAttributeTestForNamespaceURI: self
]

{ #category : #testing }
XPathASTAttributeTestForNamespaceURINode >> isAttributeTestForNamespaceURI [
	^ true
]

{ #category : #accessing }
XPathASTAttributeTestForNamespaceURINode >> namespaceURI [
	^ namespaceURI ifNil: [namespaceURI := '']
]

{ #category : #accessing }
XPathASTAttributeTestForNamespaceURINode >> namespaceURI: aURI [
	namespaceURI := aURI
]

{ #category : #printing }
XPathASTAttributeTestForNamespaceURINode >> printTypeTestArgumentsOn: aStream [
	aStream nextPutAll:
		('*' expandWithXMLNamespaceURI: self namespaceURI)
]
