"
XPath boolean conversion function.
"
Class {
	#name : #XPathBooleanFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathBooleanFunction class >> functionPrototype [
	^ 'boolean boolean(object)'
]

{ #category : #invoking }
XPathBooleanFunction >> function [
	^ self pop
]
