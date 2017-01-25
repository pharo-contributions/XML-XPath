"
This is an AST node class for the 'attribute()' type test or for the '*' type test when the principal node type of the axis is 'attribute'.
"
Class {
	#name : #XPathASTAttributeTestNode,
	#superclass : #XPathASTNodeTestNode,
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #visiting }
XPathASTAttributeTestNode >> acceptNodeVisitor: aNodeVisitor [
	^ aNodeVisitor visitAttributeTest: self
]

{ #category : #testing }
XPathASTAttributeTestNode >> isAttributeTest [
	^ true
]
