"
XPath string concatenation function. Concatenates two or more strings.
"
Class {
	#name : #XPathConcatFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathConcatFunction class >> functionPrototypeSource [
	^ 'string concat(string, string, string*)'
]

{ #category : #invoking }
XPathConcatFunction >> function [
	| concatenation |

	concatenation := self pop.
	[self hasPushedArguments]
		whileTrue: [concatenation := self pop, concatenation].
	^ concatenation.
]
