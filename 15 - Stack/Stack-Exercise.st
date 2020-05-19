!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:48'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'sentenceFinderByPref sentenceOne sentenceTwo sentenceThree expectedSentences prefixForOne prefixForTwo prefixForThree prefixForOneCaseSens sentenceNotAlphaNumeric prefixForNotAlpha'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'SC 5/18/2020 18:23:26'!
test01SentenceFinderAgregaUnaOracion

	sentenceFinderByPref addSentence: sentenceOne.
	
	self assert: sentenceFinderByPref numberOfSentences = 1.
	self assert: sentenceFinderByPref lastSentence = sentenceOne.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'SC 5/18/2020 18:12:26'!
test02SentenceFinderAgregaDosOraciones

	sentenceFinderByPref addSentence: sentenceOne.
	sentenceFinderByPref addSentence: sentenceTwo.
	
	self assert: sentenceFinderByPref numberOfSentences = 2.
	self assert: sentenceFinderByPref lastSentence = sentenceTwo.

	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'SC 5/18/2020 18:30:43'!
test03FindEncuentraUnaOracion

	sentenceFinderByPref addSentence: sentenceTwo.
	
	expectedSentences add: sentenceTwo .
	
	self assert: (sentenceFinderByPref find: prefixForTwo ) = expectedSentences.

	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'SC 5/18/2020 18:30:54'!
test04FindNoEncuentraUnaOracion

	sentenceFinderByPref addSentence: sentenceTwo.
		
	self assert: (sentenceFinderByPref find: prefixForOne ) = expectedSentences.
	

	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'SC 5/18/2020 18:31:49'!
test05FindEncuentraYNoCambiaElStack

	sentenceFinderByPref addSentence: sentenceTwo.
	
	expectedSentences add: sentenceTwo .
	
	self assert: sentenceFinderByPref numberOfSentences = 1.
	self assert: (sentenceFinderByPref find: prefixForTwo ) = expectedSentences.
	
	self assert: sentenceFinderByPref numberOfSentences = 1.
	self assert: (sentenceFinderByPref find: prefixForTwo) = expectedSentences.
	

	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'SC 5/18/2020 18:32:17'!
test06FindNoEncuentraYNoCambiaElStack

	sentenceFinderByPref addSentence: sentenceTwo.
	
	self assert: sentenceFinderByPref numberOfSentences = 1.
	self assert: (sentenceFinderByPref find: prefixForOne) = expectedSentences.

	expectedSentences add: sentenceTwo.
	
	self assert: sentenceFinderByPref numberOfSentences = 1.
	self assert: (sentenceFinderByPref find: prefixForTwo ) = expectedSentences.
	

	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'SC 5/18/2020 18:34:03'!
test07FindEsCaseSensitive

	sentenceFinderByPref addSentence: sentenceOne.
	
	self assert: (sentenceFinderByPref find: prefixForOneCaseSens) = expectedSentences.

	expectedSentences add: sentenceOne.
	
	self assert: (sentenceFinderByPref find: prefixForOne) = expectedSentences.
	

	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'SC 5/18/2020 21:01:35'!
test08ElPrefijoNoPuedeSerVacio

	self 
		should: [sentenceFinderByPref find: '']
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix notValidPrefixMessage].
		

	
	

	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'SC 5/18/2020 19:20:45'!
test09ElPrefijoNoPuedeContenerEspacios

	self 
		should: [sentenceFinderByPref find: 'Tengo dos espacios']
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix notValidPrefixMessage].
		

	
	

	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'SC 5/18/2020 21:02:23'!
test10ElPrefijoNoPuedeSerVacioAunqueHayaOraciones

	sentenceFinderByPref addSentence: sentenceThree.

	self 
		should: [sentenceFinderByPref find: '']
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix notValidPrefixMessage].
		

	
	

	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'SC 5/18/2020 21:03:08'!
test11ElPrefijoNoPuedeContenerEspaciosAunqueHayaOraciones

	sentenceFinderByPref addSentence: sentenceThree.

	self 
		should: [sentenceFinderByPref find: 'Tengo dos espacios']
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix notValidPrefixMessage].
		

	
	

	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'SC 5/18/2020 21:07:31'!
test12FindFuncionaSinAlfanumericos

	sentenceFinderByPref addSentence: sentenceNotAlphaNumeric.
	sentenceFinderByPref addSentence: sentenceOne.
	
	expectedSentences add: sentenceNotAlphaNumeric .
	
	self assert: (sentenceFinderByPref find: prefixForNotAlpha ) = expectedSentences.
	

	! !


!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'SC 5/18/2020 21:06:07'!
setUp

	sentenceFinderByPref := SentenceFinderByPrefix new.
	expectedSentences := OrderedCollection new.
	sentenceOne := 'Tres tristes tigres...'.
	sentenceTwo := 'Pablito clavo un clavito...'.
	sentenceThree := 'cu4nd0 cu3ntes cu3ntos...'.
	sentenceNotAlphaNumeric := '{}:;,.;'.
	prefixForOne := 'Tres'.
	prefixForTwo := 'Pabli'.
	prefixForThree := 'cu4n'.
	prefixForOneCaseSens := 'TRES'.
	prefixForNotAlpha := '{}:;'.
	
	
	

	! !


