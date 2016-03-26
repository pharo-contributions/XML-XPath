Class {
	#name : #XPathReadStreamAdapterTest,
	#superclass : #TestCase,
	#category : #'XPath-Tests'
}

{ #category : #accessing }
XPathReadStreamAdapterTest >> badQualifiedName [
	^ 'prefix: localName'
]

{ #category : #accessing }
XPathReadStreamAdapterTest >> ncName [
	^ 'localName'
]

{ #category : #'instance creation' }
XPathReadStreamAdapterTest >> newStreamAdapterOn: aStream [
	^ self streamAdapterClass on: aStream
]

{ #category : #'instance creation' }
XPathReadStreamAdapterTest >> newStreamAdapterOnBadQualifiedName [
	^ self streamAdapterClass on: self badQualifiedName readStream
]

{ #category : #'instance creation' }
XPathReadStreamAdapterTest >> newStreamAdapterOnNCName [
	^ self streamAdapterClass on: self ncName readStream
]

{ #category : #'instance creation' }
XPathReadStreamAdapterTest >> newStreamAdapterOnQualifiedName [
	^ self streamAdapterClass on: self qualifiedName readStream
]

{ #category : #accessing }
XPathReadStreamAdapterTest >> prefix [
	^ 'prefix'
]

{ #category : #accessing }
XPathReadStreamAdapterTest >> qualifiedName [
	^ 'prefix:localName'
]

{ #category : #accessing }
XPathReadStreamAdapterTest >> streamAdapterClass [
	^ XPathReadStreamAdapter
]

{ #category : #tests }
XPathReadStreamAdapterTest >> testNext [
	| adapter |

	adapter := self newStreamAdapterOnQualifiedName.
	self qualifiedName do: [:each |
		self assert: adapter next == each].
	self assert: adapter next isNil.
]

{ #category : #tests }
XPathReadStreamAdapterTest >> testNextNCName [
	| adapter |

	adapter := self newStreamAdapterOnNCName.
	self
		assert: adapter nextNCName = self ncName;
		assert: adapter nextNCName isNil;
		assert: adapter atEnd.

	adapter := self newStreamAdapterOnQualifiedName.
	self
		assert: adapter nextNCName = self prefix;
		assert: adapter nextNCName isNil;
		assert: adapter next == $:.

	adapter := self newStreamAdapterOnBadQualifiedName.
	self
		assert: adapter nextNCName = self prefix;
		assert: adapter nextNCName isNil;
		assert: adapter next == $:.
]

{ #category : #tests }
XPathReadStreamAdapterTest >> testNextName [
	| adapter namePosition |

	adapter := self newStreamAdapterOnNCName.
	self
		assert: adapter nextName = self ncName;
		assert: adapter nextName isNil;
		assert: adapter atEnd.

	adapter := self newStreamAdapterOnQualifiedName.
	self
		assert: adapter nextName = self qualifiedName;
		assert: adapter nextName isNil;
		assert: adapter atEnd.

	adapter := self newStreamAdapterOnBadQualifiedName.
	namePosition := adapter position.
	self
		assert: adapter nextName isNil;
		assert: adapter position = namePosition.
]

{ #category : #tests }
XPathReadStreamAdapterTest >> testNextPushedBackToken [
	| adapter ncNamePosition ncName |

	adapter := self newStreamAdapterOnNCName.
	self assert: adapter nextPushedBackToken isNil.

	ncNamePosition := adapter position.
	ncName := adapter nextNCName.
	2 timesRepeat: [| token |
		adapter
			pushBackNCName: ncName
			position: ncNamePosition.
		token := adapter nextPushedBackToken.
		self
			deny: token isNil;
			assert: token value = ncName;
			assert: adapter nextPushedBackToken isNil;
			assert: adapter atEnd.

		adapter
			pushBackNCName: ncName
			position: ncNamePosition.
		"if the current position doesn't match the pushed back token position,
		then it should return nil"
		adapter next.
		self assert: adapter nextPushedBackToken isNil].
]

{ #category : #tests }
XPathReadStreamAdapterTest >> testPeek [
	| adapter |

	adapter := self newStreamAdapterOnQualifiedName.
	self qualifiedName do: [:each |
		self assert: adapter peek == each.
		adapter next].
	self assert: adapter peek isNil.
]

{ #category : #tests }
XPathReadStreamAdapterTest >> testPeekPushedBackToken [
	| adapter ncNamePosition ncName |

	adapter := self newStreamAdapterOnNCName.
	self assert: adapter peekPushedBackToken isNil.

	ncNamePosition := adapter position.
	ncName := adapter nextNCName.
	2 timesRepeat: [
		adapter
			pushBackNCName: ncName
			position: ncNamePosition.
		self
			assert: adapter peekPushedBackToken notNil;
			assert: adapter peekPushedBackToken value = ncName;
			assert: adapter peekPushedBackToken position = ncNamePosition.
	
		"if the current position doesn't match the pushed back token position,
		then it should return nil"
		adapter next.
		self assert: adapter peekPushedBackToken isNil].
]

{ #category : #tests }
XPathReadStreamAdapterTest >> testPushBackNCNamePosition [
	| adapter ncNamePosition ncName |

	adapter := self newStreamAdapterOnNCName.
	ncNamePosition := adapter position.
	ncName := adapter nextNCName.
	self assert:
		(adapter
			pushBackNCName: ncName
			position: ncNamePosition) == adapter.
	self
		assert: adapter position = ncNamePosition;
		assert: adapter nextNCName = ncName;
		assert: adapter atEnd.
]

{ #category : #tests }
XPathReadStreamAdapterTest >> testStreamReadingPortability [
	| stream adapter |

	stream := XMLExceptionRaisingReadStream on: self qualifiedName.
	adapter := self newStreamAdapterOn: stream.
	self qualifiedName do: [:each |
		self
			deny: adapter atEnd;
			assert: adapter peek = each;
			assert: adapter next = each].
	self assert: adapter atEnd.
	self
		shouldnt: [
			adapter
				peek;
				next]
		raise: Error.
	self
		assert: adapter peek isNil;
		assert: adapter next isNil.

	self assert: stream atEnd.
	self should: [stream peek] raise: Error.
	self should: [stream next] raise: Error.
]
