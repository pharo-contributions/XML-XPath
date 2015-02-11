"
XPath string concatenation function.
"
Class {
	#name : #XPathConcatFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathConcatFunction class >> functionPrototype [
	^ 'string concat(string, string, string*)'
]

{ #category : #invoking }
XPathConcatFunction >> function [
	| concatenation |

	concatenation := self pop.
	[self totalPushedArguments > 0]
		whileTrue: [concatenation := self pop, concatenation].
	^ concatenation.
]
