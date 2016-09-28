"
XPath floor function.
"
Class {
	#name : #XPathFloorFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathFloorFunction class >> functionPrototypeSource [
	^ 'number floor(number)'
]

{ #category : #invoking }
XPathFloorFunction >> function [
	^ self pop floor
]
