Class {
	#name : #XPathContext,
	#superclass : #Object,
	#instVars : [
		'root',
		'path',
		'parameters',
		'locals',
		'stack',
		'marker',
		'pc',
		'results',
		'done'
	],
	#category : 'XPath-XPath'
}

{ #category : #'instance creation' }
XPathContext class >> for: aPath in: aDocument [
	| context |
	context := self new.
	context path: aPath;
			root: aDocument.
	^context
]

{ #category : #'as yet unclassified' }
XPathContext class >> new [
	^super new initialize.
]

{ #category : #instructions }
XPathContext >> at: nameIndex [ 
	| name values attribute |
	name := path literalAt: nameIndex.
	values := OrderedCollection new.
	name = '*'
		ifTrue: [self pop
				do: [:attributes | values addAll: attributes values]]
		ifFalse: [self pop
				do: [:attributes | 
					attributes at: name ifPresent: [:value | attribute := value. values add: attribute].
					]].
	self push: values
]

{ #category : #instructions }
XPathContext >> attribute: name [
	"Look up an attribute"
	| allAttributes values attribute |
	allAttributes := OrderedCollection new.
	self pop do:
		[:element | allAttributes add: element attributes].
	values := OrderedCollection new.
	name = '*'
		ifTrue: [allAttributes
				do: [:attributes | values addAll: attributes values]]
		ifFalse: [allAttributes
				do: [:attributes | 
					attributes at: name ifPresent: [:value | attribute := value. values add: attribute].
					]].
	self push: values
]

{ #category : #instructions }
XPathContext >> attributes [
	"Push the attributes"
	| allAttributes |
	"Processor activeProcess debugWithTitle: 'Trying out the attributes stuff'."
	allAttributes := OrderedCollection new.
	self pop do:
		[:element | allAttributes add: element attributes].
		"[:element | element attributes associationsDo: [:assoc | allAttributes add: assoc]]. "
	self push: allAttributes.
]

{ #category : #instructions }
XPathContext >> both: arg1 and: arg2 [
	^ self
]

{ #category : #functions }
XPathContext >> count [
	self
		push: (Array with: self pop size)
]

{ #category : #instructions }
XPathContext >> descendants [
	"Gather all of the descendant nodes"
	"Processor activeProcess debugWithTitle: 'Checking descendants code'."
	| parents children allDescendants |
	parents := OrderedCollection withAll: self pop.
	"allDescendants := OrderedCollection new."
	allDescendants := OrderedCollection withAll: parents.
	children := OrderedCollection new.
	[parents isEmpty]
		whileFalse: [parents
				do: [:parent | parent isTag
						ifTrue: [children addAll: parent elements]].
			allDescendants addAll: children.
			parents := children.
			children := OrderedCollection new].
	self push: allDescendants
]

{ #category : #instructions }
XPathContext >> either: arg1 or: arg2 [
]

{ #category : #instructions }
XPathContext >> element: name [
	| children matches |
	children := OrderedCollection new.
	self pop
		do: [:element | "[:element | children addAll: element elements]."
			element isTag
				ifTrue: [children
						addAll: (element elements
								select: [:element2 | element2 isTag])]].
	matches := (children select:
		[:element | (element name = name) or: [name = '*']]).
	self push: matches.
]

{ #category : #instructions }
XPathContext >> elements [
	| children |
	children := OrderedCollection new.
	self pop
		do: [:element | "[:element | children addAll: element elements]."
			element isTag
				ifTrue: [children
						addAll: (element elements
								select: [:element2 | element2 isTag])]].
	self push: children
]

{ #category : #instructions }
XPathContext >> finish [
	done := true.
	results := self pop.
	
]

{ #category : #initialization }
XPathContext >> initialize [
	locals := OrderedCollection new.
	done := false.
	stack := OrderedCollection new.
	pc := 1. "Start at the beginning"
	^self
]

{ #category : #functions }
XPathContext >> last [
	self
		push: (self pop
				collect: [:element | element elements last])
]

{ #category : #'as yet unclassified' }
XPathContext >> mark [
	stack push: pc.
	marker := stack size.
	
]

{ #category : #instructions }
XPathContext >> name: nameIndex [
	| name matches |
	"Processor activeProcess debugWithTitle: 'A problem with names'."
	name := path literalAt: nameIndex.
	matches := (self pop select:
		[:element | (element name = name) or: [name = '*']]).
		"[:element | (element tag type = name) or: [name = '*']])."
	self push: matches.
]

{ #category : #instructions }
XPathContext >> parent [
	self push: (self pop collect:
		[:element | element parent]).
]

{ #category : #accessing }
XPathContext >> path [
	^path
]

{ #category : #accessing }
XPathContext >> path: aPath [
	path := aPath
]

{ #category : #instructions }
XPathContext >> pop [
	^ stack removeLast.
]

{ #category : #functions }
XPathContext >> position [
	| positions |
	positions := OrderedCollection new.
	self pop do:
		[:element | positions add: (element parent indexOf: element)].
	self push: positions.
]

{ #category : #instructions }
XPathContext >> push: anObject [
	stack addLast: anObject.
]

{ #category : #instructions }
XPathContext >> query [
	| instruction |
	"Must start with an initial collection of nodes; size = 1"
	"Also, need to skip the document node and start with the root node"
	"self push: (OrderedCollection withAll: root elements)."
	self push: (OrderedCollection with: root).
	self results ifNil: 
		[
			[done] whileFalse:
				[
					| nextPC |
					nextPC := pc + 1.
					instruction := path instructionAt: pc.
					pc := nextPC.
					instruction sentTo: self.
				].
		].
	^self results
]

{ #category : #accessing }
XPathContext >> results [
	^results
]

{ #category : #'as yet unclassified' }
XPathContext >> revert [
	[stack size > marker]
		whileTrue: [stack pop].
	pc := stack pop.
]

{ #category : #accessing }
XPathContext >> root [
	^root
]

{ #category : #accessing }
XPathContext >> root: rootNode [
	root := rootNode
]

{ #category : #functions }
XPathContext >> text [
	"Return element content"
	| allText |
	allText := OrderedCollection new.
	self pop collect: [:element | allText addAll: element contents].
	self push: allText.
]
