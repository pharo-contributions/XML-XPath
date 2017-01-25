"
This is an AST node class for 'attribute::' (or '@') steps.
"
Class {
	#name : #XPathASTAttributeStepNode,
	#superclass : #XPathASTStepNode,
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #visiting }
XPathASTAttributeStepNode >> acceptNodeVisitor: aNodeVisitor [
	^ aNodeVisitor visitAttributeStep: self
]

{ #category : #testing }
XPathASTAttributeStepNode >> isAttributeStep [
	^ true
]

{ #category : #testing }
XPathASTAttributeStepNode >> isForwardAxisStep [
	^ true
]
