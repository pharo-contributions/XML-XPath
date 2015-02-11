"
XPath name function.
"
Class {
	#name : #XPathNameFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathNameFunction class >> functionPrototype [
	^ 'string name(node-set?)'
]

{ #category : #invoking }
XPathNameFunction >> function [
	| node |

	self totalPushedArguments > 0
		ifTrue: [node := self pop firstInDocumentOrder]
		ifFalse: [node := self contextNode].

	(node notNil and: [node hasExpandedName])
		ifTrue: [| namespaceUri |
			(self context hasNamespaces
				and: [(namespaceUri := node namespaceURI) notEmpty
					and: [node hasPrefix]])
				ifTrue: [
					^ node localName qualifyWithPrefix:
						(self context prefixOfNamespaceURI: namespaceUri)]
				ifFalse: [^ node name]]
		ifFalse: [^ ''].
]
