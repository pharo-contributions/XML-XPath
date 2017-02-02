"
This is a base class for location path step node test AST node classes.
"
Class {
	#name : #XPathASTNodeTestNode,
	#superclass : #XPathASTNode,
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #visiting }
XPathASTNodeTestNode >> acceptNodeVisitor: aNodeVisitor [
	^ aNodeVisitor visitNodeTest: self
]

{ #category : #testing }
XPathASTNodeTestNode >> isNodeTest [
	^ true
]

{ #category : #testing }
XPathASTNodeTestNode >> omitTypeTestWhenPrinting [
	^ false
]

{ #category : #printing }
XPathASTNodeTestNode >> printOn: aStream [
	self omitTypeTestWhenPrinting
		ifTrue: [self printTypeTestArgumentsOn: aStream]
		ifFalse: [
			aStream
				nextPutAll: self typeName;
				nextPut: $(.
			self printTypeTestArgumentsOn: aStream.
			aStream nextPut: $)]
]

{ #category : #printing }
XPathASTNodeTestNode >> printTypeTestArgumentsOn: aStream [
]

{ #category : #accessing }
XPathASTNodeTestNode >> typeName [
	self subclassResponsibility
]
