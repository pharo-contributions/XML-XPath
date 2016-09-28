"
XPath boolean conversion function.
"
Class {
	#name : #XPathBooleanFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathBooleanFunction class >> functionPrototypeSource [
	^ 'boolean boolean(object)'
]

{ #category : #invoking }
XPathBooleanFunction >> function [
	^ self pop
]
