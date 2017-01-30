"
This is a base class for relational expression AST nodes.
"
Class {
	#name : #XPathASTRelationalExpressionNode,
	#superclass : #XPathASTBinaryOperatorExpressionNode,
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #private }
XPathASTRelationalExpressionNode >> defaultTypeClass [
	^ XPathBooleanType
]

{ #category : #testing }
XPathASTRelationalExpressionNode >> isRelationalExpression [
	^ true
]
