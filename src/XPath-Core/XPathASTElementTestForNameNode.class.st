"
This is an AST node class for the 'element(name)' type test or for the 'name' type test when the principal node type of the axis is 'element'.
"
Class {
	#name : #XPathASTElementTestForNameNode,
	#superclass : #XPathASTElementTestNode,
	#instVars : [
		'name'
	],
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #'instance creation' }
XPathASTElementTestForNameNode class >> name: aName [
	^ self new name: aName
]

{ #category : #visiting }
XPathASTElementTestForNameNode >> acceptNodeVisitor: aNodeVisitor [
	^ aNodeVisitor visitElementTestForName: self
]

{ #category : #testing }
XPathASTElementTestForNameNode >> isElementTestForName [
	^ true
]

{ #category : #accessing }
XPathASTElementTestForNameNode >> name [
	^ name ifNil: [name := '']
]

{ #category : #accessing }
XPathASTElementTestForNameNode >> name: aName [
	name := aName
]
