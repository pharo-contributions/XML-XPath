"
XPath whitespace normalizeation function.
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

	self totalPushedArguments > 0
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
