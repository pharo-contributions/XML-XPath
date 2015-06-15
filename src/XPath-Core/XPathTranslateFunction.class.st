"
XPath function to replace/delete all occurances of certain characters in a string.
"
Class {
	#name : #XPathTranslateFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathTranslateFunction class >> functionPrototype [
	^ 'string translate(string, string, string)'
]

{ #category : #invoking }
XPathTranslateFunction >> function [
	| replacementTable replacementString searchString sourceString writeStream |

	replacementTable := IdentityDictionary new.
	replacementString := self pop.
	searchString := self pop.
	1 to: searchString size do: [:i |
		replacementTable
			at: (searchString at: i)
			ifAbsentPut: (replacementString at: i ifAbsent: [nil])].

	sourceString := self pop.
	writeStream  := (String new: sourceString size) writeStream.
	sourceString do: [:each |	
		(replacementTable at: each ifAbsent: [each])
			ifNotNil: [:nextChar | writeStream  nextPut: nextChar]].
	^ writeStream  contents.
]
