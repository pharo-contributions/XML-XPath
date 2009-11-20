"
I represent an instance of an XPath, which can be applied to XML documents (or SAX event streams, and a few other things) to generate a list of nodes matching the query or path that I represent.

My instance creation methods accept a string (or stream) and compile the string representation of an XPath query into a sequence of selectors.  These selectors are messages for an XPathContext that when sent to an instance of an XPathContext will execute the path on the document specified by that context.


"
Class {
	#name : #XPath,
	#superclass : #Object,
	#instVars : [
		'instructions',
		'literals',
		'path',
		'source',
		'block'
	],
	#category : #'XPath-XPath'
}

{ #category : #'instance creation' }
XPath class >> for: xpath [ 
	"Return a new XPath instance that has the xpath string representation. I parse the xpath 
	string to build an instance."
	| path |
	path := self new.
	path path: xpath.
	^ path

]

{ #category : #'instance creation' }
XPath class >> new [
	^super new initialize
]

{ #category : #'instance creation' }
XPath class >> on: aStream [
	"Parse the XPath on aStream and return an instance of XPath containing the compiled result"
	^ (XPathParser on: aStream) 
		parse;
		path.
		
]

{ #category : #accessing }
XPath >> block [
	block
		ifNil: [block := self compile].
	^ block
]

{ #category : #accessing }
XPath >> block: aBlock [
	block := aBlock
]

{ #category : #'as yet unclassified' }
XPath >> compile [
	| methodNode |
	methodNode := Parser new
				parse: self source readStream
				class: XPathContext
				noPattern: true
				context: nil
				notifying: nil
				ifFail: [].
	^ methodNode generate: #(0 0 0 0 )
]

{ #category : #'as yet unclassified' }
XPath >> in: root [ 
	"Search the specified document / root for nodes matching this xpath"
	| context |
	root isTag
		ifTrue: [context := XPathContext for: self in: root]
		ifFalse: [context := XPathContext
						for: self
						in: (root elements at: 1)].
	^ self block valueWithReceiver: context arguments: #().

]

{ #category : #initialization }
XPath >> initialize [
	instructions _ OrderedCollection new.
	literals _ OrderedCollection new.
	^self
]

{ #category : #accessing }
XPath >> path [
	^ path
]

{ #category : #accessing }
XPath >> path: string [
	path := string.
	source := nil.
	block := nil.
]

{ #category : #accessing }
XPath >> source [
	source
		ifNil: [ source := (XPathParser on: path readStream) parse].
	^ source
]
