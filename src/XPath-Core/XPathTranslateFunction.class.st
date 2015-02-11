"
XPath string search and replacement function.
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
	| replacementTable translatedString replacementString searchString sourceString |

	replacementTable := IdentityDictionary new.
	replacementString := self pop.
	searchString := self pop.
	1 to: searchString size do: [:i |
		replacementTable
			at: (searchString at: i)
			ifAbsentPut: (replacementString at: i ifAbsent: [nil])].

	sourceString := self pop.
	translatedString := (String new: sourceString size) writeStream.
	sourceString do: [:each |	
		(replacementTable at: each ifAbsent: [each])
			ifNotNil: [:nextChar |
				translatedString nextPut: nextChar]].
	^ translatedString contents.
]
