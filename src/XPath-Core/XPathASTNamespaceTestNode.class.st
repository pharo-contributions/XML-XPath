"
This is an AST node class for the 'namespace()' type test or for '*' type tests when the principal node type of the axis is an namespace.
"
Class {
	#name : #XPathASTNamespaceTestNode,
	#superclass : #XPathASTNodeTestNode,
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #visiting }
XPathASTNamespaceTestNode >> acceptNodeVisitor: aNodeVisitor [
	^ aNodeVisitor visitNamespaceTest: self
]

{ #category : #testing }
XPathASTNamespaceTestNode >> isNamespaceTest [
	^ true
]

{ #category : #testing }
XPathASTNamespaceTestNode >> omitTypeTestWhenPrinting [
	^ self hasParent
		and: [self parent isNamespaceStep]
]

{ #category : #printing }
XPathASTNamespaceTestNode >> printTypeTestArgumentsOn: aStream [
	aStream nextPut: $*
]

{ #category : #accessing }
XPathASTNamespaceTestNode >> typeName [
	^ 'namespace'
]
