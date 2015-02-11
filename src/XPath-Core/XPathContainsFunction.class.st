"
XPath contains substring function.
"
Class {
	#name : #XPathContainsFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathContainsFunction class >> functionPrototype [
	^ 'boolean contains(string, string)'
]

{ #category : #invoking }
XPathContainsFunction >> function [
	| substring |

	substring := self pop.
	"use findString:startingAt: for portability"
	^ (self pop
		findString: substring
		startingAt: 1) > 0
]
