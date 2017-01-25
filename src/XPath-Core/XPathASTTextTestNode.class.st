"
This is an AST node class for the 'text()' type test.
"
Class {
	#name : #XPathASTTextTestNode,
	#superclass : #XPathASTNodeTestNode,
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #visiting }
XPathASTTextTestNode >> acceptNodeVisitor: aNodeVisitor [
	^ aNodeVisitor visitTextTest: self
]

{ #category : #testing }
XPathASTTextTestNode >> isTextTest [
	^ true
]
