"
XPath number conversion function.
"
Class {
	#name : #XPathNumberFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathNumberFunction class >> prototypeSource [
	^ 'number number(object?)'
]

{ #category : #invoking }
XPathNumberFunction >> function [
	self hasArguments
		ifTrue: [^ self firstArgument]
		ifFalse: [
			"From the spec: 'If the argument is omitted, it defaults to a
			node-set with the context node as its only member.'"
			^ self nodeSetClass with: self contextNode]
]
