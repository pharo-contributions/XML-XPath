"
This is an AST node class for the 'element()' type test or for '*' type tests when the principal node type of the axis is an element.
"
Class {
	#name : #XPathASTElementTestNode,
	#superclass : #XPathASTNodeTestNode,
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #visiting }
XPathASTElementTestNode >> acceptNodeVisitor: aNodeVisitor [
	^ aNodeVisitor visitElementTest: self
]

{ #category : #testing }
XPathASTElementTestNode >> isElementTest [
	^ true
]
