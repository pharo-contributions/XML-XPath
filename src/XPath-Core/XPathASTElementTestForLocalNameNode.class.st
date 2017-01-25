"
This is an AST node class for the 'element(*:localName)' type test or for the '*:localName' type test when the principal node type of the axis is 'element'.
"
Class {
	#name : #XPathASTElementTestForLocalNameNode,
	#superclass : #XPathASTElementTestNode,
	#instVars : [
		'localName'
	],
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #'instance creation' }
XPathASTElementTestForLocalNameNode class >> localName: aLocalName [
	^ self new localName: aLocalName
]

{ #category : #visiting }
XPathASTElementTestForLocalNameNode >> acceptNodeVisitor: aNodeVisitor [
	^ aNodeVisitor visitElementTestForLocalName: self
]

{ #category : #testing }
XPathASTElementTestForLocalNameNode >> isElementTestForLocalName [
	^ true
]

{ #category : #accessing }
XPathASTElementTestForLocalNameNode >> localName [
	^ localName ifNil: [localName := '']
]

{ #category : #accessing }
XPathASTElementTestForLocalNameNode >> localName: aLocalName [
	localName := aLocalName
]
