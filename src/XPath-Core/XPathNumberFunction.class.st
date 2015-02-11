"
XPath number conversion function.
"
Class {
	#name : #XPathNumberFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathNumberFunction class >> functionPrototype [
	^ 'number number(object?)'
]

{ #category : #invoking }
XPathNumberFunction >> function [
	self totalPushedArguments > 0
		ifTrue: [^ self pop]
		ifFalse: [^ XPathNodeSet with: self contextNode]
]
