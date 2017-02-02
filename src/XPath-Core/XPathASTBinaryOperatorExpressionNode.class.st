"
This is a base class for binary operator expression AST nodes.
"
Class {
	#name : #XPathASTBinaryOperatorExpressionNode,
	#superclass : #XPathASTNodeWithOtherExpression,
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #visiting }
XPathASTBinaryOperatorExpressionNode >> acceptNodeVisitor: aNodeVisitor [
	^ aNodeVisitor visitBinaryOperatorExpression: self
]

{ #category : #testing }
XPathASTBinaryOperatorExpressionNode >> isBinaryOperatorExpression [
	^ true
]

{ #category : #testing }
XPathASTBinaryOperatorExpressionNode >> isOperatorExpression [
	^ true
]

{ #category : #accessing }
XPathASTBinaryOperatorExpressionNode >> operatorName [
	self subclassResponsibility
]

{ #category : #printing }
XPathASTBinaryOperatorExpressionNode >> printOn: aStream [
	aStream nextPut: $(.
	super printOn: aStream.
	aStream
		space;
		nextPutAll: self operatorName;
		space;
		print: self otherExpression;
		nextPut: $).
]
