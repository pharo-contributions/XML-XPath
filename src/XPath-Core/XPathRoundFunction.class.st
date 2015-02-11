"
XPath number rounding function.
"
Class {
	#name : #XPathRoundFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathRoundFunction class >> functionPrototype [
	^ 'number round(number)'
]

{ #category : #invoking }
XPathRoundFunction >> function [
	^ self pop rounded
]
