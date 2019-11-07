"
Unit tests for XPathReadStreamAdapter
"
Class {
	#name : #XPathReadStreamAdapterTest,
	#superclass : #XMLReadStreamAdapterTest,
	#category : #'XPath-Tests'
}

{ #category : #accessing }
XPathReadStreamAdapterTest >> badQualifiedName [
	^ 'prefix: localName'
]

{ #category : #accessing }
XPathReadStreamAdapterTest >> inputCollection [
	^ self qualifiedName
]

{ #category : #accessing }
XPathReadStreamAdapterTest >> ncName [
	^ 'localName'
]

{ #category : #'instance creation' }
XPathReadStreamAdapterTest >> newStreamAdapterOnBadQualifiedName [
	^ self streamAdapterClass on:
		(self newStreamOn: self badQualifiedName)
]

{ #category : #'instance creation' }
XPathReadStreamAdapterTest >> newStreamAdapterOnNCName [
	^ self streamAdapterClass on:
		(self newStreamOn: self ncName)
]

{ #category : #'instance creation' }
XPathReadStreamAdapterTest >> newStreamAdapterOnQualifiedName [
	^ self streamAdapterClass on:
		(self newStreamOn: self qualifiedName)
]

{ #category : #accessing }
XPathReadStreamAdapterTest >> outputCollection [
	^ self qualifiedName
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
XPathReadStreamAdapterTest >> testNextNCName [
	| adapter badNamePosition |

	adapter := self newStreamAdapterOnNCName.
	self
		assert: adapter nextNCName equals: self ncName;
		assert: adapter nextNCName isNil;
		assert: adapter atEnd.

	adapter := self newStreamAdapterOnQualifiedName.
	self
		assert: adapter nextNCName equals: self prefix;
		assert: adapter nextNCName isNil;
		assert: adapter next == $:;
		assert: adapter nextNCName equals: self ncName;
		assert: adapter atEnd.

	adapter := self newStreamAdapterOnBadQualifiedName.
	self
		assert: adapter nextNCName equals: self prefix;
		assert: adapter nextNCName isNil;
		assert: adapter next == $:.
	badNamePosition := adapter position.
	self
		assert: adapter nextNCName isNil;
		assert: adapter position equals: badNamePosition
]

{ #category : #tests }
XPathReadStreamAdapterTest >> testNextName [
	| adapter badNamePosition |

	adapter := self newStreamAdapterOnNCName.
	self
		assert: adapter nextName equals: self ncName;
		assert: adapter nextName isNil;
		assert: adapter atEnd.

	adapter := self newStreamAdapterOnQualifiedName.
	self
		assert: adapter nextName equals: self qualifiedName;
		assert: adapter nextName isNil;
		assert: adapter atEnd.

	adapter := self newStreamAdapterOnBadQualifiedName.
	badNamePosition := adapter position.
	self
		assert: adapter nextName isNil;
		assert: adapter position equals: badNamePosition
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
			assert: token value equals: ncName;
			assert: adapter nextPushedBackToken isNil;
			assert: adapter atEnd.

		adapter
			pushBackNCName: ncName
			position: ncNamePosition.
		"if the current position doesn't match the pushed back token position,
		then it should return nil"
		adapter next.
		self assert: adapter nextPushedBackToken isNil]
]

{ #category : #tests }
XPathReadStreamAdapterTest >> testPeekForNCName [
	| adapter badNamePosition |

	adapter := self newStreamAdapterOnNCName.
	self
		assert: (adapter peekForNCName: self ncName);
		assert: adapter atEnd;
		deny: (adapter peekForNCName: self ncName);
		assert: adapter atEnd.

	adapter := self newStreamAdapterOnQualifiedName.
	self
		assert: (adapter peekForNCName: self prefix);
		assert: adapter next == $:.
	badNamePosition := adapter position.
	self
		deny: (adapter peekForNCName: self prefix);
		assert: adapter position equals: badNamePosition;
		assert: (adapter peekForNCName: self ncName);
		assert: adapter atEnd;
		deny: (adapter peekForNCName: self ncName);
		assert: adapter atEnd.

	adapter := self newStreamAdapterOnBadQualifiedName.
	self
		assert: (adapter peekForNCName: self prefix);
		assert: adapter next == $:.
	badNamePosition := adapter position.
	self
		deny: (adapter peekForNCName: self prefix);
		assert: adapter position equals: badNamePosition;
		deny: (adapter peekForNCName: self ncName);
		assert: adapter position equals: badNamePosition
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
			assert: adapter peekPushedBackToken value equals: ncName;
			assert: adapter peekPushedBackToken position equals: ncNamePosition.
	
		"if the current position doesn't match the pushed back token position,
		then it should return nil"
		adapter next.
		self assert: adapter peekPushedBackToken isNil]
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
		assert: adapter position equals: ncNamePosition;
		assert: adapter nextNCName equals: ncName;
		assert: adapter atEnd
]
