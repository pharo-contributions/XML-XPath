"
This is an AST node class for the 'attribute(prefix:localName)' type test or for the 'prefix:localName' type test when the principal node type of the axis is 'attribute'.
"
Class {
	#name : #XPathASTAttributeTestForPrefixAndLocalNameNode,
	#superclass : #XPathASTAttributeTestForPrefixNode,
	#instVars : [
		'localName'
	],
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #'instance creation' }
XPathASTAttributeTestForPrefixAndLocalNameNode class >> prefix: aPrefix localName: aLocalName [
	^ (self prefix: aPrefix) localName: aLocalName
]

{ #category : #visiting }
XPathASTAttributeTestForPrefixAndLocalNameNode >> acceptNodeVisitor: aNodeVisitor [
	^ aNodeVisitor visitAttributeTestForPrefixAndLocalName: self
]

{ #category : #testing }
XPathASTAttributeTestForPrefixAndLocalNameNode >> isAttributeTestForPrefixAndLocalName [
	^ true
]

{ #category : #accessing }
XPathASTAttributeTestForPrefixAndLocalNameNode >> localName [
	^ localName ifNil: [localName := '']
]

{ #category : #accessing }
XPathASTAttributeTestForPrefixAndLocalNameNode >> localName: aLocalName [
	localName := aLocalName
]
