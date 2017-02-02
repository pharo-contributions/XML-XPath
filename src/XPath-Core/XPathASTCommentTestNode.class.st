"
This is an AST node class for the 'comment()' type test.
"
Class {
	#name : #XPathASTCommentTestNode,
	#superclass : #XPathASTNodeTestNode,
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #visiting }
XPathASTCommentTestNode >> acceptNodeVisitor: aNodeVisitor [
	^ aNodeVisitor visitCommentTest: self
]

{ #category : #testing }
XPathASTCommentTestNode >> isCommentTest [
	^ true
]

{ #category : #accessing }
XPathASTCommentTestNode >> typeName [
	^ 'comment'
]
