"
XPath number rounding function.
"
Class {
	#name : #XPathRoundFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathRoundFunction class >> functionPrototypeSource [
	^ 'number round(number)'
]

{ #category : #invoking }
XPathRoundFunction >> function [
	^ self firstArgument rounded
]
