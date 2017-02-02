"
This is an AST node class for the 'attribute(prefix:*)' type test or for the 'prefix:*' type test when the principal node type of the axis is 'attribute'.
"
Class {
	#name : #XPathASTAttributeTestForPrefixNode,
	#superclass : #XPathASTAttributeTestNode,
	#instVars : [
		'prefix'
	],
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #'instance creation' }
XPathASTAttributeTestForPrefixNode class >> prefix: aPrefix [
	^ self new prefix: aPrefix
]

{ #category : #visiting }
XPathASTAttributeTestForPrefixNode >> acceptNodeVisitor: aNodeVisitor [
	^ aNodeVisitor visitAttributeTestForPrefix: self
]

{ #category : #testing }
XPathASTAttributeTestForPrefixNode >> isAttributeTestForPrefix [
	^ true
]

{ #category : #accessing }
XPathASTAttributeTestForPrefixNode >> prefix [
	^ prefix ifNil: [prefix := '']
]

{ #category : #accessing }
XPathASTAttributeTestForPrefixNode >> prefix: aPrefix [
	prefix := aPrefix
]

{ #category : #printing }
XPathASTAttributeTestForPrefixNode >> printTypeTestArgumentsOn: aStream [
	aStream
		nextPutAll: self prefix;
		nextPutAll: ':*'
]
