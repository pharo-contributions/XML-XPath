"
XPath node set count (size) function.
"
Class {
	#name : #XPathCountFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathCountFunction class >> functionPrototypeSource [
	^ 'number count(node-set)'
]

{ #category : #invoking }
XPathCountFunction >> function [
	^ self pop size
]
