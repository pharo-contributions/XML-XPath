"
This is an AST node class for string literals. The string is stored without quotes.
"
Class {
	#name : #XPathASTStringLiteralNode,
	#superclass : #XPathASTLiteralNode,
	#instVars : [
		'string',
		'xPathNumber'
	],
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #'instance creation' }
XPathASTStringLiteralNode class >> string: aString [
	^ self new string: aString
]

{ #category : #visiting }
XPathASTStringLiteralNode >> acceptNodeVisitor: aNodeVisitor [
	^ aNodeVisitor visitStringLiteral: self
]

{ #category : #converting }
XPathASTStringLiteralNode >> asXPathNumber [
	^ xPathNumber ifNil: [xPathNumber := self string asXPathNumber]
]

{ #category : #converting }
XPathASTStringLiteralNode >> asXPathString [
	^ self string
]

{ #category : #testing }
XPathASTStringLiteralNode >> isStringLiteral [
	^ true
]

{ #category : #accessing }
XPathASTStringLiteralNode >> string [
	^ string ifNil: [string := '']
]

{ #category : #accessing }
XPathASTStringLiteralNode >> string: aString [
	string := aString.
	xPathNumber := nil.
]
