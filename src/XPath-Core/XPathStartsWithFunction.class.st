"
XPath string prefix testing function.
"
Class {
	#name : #XPathStartsWithFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathStartsWithFunction class >> functionPrototypeSource [
	^ 'boolean starts-with(string, string)'
]

{ #category : #invoking }
XPathStartsWithFunction >> function [
	^ self firstArgument beginsWith: self lastArgument
]
