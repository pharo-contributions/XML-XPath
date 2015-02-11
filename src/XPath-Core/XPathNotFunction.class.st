"
XPath negation function.
"
Class {
	#name : #XPathNotFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathNotFunction class >> functionPrototype [
	^ 'boolean not(boolean)'
]

{ #category : #invoking }
XPathNotFunction >> function [
	^ self pop not
]
