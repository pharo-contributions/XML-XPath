"
XPath id() function to select elements from the document of the context node by ID.
"
Class {
	#name : #XPathIDFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathIDFunction class >> prototypeSource [
	^ 'node-set id(object)'
]

{ #category : #invoking }
XPathIDFunction >> function [
	| object ids document nodeSet |

	object := self firstArgument.
	ids := Set new.
	object class == self nodeSetClass
		ifTrue: [
			object do: [:each |
				self
					splitSpaceSeparatedIDs: each stringValue
					into: ids]]
		ifFalse: [
			self
				splitSpaceSeparatedIDs: object asXPathString
				into: ids].

	nodeSet := self newNodeSet.
	(ids notEmpty
		and: [self contextNode notNil
			and: [(document := self contextNode document) notNil]])
		ifTrue: [| element |
			ids do: [:each |
				((element := document findElementWithID: each) notNil
					and: [(nodeSet includes: element) not])
					ifTrue: [nodeSet addLast: element]]].
	^ nodeSet.
]

{ #category : #private }
XPathIDFunction >> splitSpaceSeparatedIDs: anIDString into: anIDSet [
	| startIndex|

	1 to: anIDString size do: [:i | | nextChar |
		(nextChar := anIDString at: i) isXMLSeparator
			ifTrue: [
				startIndex
					ifNotNil: [
						anIDSet add: (anIDString copyFrom: startIndex to: i - 1).
						startIndex := nil]]
			ifFalse: [
				startIndex
					ifNil: [startIndex := i]]].
	startIndex
		ifNotNil: [
			anIDSet add:
				(anIDString copyFrom: startIndex to: anIDString size)].
]
