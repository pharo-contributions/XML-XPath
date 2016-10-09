"
Non-standard; added for completeness with starts-with().
"
Class {
	#name : #XPathEndsWithFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathEndsWithFunction class >> functionPrototypeSource [
	^ 'boolean ends-with(string, string)'
]

{ #category : #invoking }
XPathEndsWithFunction >> function [
	^ self firstArgument endsWith: self lastArgument
]
