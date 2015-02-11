"
XPath substring before function.
"
Class {
	#name : #XPathSubstringBeforeFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathSubstringBeforeFunction class >> functionPrototype [
	^ 'string substring-before(string, string)'
]

{ #category : #invoking }
XPathSubstringBeforeFunction >> function [
	| substring string indexOfSubstring |

	substring := self pop.
	string := self pop.
	(indexOfSubstring :=
		string
			findString: substring
			startingAt: 1) > 0
		ifTrue: [
			^ string
				copyFrom: 1
				to:indexOfSubstring - 1]
		ifFalse: [^ ''].
]
