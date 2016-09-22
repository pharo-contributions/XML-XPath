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
	self hasPushedArguments
		ifTrue: [^ self pop]
		ifFalse: [^ self nodeSetClass with: self contextNode]
]
