"
XPath boolean conversion function.
"
Class {
	#name : #XPathBooleanFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathBooleanFunction class >> prototypeSource [
	^ 'boolean boolean(object)'
]

{ #category : #invoking }
XPathBooleanFunction >> function [
	^ self firstArgument
]
