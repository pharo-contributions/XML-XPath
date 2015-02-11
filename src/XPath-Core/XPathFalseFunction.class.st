"
XPath false function.
"
Class {
	#name : #XPathFalseFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathFalseFunction class >> functionPrototype [
	^ 'boolean false()'
]

{ #category : #invoking }
XPathFalseFunction >> function [
	^ false
]