!classDefinition: #Node category: #'Stack-Exercise'!
Object subclass: #Node
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #NullNode category: #'Stack-Exercise'!
Node subclass: #NullNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NullNode methodsFor: 'as yet unclassified' stamp: 'SC 5/18/2020 17:27:33'!
isEmpty

	^true! !

!NullNode methodsFor: 'as yet unclassified' stamp: 'SC 5/18/2020 17:36:32'!
next: anElem

	| newNode |
	
	newNode := RealNode new.
	
	newNode initializeWith: anElem nextOf: self withNumber: 1.
	
	^newNode ! !

!NullNode methodsFor: 'as yet unclassified' stamp: 'SC 5/18/2020 17:36:37'!
prev

	^self error: OOStack stackEmptyErrorDescription ! !

!NullNode methodsFor: 'as yet unclassified' stamp: 'SC 5/18/2020 17:27:41'!
size

	^0! !

!NullNode methodsFor: 'as yet unclassified' stamp: 'SC 5/18/2020 17:28:27'!
top

	^self error: OOStack stackEmptyErrorDescription ! !

!NullNode methodsFor: 'as yet unclassified' stamp: 'SC 5/18/2020 21:09:23'!
value

	^self error: OOStack stackEmptyErrorDescription ! !


!classDefinition: #RealNode category: #'Stack-Exercise'!
Node subclass: #RealNode
	instanceVariableNames: 'prev elem number'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!RealNode methodsFor: 'as yet unclassified' stamp: 'SC 5/18/2020 17:24:59'!
initializeWith: anElem nextOf: aNode withNumber: aNumber

	elem := anElem.
	prev := aNode.
	number := aNumber.! !

!RealNode methodsFor: 'as yet unclassified' stamp: 'SC 5/18/2020 17:22:50'!
isEmpty

	^false.! !

!RealNode methodsFor: 'as yet unclassified' stamp: 'SC 5/18/2020 17:36:26'!
next: anElem

	| newNode |
	
	newNode := RealNode new.
	
	newNode initializeWith: anElem nextOf: self withNumber: self size + 1.
	
	^newNode ! !

!RealNode methodsFor: 'as yet unclassified' stamp: 'SC 5/18/2020 17:36:48'!
prev

	^prev! !

!RealNode methodsFor: 'as yet unclassified' stamp: 'SC 5/18/2020 17:25:19'!
size

	^number.! !

!RealNode methodsFor: 'as yet unclassified' stamp: 'SC 5/18/2020 21:09:06'!
value

	^elem! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialize' stamp: 'SC 5/18/2020 17:30:22'!
initialize

	elements := NullNode new.! !


!OOStack methodsFor: 'testing' stamp: 'SC 5/18/2020 17:09:57'!
isEmpty

	^elements isEmpty! !


!OOStack methodsFor: 'operations' stamp: 'SC 5/18/2020 21:08:44'!
pop

	| currentTop |
	
	currentTop := elements value.
	
	elements _ elements prev.
	
	^currentTop.! !

!OOStack methodsFor: 'operations' stamp: 'SC 5/18/2020 17:36:20'!
push: anElement

	elements _ elements next: anElement ! !

!OOStack methodsFor: 'operations' stamp: 'SC 5/18/2020 17:11:03'!
size

	^elements size! !

!OOStack methodsFor: 'operations' stamp: 'SC 5/18/2020 21:08:52'!
top

	^elements value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'sentencesStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'SC 5/18/2020 17:46:06'!
addSentence: aSentence

	sentencesStack push: aSentence.! !

!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'SC 5/18/2020 19:15:58'!
find: aPrefix

	| stackForCopy listOfSentences |
	
	(aPrefix = '' | ((aPrefix findString: ' ') = 0) not)
		ifTrue: [^self error: self class notValidPrefixMessage].
	
	listOfSentences := OrderedCollection new.
	stackForCopy := OOStack new.

	[sentencesStack isEmpty]
		whileFalse: [ | nextSentence |
				nextSentence := sentencesStack pop.
				(nextSentence beginsWith: aPrefix)
					ifTrue: [listOfSentences add: nextSentence].
				stackForCopy push: nextSentence.].
	
	[stackForCopy isEmpty] 
		whileFalse: [ | nextSentence |
				nextSentence := stackForCopy pop.
				sentencesStack push: nextSentence.].
			
	^listOfSentences! !


!SentenceFinderByPrefix methodsFor: 'initialize' stamp: 'SC 5/18/2020 17:45:16'!
initialize

	sentencesStack := OOStack new.! !


!SentenceFinderByPrefix methodsFor: 'accessing' stamp: 'SC 5/18/2020 17:50:37'!
lastSentence

	^sentencesStack top ! !

!SentenceFinderByPrefix methodsFor: 'accessing' stamp: 'SC 5/18/2020 17:46:14'!
numberOfSentences

	^sentencesStack size.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'SC 5/18/2020 18:35:09'!
notValidPrefixMessage

	^'El prefijo no puede ser vacio ni tener espacios'! !
