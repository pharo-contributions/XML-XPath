"
XPath substring function. First argument is source string, second is one-based position, and third is substring length.
"
Class {
	#name : #XPathSubstringFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathSubstringFunction class >> functionPrototype [
	^ 'string substring(string, number, number?)'
]

{ #category : #invoking }
XPathSubstringFunction >> function [
	| string start length |

	self totalPushedArguments > 2
		ifTrue: [
			length := self pop rounded.
			start := self pop rounded.
			string := self pop]
		ifFalse: [
			start := self pop rounded.
			string := self pop.
			length := string size - start + 1].

	(length > 0 and: [start <= string size])
		ifTrue: [
			^ string
				copyFrom: (start max: 1)
				to: ((start max: 1) + length - 1 min: string size)]
		ifFalse: [^ '']	.
]
