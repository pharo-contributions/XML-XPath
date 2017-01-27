"
This class can be used to control the iteration of node collections during iteration.
"
Class {
	#name : #XPathASTNodeVisitorIterator,
	#superclass : #Object,
	#instVars : [
		'stream',
		'previousVisited'
	],
	#category : #'XPath-Core-Compilation-AST'
}

{ #category : #'instance creation' }
XPathASTNodeVisitorIterator class >> null [
	^ self on: #()
]

{ #category : #'instance creation' }
XPathASTNodeVisitorIterator class >> on: aCollection [
	^ self new on: aCollection
]

{ #category : #accessing }
XPathASTNodeVisitorIterator >> atEnd [
	^ stream atEnd
]

{ #category : #accessing }
XPathASTNodeVisitorIterator >> next [
	^ stream atEnd
		ifTrue: [XPathASTNullNode new]
		ifFalse: [stream next]
]

{ #category : #initialization }
XPathASTNodeVisitorIterator >> on: aCollection [
	stream := aCollection readStream
]

{ #category : #accessing }
XPathASTNodeVisitorIterator >> peek [
	^ stream atEnd
		ifTrue: [XPathASTNullNode new]
		ifFalse: [stream peek]
]

{ #category : #accessing }
XPathASTNodeVisitorIterator >> previousVisited [
	^ previousVisited ifNil: [previousVisited := XPathASTNullNode new]
]

{ #category : #visiting }
XPathASTNodeVisitorIterator >> visitNextWith: aNodeVisitor [
	| node |

	((node := self next acceptNodeVisitor: aNodeVisitor) isNil
		or: [node isNull])
		ifTrue: [^ XPathASTNullNode new]
		ifFalse: [^ previousVisited := node]
]
