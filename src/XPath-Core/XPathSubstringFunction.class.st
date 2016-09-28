"
XPath substring function. First argument is the source string, second is the one-based position, and third is the substring length.
"
Class {
	#name : #XPathSubstringFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathSubstringFunction class >> functionPrototypeSource [
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

	(length > 0
		and: [start <= string size])
		ifTrue: [
			^ string
				copyFrom: (start max: 1)
				to: ((start max: 1) + length - 1 min: string size)]
		ifFalse: [^ '']	.
]
