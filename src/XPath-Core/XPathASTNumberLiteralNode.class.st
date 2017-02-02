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

{ #category : #private }
XPathASTNumberLiteralNode >> defaultTypeClass [
	^ XPathNumberType
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

{ #category : #printing }
XPathASTNumberLiteralNode >> printOn: aStream [
	self number isNaN
		ifTrue: [
			aStream nextPutAll: '(0 div 0)'.
			^ self].
	self number isInfinite
		ifTrue: [
			self number negative
				ifTrue: [aStream nextPutAll: '(-1 div 0)']
				ifFalse: [aStream nextPutAll: '(1 div 0)'].
			^ self].
	self number isZero
		ifTrue: [
			self number isXPathNegativeZero
				ifTrue: [aStream nextPutAll: '-0.0']
				ifFalse: [aStream nextPutAll: '0.0'].
			^ self].

	"otherwise, this is enough to get an acceptable integer or limited
	decimal (if the #fractionPart is non-zero) representation that an
	XPathExpressionParser or XPathNumberParser will understand"
	aStream nextPutAll: self asXPathString.
]
