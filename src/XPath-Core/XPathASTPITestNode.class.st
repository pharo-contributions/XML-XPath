"
This is an AST node class for the 'processing-instruction()' type test.
"
Class {
	#name : #XPathASTPITestNode,
	#superclass : #XPathASTNodeTestNode,
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #visiting }
XPathASTPITestNode >> acceptNodeVisitor: aNodeVisitor [
	^ aNodeVisitor visitPITest: self
]

{ #category : #testing }
XPathASTPITestNode >> isPITest [
	^ true
]
