"
This is an AST node class for 'following::' steps.
"
Class {
	#name : #XPathASTFollowingStepNode,
	#superclass : #XPathASTStepNode,
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #visiting }
XPathASTFollowingStepNode >> acceptNodeVisitor: aNodeVisitor [
	^ aNodeVisitor visitFollowingStep: self
]

{ #category : #testing }
XPathASTFollowingStepNode >> isFollowingStep [
	^ true
]

{ #category : #testing }
XPathASTFollowingStepNode >> isForwardAxisStep [
	^ true
]
