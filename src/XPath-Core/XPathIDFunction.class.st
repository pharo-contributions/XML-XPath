"
XPath id() function to select elements from the document of the context node by ID.
"
Class {
	#name : #XPathIDFunction,
	#superclass : #XPathFunction,
	#category : #'XPath-Core-Functions'
}

{ #category : #accessing }
XPathIDFunction class >> functionPrototype [
	^ 'node-set id(object)'
]

{ #category : #private }
XPathIDFunction >> addElementsWithIDs: anIdSet from: aDocument to: aNodeSet [
	| doctypeDefinition elementsAndIdAttributes |

	((doctypeDefinition := aDocument doctypeDefinition) notNil
		and: [doctypeDefinition hasElementIDValidator])
		ifFalse: [^ self].
	elementsAndIdAttributes :=
		doctypeDefinition elementIDValidator elementsAndIDAttributes.

	aDocument allElementsDo: [:each |
		each hasAttributes
			ifTrue: [
				elementsAndIdAttributes
					at: each name
					ifPresent: [:idAttribute |
						((each includesAttribute: idAttribute)
							and: [anIdSet includes: (each attributeAt: idAttribute)])
							ifTrue: [aNodeSet add: each]]]].
]

{ #category : #invoking }
XPathIDFunction >> function [
	| object ids document nodeSet |

	object := self pop.
	ids := Set new.
	(object isKindOf: XPathNodeSet)
		ifTrue: [
			object do: [:each |
				self
					splitSpaceSeparatedIDs: each asXPathString
					into: ids]]
		ifFalse: [
			self
				splitSpaceSeparatedIDs: object asXPathString
				into: ids].

	nodeSet := XPathNodeSet new.
	(ids notEmpty
		and: [self contextNode notNil
			and: [(document := self contextNode document) notNil]])
		ifTrue: [
			self
				addElementsWithIDs: ids
				from: document
				to: nodeSet].
	^ nodeSet.
]

{ #category : #private }
XPathIDFunction >> splitSpaceSeparatedIDs: anIdString into: anIdSet [
	| startIndex|

	1 to: anIdString size do: [:i | | nextChar |
		(nextChar := anIdString at: i) isSeparator
			ifTrue: [
				startIndex
					ifNotNil: [
						anIdSet add: (anIdString copyFrom: startIndex to: i - 1).
						startIndex := nil]]
			ifFalse: [
				startIndex
					ifNil: [startIndex := i]]].
	startIndex
		ifNotNil: [anIdSet add: (anIdString copyFrom: startIndex to: anIdString size)].
]
