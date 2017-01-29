Extension { #name : #Float }

{ #category : #'*XPath-Core-accessing' }
Float class >> xPathNegativeInfinity [
	"older Pharo/Squeak images don't have #negativeInfinity, so this is used instead"
	^ self infinity negated
]

{ #category : #'*XPath-Core-accessing' }
Float class >> xPathNegativeZero [
	"Pharo3's OpalCompiler doens't correctly compile methods with -0.0 literals"
	^ 0.0 negated
]
