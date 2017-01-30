"
This is a base class for AST multiplicative expression nodes of the same precedence.
"
Class {
	#name : #XPathASTMultiplicativeExpressionNode,
	#superclass : #XPathASTBinaryOperatorExpressionNode,
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #private }
XPathASTMultiplicativeExpressionNode >> defaultTypeClass [
	^ XPathNumberType
]

{ #category : #testing }
XPathASTMultiplicativeExpressionNode >> isMultiplicativeExpression [
	^ true
]
