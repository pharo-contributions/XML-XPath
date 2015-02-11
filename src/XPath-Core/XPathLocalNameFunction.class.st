"
XPath local name function.
"
Class {
	#name : #XPathLocalNameFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathLocalNameFunction class >> functionPrototype [
	^ 'string local-name(node-set?)'
]

{ #category : #invoking }
XPathLocalNameFunction >> function [
	| node |

	self totalPushedArguments > 0
		ifTrue: [node := self pop firstInDocumentOrder]
		ifFalse: [node := self contextNode].

	(node notNil and: [node hasExpandedName])
		ifTrue: [^ node localName]
		ifFalse: [^ '']
]
