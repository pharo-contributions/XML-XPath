"
XPath true function.
"
Class {
	#name : #XPathTrueFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathTrueFunction class >> functionPrototype [
	^ 'boolean true()'
]

{ #category : #invoking }
XPathTrueFunction >> function [
	^ true
]
