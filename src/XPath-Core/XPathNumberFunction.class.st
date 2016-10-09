"
XPath number conversion function.
"
Class {
	#name : #XPathNumberFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathNumberFunction class >> functionPrototypeSource [
	^ 'number number(object?)'
]

{ #category : #invoking }
XPathNumberFunction >> function [
	self hasArguments
		ifTrue: [^ self firstArgument]
		ifFalse: [^ self nodeSetClass with: self contextNode]
]
