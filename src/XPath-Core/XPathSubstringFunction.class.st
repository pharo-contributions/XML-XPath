"
XPath substring function. First argument is the source string, second is the one-based position, and third is the substring length.
"
Class {
	#name : #XPathSubstringFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathSubstringFunction class >> prototypeSource [
	^ 'string substring(string, number, number?)'
]

{ #category : #invoking }
XPathSubstringFunction >> function [
	| string start end |

	string := self argumentAt: 1.
	start := (self argumentAt: 2) xPathRounded.
	self totalArguments > 2
		ifTrue: [end := start + (self argumentAt: 3) xPathRounded - 1]
		ifFalse: [end := string size].

	"if either start or end are NaN, the test will fail"
	(start <= end
		and: [start <= string size
			and: [end >= 1]])
		ifTrue: [
			"must convert these to integers, because #copyFrom:to: doesn't take
			floats, and the #min:/#max: will eliminate +/- infinity"
			^ string
				copyFrom: (start max: 1) asInteger
				to: (end min: string size) asInteger]
		ifFalse: [^ '']	.
]
