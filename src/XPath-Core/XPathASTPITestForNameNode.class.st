"
This is an AST node class for the 'processing-instruction(name)' type test.
"
Class {
	#name : #XPathASTPITestForNameNode,
	#superclass : #XPathASTPITestNode,
	#instVars : [
		'name'
	],
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #'instance creation' }
XPathASTPITestForNameNode class >> name: aName [
	^ self new name: aName
]

{ #category : #visiting }
XPathASTPITestForNameNode >> acceptNodeVisitor: aNodeVisitor [
	^ aNodeVisitor visitPITestForName: self
]

{ #category : #testing }
XPathASTPITestForNameNode >> isPITestForName [
	^ true
]

{ #category : #accessing }
XPathASTPITestForNameNode >> name [
	^ name ifNil: [name := '']
]

{ #category : #accessing }
XPathASTPITestForNameNode >> name: aName [
	name := aName
]

{ #category : #printing }
XPathASTPITestForNameNode >> printTypeTestArgumentsOn: aStream [
	aStream nextPutAll: self name
]
