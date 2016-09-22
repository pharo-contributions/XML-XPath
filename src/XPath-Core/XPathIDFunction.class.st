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
XPathIDFunction >> addElementsFromDocument: aDocument withIDs: anIDSet to: aNodeSet [
	| doctypeDefinition |

	((doctypeDefinition := aDocument doctypeDefinition) notNil
		and: [doctypeDefinition hasValidators])
		ifTrue: [| elementsAndIDAttributes |
			doctypeDefinition hasElementIDs
				ifFalse: [^ self].
			elementsAndIDAttributes :=
				doctypeDefinition elementIDValidator elementsAndIDAttributes.
			aDocument allElementsDo: [:each |
				each hasAttributes
					ifTrue: [
						elementsAndIDAttributes
							at: each name
							ifPresent: [:idAttribute |
								((each includesAttribute: idAttribute)
									and: [anIDSet includes: (each attributeAt: idAttribute)])
									ifTrue: [aNodeSet add: each]]]]]
		ifFalse: [
			aDocument allElementsDo: [:each |
				(each hasAttributes
					and: [(each includesAttribute: 'xml:id')
						and: [anIDSet includes: (each attributeAt: 'xml:id')]])
					ifTrue: [aNodeSet add: each]]]
]

{ #category : #invoking }
XPathIDFunction >> function [
	| object ids document nodeSet |

	object := self pop.
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
		ifTrue: [
			self
				addElementsFromDocument: document
				withIDs: ids
				to: nodeSet].
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
