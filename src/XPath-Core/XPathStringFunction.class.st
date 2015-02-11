"
XPath string conversion function.
"
Class {
	#name : #XPathStringFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathStringFunction class >> functionPrototype [
	^ 'string string(object?)'
]

{ #category : #invoking }
XPathStringFunction >> function [
	^ self pop
]
