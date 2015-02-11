"
XPath namespace URI function.
"
Class {
	#name : #XPathNamespaceURIFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathNamespaceURIFunction class >> functionPrototype [
	^ 'string namespace-uri(node-set?)'
]

{ #category : #invoking }
XPathNamespaceURIFunction >> function [
	| node |

	self totalPushedArguments > 0
		ifTrue: [node := self pop firstInDocumentOrder]
		ifFalse: [node := self contextNode].

	(node notNil and: [node hasExpandedName])
		ifTrue: [^ node namespaceURI]
		ifFalse: [^ '']
]
