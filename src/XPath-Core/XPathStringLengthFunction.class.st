"
XPath string length function.

"
Class {
	#name : #XPathStringLengthFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathStringLengthFunction class >> functionPrototype [
	^ 'number string-length(string?)'
]

{ #category : #invoking }
XPathStringLengthFunction >> function [
	self totalPushedArguments > 0
		ifTrue: [^ self pop size]
		ifFalse: [^ self contextNode asXPathString size]
]
