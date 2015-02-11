"
XPath floor function.
"
Class {
	#name : #XPathFloorFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathFloorFunction class >> functionPrototype [
	^ 'number floor(number)'
]

{ #category : #invoking }
XPathFloorFunction >> function [
	^ self pop floor
]
