"
XPath string length function.

"
Class {
	#name : #XPathStringLengthFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathStringLengthFunction class >> functionPrototypeSource [
	^ 'number string-length(string?)'
]

{ #category : #invoking }
XPathStringLengthFunction >> function [
	self hasArguments
		ifTrue: [^ self firstArgument size]
		ifFalse: [^ self contextNode stringValue size]
]
