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
	self hasPushedArguments
		ifTrue: [^ self pop size]
		ifFalse: [^ self contextNode stringValue size]
]
