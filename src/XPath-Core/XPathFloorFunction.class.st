"
XPath floor function.
"
Class {
	#name : #XPathFloorFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathFloorFunction class >> prototypeSource [
	^ 'number floor(number)'
]

{ #category : #invoking }
XPathFloorFunction >> function [
	^ self firstArgument xpathFloor
]
