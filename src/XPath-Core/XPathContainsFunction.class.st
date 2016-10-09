"
XPath contains substring function.
"
Class {
	#name : #XPathContainsFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathContainsFunction class >> functionPrototypeSource [
	^ 'boolean contains(string, string)'
]

{ #category : #invoking }
XPathContainsFunction >> function [
	"use findString:startingAt: for portability"
	^ (self firstArgument
		findString: self lastArgument
		startingAt: 1) > 0
]
