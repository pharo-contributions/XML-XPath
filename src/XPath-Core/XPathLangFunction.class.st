"
XPath xml:lang testing function.
"
Class {
	#name : #XPathLangFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathLangFunction class >> functionPrototype [
	^ 'boolean lang(string)'
]

{ #category : #invoking }
XPathLangFunction >> function [
	| language |

	language := self pop.
	^ self contextNode isInLanguage: language.
]
