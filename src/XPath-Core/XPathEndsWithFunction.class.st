"
Non-standard, but added for completeness with starts-with().
"
Class {
	#name : #XPathEndsWithFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathEndsWithFunction class >> functionPrototype [
	^ 'boolean ends-with(string, string)'
]

{ #category : #invoking }
XPathEndsWithFunction >> function [
	| substring |

	substring := self pop.
	^ self pop endsWith: substring.
]
