"
This is an AST node class for wrapping step and filter expression predicates.
"
Class {
	#name : #XPathASTPredicateNode,
	#superclass : #XPathASTNodeWithExpression,
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #visiting }
XPathASTPredicateNode >> acceptNodeVisitor: aNodeVisitor [
	^ aNodeVisitor visitPredicate: self
]

{ #category : #testing }
XPathASTPredicateNode >> isPredicate [
	^ true
]
