"
XPath whitespace normalization function to remove leading and trailing whitespace and turn multiple whitespace character sequences into single spaces.
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
	| string writeStream isInWhitespace |

	self hasPushedArguments
		ifTrue: [string := self pop]
		ifFalse: [string := self contextNode].

	writeStream := (String new: string size) writeStream.
	isInWhitespace := false.
	string do: [:each |
		each isSeparator
			ifTrue: [
				isInWhitespace
					ifFalse: [isInWhitespace := true]]
			ifFalse: [
				isInWhitespace
					ifTrue: [
						writeStream xmlParserAtBeginning
							ifFalse: [writeStream nextPut: $ ].
						isInWhitespace := false].
				writeStream nextPut: each]].
	^ writeStream contents.
]
