"
XPath whitespace normalization function to remove leading and trailing whitespace and turn whitespace sequences into single spaces.
"
Class {
	#name : #XPathNormalizeSpaceFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathNormalizeSpaceFunction class >> functionPrototype [
	^ 'string normalize-space(string?)'
]

{ #category : #invoking }
XPathNormalizeSpaceFunction >> function [
	| string writeStream isInWhitespace normalizedSpace |

	self hasPushedArguments
		ifTrue: [string := self pop]
		ifFalse: [string := self contextNode].

	"must use #writeStream instead of WriteStream on: to get a 0-based stream
	on Gemstone"
	writeStream := (String new: string size) writeStream.
	isInWhitespace := false.
	normalizedSpace := Character space.
	string do: [:each |
		each xmlParserIsSeparator
			ifTrue: [
				isInWhitespace
					ifFalse: [isInWhitespace := true]]
			ifFalse: [
				isInWhitespace
					ifTrue: [
						writeStream position > 0
							ifTrue: [writeStream nextPut: normalizedSpace].
						isInWhitespace := false].
				writeStream nextPut: each]].
	^ writeStream contents.
]
