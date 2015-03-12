"
XPath name function. Returns expanded name or local name of a node or empty string if node has no name. Operates on argument node or the context node if called with no arguments.
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
					((self context prefixesOfNamespaceURI: namespaceUri)
						ifEmpty: [^ node localName]
						ifNotEmpty: [:prefixes |
							^ node localName qualifyWithPrefix: prefixes anyOne])]
				ifFalse: [^ node name]]
		ifFalse: [^ ''].
]
