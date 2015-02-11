"
XPath substring after function.
"
Class {
	#name : #XPathSubstringAfterFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathSubstringAfterFunction class >> functionPrototype [
	^ 'string substring-after(string, string)'
]

{ #category : #invoking }
XPathSubstringAfterFunction >> function [
	| substring string indexOfSubstring |

	substring := self pop.
	string := self pop.
	(indexOfSubstring :=
		string
			findString: substring
			startingAt: 1) > 0
		ifTrue: [
			^ string
				copyFrom: indexOfSubstring + substring size
				to: string size]
		ifFalse: [^ ''].
]
