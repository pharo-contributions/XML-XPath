"
XPath lang() function to test if the context node is in the scope of an xml:lang attribute value matching the argument.
"
Class {
	#name : #XPathLangFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathLangFunction class >> functionPrototypeSource [
	^ 'boolean lang(string)'
]

{ #category : #invoking }
XPathLangFunction >> function [
	| language |

	language := self pop.
	^ self contextNode isInLanguage: language.
]
