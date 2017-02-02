"
This is an AST node class for the 'element(prefix:*)' type test or for the 'prefix:*' type test when the principal node type of the axis is 'element'.
"
Class {
	#name : #XPathASTElementTestForPrefixNode,
	#superclass : #XPathASTElementTestNode,
	#instVars : [
		'prefix'
	],
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #'instance creation' }
XPathASTElementTestForPrefixNode class >> prefix: aPrefix [
	^ self new prefix: aPrefix
]

{ #category : #visiting }
XPathASTElementTestForPrefixNode >> acceptNodeVisitor: aNodeVisitor [
	^ aNodeVisitor visitElementTestForPrefix: self
]

{ #category : #testing }
XPathASTElementTestForPrefixNode >> isElementTestForPrefix [
	^ true
]

{ #category : #accessing }
XPathASTElementTestForPrefixNode >> prefix [
	^ prefix ifNil: [prefix := '']
]

{ #category : #accessing }
XPathASTElementTestForPrefixNode >> prefix: aPrefix [
	prefix := aPrefix
]

{ #category : #printing }
XPathASTElementTestForPrefixNode >> printTypeTestArgumentsOn: aStream [
	aStream
		nextPutAll: self prefix;
		nextPutAll: ':*'
]
