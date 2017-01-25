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
