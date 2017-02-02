"
This is an AST node class for the 'attribute(name)' type test or for the 'name' type test when the principal node type of the axis is 'attribute'.
"
Class {
	#name : #XPathASTAttributeTestForNameNode,
	#superclass : #XPathASTAttributeTestNode,
	#instVars : [
		'name'
	],
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #'instance creation' }
XPathASTAttributeTestForNameNode class >> name: aName [
	^ self new name: aName
]

{ #category : #visiting }
XPathASTAttributeTestForNameNode >> acceptNodeVisitor: aNodeVisitor [
	^ aNodeVisitor visitAttributeTestForName: self
]

{ #category : #testing }
XPathASTAttributeTestForNameNode >> isAttributeTestForName [
	^ true
]

{ #category : #accessing }
XPathASTAttributeTestForNameNode >> name [
	^ name ifNil: [name := '']
]

{ #category : #accessing }
XPathASTAttributeTestForNameNode >> name: aName [
	name := aName
]

{ #category : #printing }
XPathASTAttributeTestForNameNode >> printTypeTestArgumentsOn: aStream [
	aStream nextPutAll: self name
]
