"
Abstract class for node sort orders to keep track of the order of nodes in a node set. Instances of subclasses are immutable and shared.
"
Class {
	#name : #XPathSortOrder,
	#superclass : #Object,
	#classInstVars : [
		'instance'
	],
	#category : #'XPath-Core-DOM'
}

{ #category : #'instance creation' }
XPathSortOrder class >> new [
	"these classes are immutable and shared, so they are only initialized once"
	^ instance ifNil: [instance := self basicNew initialize]
]

{ #category : #enumerating }
XPathSortOrder >> ancestorAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	aNodeSet size >= 1
		ifTrue: [| copy |
			copy := (aNodeSet at: 1) %% aStringOrBlockOrNodeTestWithFilters.
			2 to: aNodeSet size do: [:i |
				copy addAllIfNotPresent:
					(aNodeSet at: i) %% aStringOrBlockOrNodeTestWithFilters].
			^ copy]
		ifFalse: [^ aNodeSet copyEmpty]
]

{ #category : #enumerating }
XPathSortOrder >> ancestorOrSelfAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	aNodeSet size >= 1
		ifTrue: [| copy |
			copy := (aNodeSet at: 1) %%~ aStringOrBlockOrNodeTestWithFilters.
			2 to: aNodeSet size do: [:i |
				copy addAllIfNotPresent:
					(aNodeSet at: i) %%~ aStringOrBlockOrNodeTestWithFilters].
			^ copy]
		ifFalse: [^ aNodeSet copyEmpty]
]

{ #category : #enumerating }
XPathSortOrder >> attributeAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	aNodeSet size >= 1
		ifTrue: [| copy |
			copy := (aNodeSet at: 1) @ aStringOrBlockOrNodeTestWithFilters.
			2 to: aNodeSet size do: [:i |
				copy addAll: (aNodeSet at: i) @ aStringOrBlockOrNodeTestWithFilters].
			^ copy]
		ifFalse: [^ aNodeSet copyEmpty]
]

{ #category : #enumerating }
XPathSortOrder >> childAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	aNodeSet size >= 1
		ifTrue: [| copy |
			copy := (aNodeSet at: 1) / aStringOrBlockOrNodeTestWithFilters.
			2 to: aNodeSet size do: [:i |
				copy addAll: (aNodeSet at: i) / aStringOrBlockOrNodeTestWithFilters].
			^ copy]
		ifFalse: [^ aNodeSet copyEmpty]
]

{ #category : #enumerating }
XPathSortOrder >> descendantAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	aNodeSet size >= 1
		ifTrue: [| copy |
			copy := (aNodeSet at: 1) // aStringOrBlockOrNodeTestWithFilters.
			2 to: aNodeSet size do: [:i |
				copy addAllIfNotPresent:
					(aNodeSet at: i) // aStringOrBlockOrNodeTestWithFilters].
			^ copy]
		ifFalse: [^ aNodeSet copyEmpty]
]

{ #category : #enumerating }
XPathSortOrder >> descendantOrSelfAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	aNodeSet size >= 1
		ifTrue: [| copy |
			copy := (aNodeSet at: 1) //~ aStringOrBlockOrNodeTestWithFilters.
			2 to: aNodeSet size do: [:i |
				copy addAllIfNotPresent:
					(aNodeSet at: i) //~ aStringOrBlockOrNodeTestWithFilters].
			^ copy]
		ifFalse: [^ aNodeSet copyEmpty]
]

{ #category : #sorting }
XPathSortOrder >> documentOrderSort: aNodeSet [
	self subclassResponsibility
]

{ #category : #accessing }
XPathSortOrder >> firstInDocumentOrderFrom: aNodeSet [
	self subclassResponsibility
]

{ #category : #enumerating }
XPathSortOrder >> followingAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	aNodeSet size >= 1
		ifTrue: [| copy |
			copy := (aNodeSet at: 1) >> aStringOrBlockOrNodeTestWithFilters.
			2 to: aNodeSet size do: [:i |
				copy addAllIfNotPresent:
					(aNodeSet at: i) >> aStringOrBlockOrNodeTestWithFilters].
			^ copy]
		ifFalse: [^ aNodeSet copyEmpty]
]

{ #category : #enumerating }
XPathSortOrder >> followingSiblingAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	aNodeSet size >= 1
		ifTrue: [| copy |
			copy := (aNodeSet at: 1) >>> aStringOrBlockOrNodeTestWithFilters.
			2 to: aNodeSet size do: [:i |
				copy addAllIfNotPresent:
					(aNodeSet at: i) >>> aStringOrBlockOrNodeTestWithFilters].
			^ copy]
		ifFalse: [^ aNodeSet copyEmpty]
]

{ #category : #enumerating }
XPathSortOrder >> namespaceAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	aNodeSet size >= 1
		ifTrue: [| copy |
			copy := (aNodeSet at: 1) @@ aStringOrBlockOrNodeTestWithFilters.
			2 to: aNodeSet size do: [:i |
				copy addAll: (aNodeSet at: i) @@ aStringOrBlockOrNodeTestWithFilters].
			^ copy]
		ifFalse: [^ aNodeSet copyEmpty]
]

{ #category : #enumerating }
XPathSortOrder >> parentAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	aNodeSet size >= 1
		ifTrue: [| copy nodeTestBlock |
			copy := aNodeSet copyEmpty.
			nodeTestBlock := aStringOrBlockOrNodeTestWithFilters asNodeTestBlock.
			aNodeSet do: [:each | | parent |
				((parent := each parent) notNil
					and: [(nodeTestBlock value: each parent)
						and: [(copy includes: each parent) not]])
					ifTrue: [copy addLast: parent]].
			^ copy filterEachInSeparateContextWithAll:
				aStringOrBlockOrNodeTestWithFilters asNodeSetFilters]
		ifFalse: [^ aNodeSet copyEmpty]
]

{ #category : #enumerating }
XPathSortOrder >> precedingAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	aNodeSet size >= 1
		ifTrue: [| copy |
			copy := (aNodeSet at: 1) << aStringOrBlockOrNodeTestWithFilters.
			2 to: aNodeSet size do: [:i |
				copy addAllIfNotPresent:
					(aNodeSet at: i) << aStringOrBlockOrNodeTestWithFilters].
			^ copy]
		ifFalse: [^ aNodeSet copyEmpty]
]

{ #category : #enumerating }
XPathSortOrder >> precedingSiblingAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	aNodeSet size >= 1
		ifTrue: [| copy |
			copy := (aNodeSet at: 1) <<< aStringOrBlockOrNodeTestWithFilters.
			2 to: aNodeSet size do: [:i |
				copy addAllIfNotPresent:
					(aNodeSet at: i) <<< aStringOrBlockOrNodeTestWithFilters].
			^ copy]
		ifFalse: [^ aNodeSet copyEmpty]
]

{ #category : #enumerating }
XPathSortOrder >> selfAxisOn: aNodeSet select: aStringOrBlockOrNodeTestWithFilters [
	aNodeSet size >= 1
		ifTrue: [
			^ (aNodeSet select: aStringOrBlockOrNodeTestWithFilters asNodeTestBlock)
				filterEachInSeparateContextWithAll:
					aStringOrBlockOrNodeTestWithFilters asNodeSetFilters]
		ifFalse: [^ aNodeSet copyEmpty]
]
