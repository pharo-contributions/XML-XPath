"
XPath node set sum function.
"
Class {
	#name : #XPathSumFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathSumFunction class >> functionPrototypeSource [
	^ 'number sum(node-set)'
]

{ #category : #invoking }
XPathSumFunction >> function [
	^ self pop
		inject: 0
		into: [:i :each | i + each stringValue asXPathNumber]
]
