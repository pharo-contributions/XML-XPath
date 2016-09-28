"
XPath ceiling function.
"
Class {
	#name : #XPathCeilingFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathCeilingFunction class >> functionPrototypeSource [
	^ 'number ceiling(number)'
]

{ #category : #invoking }
XPathCeilingFunction >> function [
	^ self pop ceiling
]
