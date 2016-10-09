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

	string := self argumentAt: 1.
	start := (self argumentAt: 2) rounded.
	self totalArguments > 2
		ifTrue: [length := (self argumentAt: 3) rounded]
		ifFalse: [length := string size - start + 1].

	(length > 0
		and: [start <= string size])
		ifTrue: [
			^ string
				copyFrom: (start max: 1)
				to: ((start max: 1) + length - 1 min: string size)]
		ifFalse: [^ '']	.
]
