"
This is an AST node class for the 'element(Q{namespaceURI}*)' type test or for the 'Q{namespaceURI}*' type test when the principal node type of the axis is 'element'.
"
Class {
	#name : #XPathASTElementTestForNamespaceURINode,
	#superclass : #XPathASTElementTestNode,
	#instVars : [
		'namespaceURI'
	],
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #'instance creation' }
XPathASTElementTestForNamespaceURINode class >> namespaceURI: aURI [
	^ self new namespaceURI: aURI
]

{ #category : #visiting }
XPathASTElementTestForNamespaceURINode >> acceptNodeVisitor: aNodeVisitor [
	^ aNodeVisitor visitElementTestForNamespaceURI: self
]

{ #category : #testing }
XPathASTElementTestForNamespaceURINode >> isElementTestForNamespaceURI [
	^ true
]

{ #category : #accessing }
XPathASTElementTestForNamespaceURINode >> namespaceURI [
	^ namespaceURI ifNil: [namespaceURI := '']
]

{ #category : #accessing }
XPathASTElementTestForNamespaceURINode >> namespaceURI: aURI [
	namespaceURI := aURI
]

{ #category : #printing }
XPathASTElementTestForNamespaceURINode >> printTypeTestArgumentsOn: aStream [
	aStream nextPutAll:
		('*' expandWithXMLNamespaceURI: self namespaceURI)
]
