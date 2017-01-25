"
This is an AST node class for number literals.
"
Class {
	#name : #XPathASTNumberLiteralNode,
	#superclass : #XPathASTLiteralNode,
	#instVars : [
		'number',
		'xPathString'
	],
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #'instance creation' }
XPathASTNumberLiteralNode class >> number: aNumber [
	^ self new number: aNumber
]

{ #category : #visiting }
XPathASTNumberLiteralNode >> acceptNodeVisitor: aNodeVisitor [
	^ aNodeVisitor visitNumberLiteral: self
]

{ #category : #converting }
XPathASTNumberLiteralNode >> asXPathNumber [
	^ self number
]

{ #category : #converting }
XPathASTNumberLiteralNode >> asXPathString [
	^ xPathString ifNil: [xPathString := self number asXPathString]
]

{ #category : #testing }
XPathASTNumberLiteralNode >> isNumberLiteral [
	^ true
]

{ #category : #accessing }
XPathASTNumberLiteralNode >> number [
	^ number ifNil: [number := 0.0]
]

{ #category : #accessing }
XPathASTNumberLiteralNode >> number: aNumber [
	number := aNumber.
	xPathString := nil.
]
