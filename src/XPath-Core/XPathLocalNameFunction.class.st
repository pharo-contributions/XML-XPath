"
XPath local name function.
"
Class {
	#name : #XPathLocalNameFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathLocalNameFunction class >> functionPrototypeSource [
	^ 'string local-name(node-set?)'
]

{ #category : #invoking }
XPathLocalNameFunction >> function [
	| node |

	self hasArguments
		ifTrue: [node := self firstArgument firstInDocumentOrder]
		ifFalse: [node := self contextNode].

	(node notNil
		and: [node hasExpandedName])
		ifTrue: [^ node localName]
		ifFalse: [^ '']
]
