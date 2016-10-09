"
XPath string concatenation function. Concatenates two or more strings.
"
Class {
	#name : #XPathConcatFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathConcatFunction class >> functionPrototypeSource [
	^ 'string concat(string, string, string*)'
]

{ #category : #invoking }
XPathConcatFunction >> function [
	| writeStream |

	writeStream := (String new: self totalArguments * 10) writeStream.
	1 to: self totalArguments do: [:i |
		writeStream nextPutAll: (self argumentAt: i)].
	^ writeStream contents.
]
