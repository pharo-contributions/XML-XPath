"
This is an AST node class for the 'attribute(*:localName)' type test or for the '*:localName' type test when the principal node type of the axis is 'attribute'.
"
Class {
	#name : #XPathASTAttributeTestForLocalNameNode,
	#superclass : #XPathASTAttributeTestNode,
	#instVars : [
		'localName'
	],
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #'instance creation' }
XPathASTAttributeTestForLocalNameNode class >> localName: aLocalName [
	^ self new localName: aLocalName
]

{ #category : #visiting }
XPathASTAttributeTestForLocalNameNode >> acceptNodeVisitor: aNodeVisitor [
	^ aNodeVisitor visitAttributeTestForLocalName: self
]

{ #category : #testing }
XPathASTAttributeTestForLocalNameNode >> isAttributeTestForLocalName [
	^ true
]

{ #category : #accessing }
XPathASTAttributeTestForLocalNameNode >> localName [
	^ localName ifNil: [localName := '']
]

{ #category : #accessing }
XPathASTAttributeTestForLocalNameNode >> localName: aLocalName [
	localName := aLocalName
]

{ #category : #printing }
XPathASTAttributeTestForLocalNameNode >> printTypeTestArgumentsOn: aStream [
	aStream nextPutAll: self localName
]
