!classDefinition: #TerniLapilliTest category: #'TerniLapilli - Ejercicio'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: 'game tokenX1 tokenX2 tokenX3 tokenO1 tokenO2 tokenO3 tokenX4'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli - Ejercicio'!

!TerniLapilliTest methodsFor: 'test' stamp: 'SC 6/13/2020 20:44:36'!
setUp

	tokenX1 := TokenX new.
	tokenX2 := TokenX new.
	tokenX3 := TokenX new.
	tokenO1 := TokenO new.
	tokenO2 := TokenO new.
	tokenO3 := TokenO new.
	tokenX4 := TokenX new.! !

!TerniLapilliTest methodsFor: 'test' stamp: 'FE 6/11/2020 21:06:56'!
test01ElJugadorInicialEsX
	
	game := TerniLapilli new.
	
	self assert: game isPlayingX.! !

!TerniLapilliTest methodsFor: 'test' stamp: 'SC 6/13/2020 20:27:15'!
test02SiJugoElJugadorXElTurnoEsDelJugadorO

	game := TerniLapilli new.
	
	game put: tokenX1 at: 1@1.
	
	self assert: game isPlayingO.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'SC 6/13/2020 20:41:58'!
test03SiJugoElJugadorOElTurnoEsDelJugadorX

	game := TerniLapilli new.
	
	game put: tokenX1 at: 2@2.
	game put: tokenO1 at: 1@1.
	
	self assert: game isPlayingX.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'SC 6/13/2020 20:42:09'!
test04SiEsElTurnoDeXNoPuedeJugarO.

	game := TerniLapilli new.
	
	self
		should: [ game put: tokenO1 at: 1@1]
		raise: Error
		withMessageText: TerniLapilli incorrectTurnError.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'SC 6/13/2020 20:42:43'!
test05SiEsElTurnoDeONoPuedeJugarX.

	game := TerniLapilli new.
	
	game put: tokenX1 at: 1@1.
	
	self
		should: [ game put: tokenX2 at: 2@2]
		raise: Error
		withMessageText: TerniLapilli incorrectTurnError.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'SC 6/13/2020 20:43:17'!
test06NoSePuedePonerUnaFichaEnUnaPosicionOcupada

	game := TerniLapilli new.
	
	game put: tokenX1 at: 1@1.
	
	self
		should: [ game put: tokenO1 at: 1@1]
		raise: Error
		withMessageText: TerniLapilliBoard busyPositionError.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'SC 6/13/2020 20:44:25'!
test07NoSePuedenPonerMasDe6Fichas

	game := TerniLapilli new.
	
	game put: tokenX1 at: 1@1.
	game put: tokenO1 at: 1@2.
	game put: tokenX2 at: 1@3.
	game put: tokenO2 at: 2@1.
	game put: tokenX3 at: 2@2.
	game put: tokenO3 at: 2@3.
	
	self
		should: [ game put: tokenX4 at: 3@2]
		raise: Error
		withMessageText: TerniLapilliBoard tokensLimitError.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'SC 6/13/2020 20:44:53'!
test08LasFichasNoPuedenPonerseFueraDelTabler

	game := TerniLapilli new.
	
	self
		should: [ game put: tokenX1 at: 69@420]
		raise: Error
		withMessageText: TerniLapilliBoard boardLimitError.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'SC 6/13/2020 20:45:28'!
test09ElJuegoTerminaCon3EnLineaHorizontal

	game := TerniLapilli new.
	
	game put: tokenX1 at: 1@1.
	game put: tokenO1 at: 1@2.
	game put: tokenX2 at: 2@1.
	game put: tokenO2 at: 2@2.
	game put: tokenX3 at: 3@1.
	
	self assert: game isOver
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'SC 6/13/2020 20:49:36'!
test10ElJuegoTerminaCon3EnLineaVertical

	game := TerniLapilli new.
	
	game put: tokenX1 at: 1@1.
	game put: tokenO1 at: 2@3.
	game put: tokenX2 at: 1@2.
	game put: tokenO2 at: 3@3.
	game put: tokenX3 at: 1@3.
	
	self assert: game isOver
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'SC 6/13/2020 20:50:18'!
test11ElJuegoTerminaCon3EnLineaEnDiagonal

	game := TerniLapilli new.
	
	game put: tokenX1 at: 2@2.
	game put: tokenO1 at: 2@3.
	game put: tokenX2 at: 1@1.
	game put: tokenO2 at: 3@1.
	game put: tokenX3 at: 3@3.
	
	self assert: game isOver
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'SC 6/13/2020 21:05:38'!
test12NoSePuedePonerUnaFichaSiTerminoElJuego

	game := TerniLapilli new.
	
	game put: tokenX1 at: 2@2.
	game put: tokenO1 at: 2@3.
	game put: tokenX2 at: 1@1.
	game put: tokenO2 at: 3@1.
	game put: tokenX3 at: 3@3.
	
	self
		should: [ game put: tokenO3 at: 2@1]
		raise: Error
		withMessageText: TerniLapilli gameOverError.
	
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'FE 6/14/2020 13:47:06'!
test13SePuedeMoverUnaFichaTrasColocarLasPrimeras6

	game := TerniLapilli new.
	
	"game move: 1@1 to: 2@2."
	
	! !


!classDefinition: #TerniLapilli category: #'TerniLapilli - Ejercicio'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'playerTurn board'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli - Ejercicio'!

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'FE 6/14/2020 14:33:58'!
board

	^board 
		
	! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'FE 6/14/2020 14:31:38'!
initialize

	super initialize.
	playerTurn  := 'X'.
	board := TerniLapilliBoard new.
	! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'SC 6/13/2020 19:46:44'!
isOver

	^board existsThreeInLine! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'SC 6/13/2020 18:18:41'!
isPlayingO

	^playerTurn  = 'O'.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'FE 6/11/2020 21:04:03'!
isPlayingX

	^playerTurn  = 'X'.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'SC 6/13/2020 20:51:19'!
isTied

	^self isOver not! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'FE 6/14/2020 14:57:34'!
put: aToken at: aPosition

	(self isOver)
		ifTrue: [self error: self class gameOverError.].

	board validatePosition: aPosition.

	(aToken kind = 'X')
	
		ifTrue: [(playerTurn = 'X')
			ifTrue: [board add: aToken at: aPosition.
				      playerTurn  := 'O'.
					board displayBoard addMorph: aToken display position: (aPosition -1) * 100 + 25.				
				    ]
			ifFalse: [self error: self class incorrectTurnError.].]
		
		ifFalse: [(playerTurn = 'O')
			ifTrue: [board add: aToken at: aPosition.
				      playerTurn := 'X'.
					board displayBoard addMorph: aToken display position: (aPosition -1) * 100 + 25.
					]
			ifFalse: [self error: self class incorrectTurnError]].
		
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'TerniLapilli - Ejercicio'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'SC 6/13/2020 19:47:58'!
gameOverError
	
	^'The game is over :('.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'FE 6/11/2020 21:11:05'!
incorrectTurnError
	
	^'Not is your Turn.'.! !


!classDefinition: #TerniLapilliBoard category: #'TerniLapilli - Ejercicio'!
Object subclass: #TerniLapilliBoard
	instanceVariableNames: 'xTokens oTokens displayBoard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli - Ejercicio'!

!TerniLapilliBoard methodsFor: 'as yet unclassified' stamp: 'SC 6/13/2020 20:40:44'!
add: aToken at: aPosition

	aToken kind = 'X'
		ifTrue: [xTokens add: aToken -> aPosition.]
		ifFalse: [oTokens add: aToken -> aPosition.].! !

!TerniLapilliBoard methodsFor: 'as yet unclassified' stamp: 'SC 6/13/2020 20:40:44'!
addOToken: aPosition

	oTokens add: aPosition! !

!TerniLapilliBoard methodsFor: 'as yet unclassified' stamp: 'SC 6/13/2020 20:40:34'!
addXToken: aPosition

	xTokens add: aPosition! !

!TerniLapilliBoard methodsFor: 'as yet unclassified' stamp: 'SC 6/13/2020 19:55:59'!
allEqual: aListOfNumbers

	^(aListOfNumbers size = 3) and: [(aListOfNumbers max = aListOfNumbers min) ]
	! !

!TerniLapilliBoard methodsFor: 'as yet unclassified' stamp: 'FE 6/14/2020 14:32:59'!
displayBoard

	^displayBoard.! !

!TerniLapilliBoard methodsFor: 'as yet unclassified' stamp: 'SC 6/13/2020 20:40:44'!
existsThreeInLine

	^(self hasThreeInLine: xTokens) or: [self hasThreeInLine: oTokens].
	
	! !

!TerniLapilliBoard methodsFor: 'as yet unclassified' stamp: 'SC 6/13/2020 21:04:28'!
hasDiagonal: aDictionaryTokensToPostitions

	| coordinates |
	
	coordinates := SortedCollection new.
	aDictionaryTokensToPostitions keysDo: [ :token | 
				coordinates add: (aDictionaryTokensToPostitions at: token) ].
	
	^(coordinates = {(1@1) . (2@2) . (3@3)} asSortedCollection) 
			or: [coordinates = {(1@3) . (2@2) . (3@1)} asSortedCollection].! !

!TerniLapilliBoard methodsFor: 'as yet unclassified' stamp: 'SC 6/13/2020 21:04:03'!
hasThreeInLine: aDictionaryTokensToPositions

	| xCoordinates yCoordinates |
	
	xCoordinates := OrderedCollection new.
	aDictionaryTokensToPositions keysDo: [ :aToken | 
					xCoordinates add: (aDictionaryTokensToPositions at: aToken) x].
				
	yCoordinates := OrderedCollection new.
	aDictionaryTokensToPositions keysDo: [ :aToken | 
					yCoordinates add: (aDictionaryTokensToPositions at: aToken) y].

	^(self allEqual: xCoordinates) | (self allEqual: yCoordinates) | (self hasDiagonal: aDictionaryTokensToPositions) ! !

!TerniLapilliBoard methodsFor: 'as yet unclassified' stamp: 'SC 6/13/2020 20:40:44'!
hasTokenIn: aPosition

	^(xTokens includes: aPosition) or: [oTokens includes: aPosition].! !

!TerniLapilliBoard methodsFor: 'as yet unclassified' stamp: 'FE 6/14/2020 14:32:31'!
initialize

	super initialize.
	xTokens := Dictionary new.
	oTokens := Dictionary new.
	displayBoard := TerniLapilliDisplay new initializeWith: 300@300.! !

!TerniLapilliBoard methodsFor: 'as yet unclassified' stamp: 'SC 6/13/2020 20:40:44'!
numberOfTokens

	^xTokens size + oTokens size! !

!TerniLapilliBoard methodsFor: 'as yet unclassified' stamp: 'SC 6/13/2020 18:53:18'!
validatePosition: aPosition

	(aPosition x between: 1 and: 3) & (aPosition y between: 1 and: 3)
		ifFalse: [self error: self class boardLimitError.].

	(self numberOfTokens = 6)
		ifTrue: [self error: self class tokensLimitError].

	(self hasTokenIn: aPosition)
		ifTrue: [self error: self class busyPositionError.].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliBoard class' category: #'TerniLapilli - Ejercicio'!
TerniLapilliBoard class
	instanceVariableNames: ''!

!TerniLapilliBoard class methodsFor: 'as yet unclassified' stamp: 'SC 6/13/2020 19:02:53'!
boardLimitError

	^'Position out of board'! !

!TerniLapilliBoard class methodsFor: 'as yet unclassified' stamp: 'SC 6/13/2020 19:03:01'!
busyPositionError

	^'This position is busy'! !

!TerniLapilliBoard class methodsFor: 'as yet unclassified' stamp: 'SC 6/13/2020 19:01:18'!
tokensLimitError

	^'6 tokens already in board'! !


!classDefinition: #TerniLapilliDisplay category: #'TerniLapilli - Ejercicio'!
Object subclass: #TerniLapilliDisplay
	instanceVariableNames: 'displayBoard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli - Ejercicio'!

!TerniLapilliDisplay methodsFor: 'as yet unclassified' stamp: 'FE 6/14/2020 19:40:46'!
initializeWith: aSize

	| lineX1 lineX2 lineX3 lineY1 lineY2 lineY3 testMode |
	
	testMode := 'On'.

	displayBoard := RectangleLikeMorph new.
	displayBoard morphHeight: aSize y.
	displayBoard morphWidth: aSize x.
	displayBoard color: Color white.
	
	lineX1 := RectangleLikeMorph new.
	lineX1 morphHeight: 2.
	lineX1 morphWidth: aSize x - 98.
	lineX1 color: Color black.
	
	lineX2 := RectangleLikeMorph new.
	lineX2 morphHeight: 2.
	lineX2 morphWidth: aSize x - 98.
	lineX2 color: Color black.
	
	lineX3 := RectangleLikeMorph new.
	lineX3 morphHeight: 2.
	lineX3 morphWidth: aSize x - 98.
	lineX3 color: Color black.
	
	lineY1 := RectangleLikeMorph new.
	lineY1 morphHeight: aSize y - 98.
	lineY1 morphWidth: 2.
	lineY1 color: Color black.
	
	lineY2 := RectangleLikeMorph new.
	lineY2 morphHeight: aSize y - 98.
	lineY2 morphWidth: 2.
	lineY2 color: Color black.
	
	lineY3 := RectangleLikeMorph new.
	lineY3 morphHeight: aSize y - 98.
	lineY3 morphWidth: 2.
	lineY3 color: Color black.
	
	displayBoard addMorph: lineX1 position: 45@45.
	displayBoard addMorph: lineX2 position: 45@145.
	displayBoard addMorph: lineX3 position: 45@245.
	
	displayBoard addMorph: lineY1 position: 47@45.
	displayBoard addMorph: lineY2 position: 149@45.
	displayBoard addMorph: lineY3 position: 249@45.
	
	
	testMode = 'Off'
		ifTrue: [ displayBoard openInWorld ].
	
	^ displayBoard.
		
	! !


!classDefinition: #TerniLapilliDisplayToken category: #'TerniLapilli - Ejercicio'!
TerniLapilliDisplay subclass: #TerniLapilliDisplayToken
	instanceVariableNames: 'displayToken'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli - Ejercicio'!

!TerniLapilliDisplayToken methodsFor: 'as yet unclassified' stamp: 'FE 6/14/2020 14:26:38'!
initializeWith: aColor

	displayToken := EllipseMorph new color: aColor.	
	
	^displayToken.
	
	! !


!classDefinition: #Token category: #'TerniLapilli - Ejercicio'!
Object subclass: #Token
	instanceVariableNames: 'position displayToken'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli - Ejercicio'!

!Token methodsFor: 'as yet unclassified' stamp: 'FE 6/14/2020 14:33:11'!
display
	
	^displayToken. 

	! !

!Token methodsFor: 'as yet unclassified' stamp: 'FE 6/14/2020 13:51:01'!
initialize

	self subclassResponsibility. ! !

!Token methodsFor: 'as yet unclassified' stamp: 'SC 6/13/2020 20:32:27'!
kind 

	self subclassResponsibility ! !

!Token methodsFor: 'as yet unclassified' stamp: 'FE 6/14/2020 14:33:11'!
moveDisplay: aPosition

	displayToken morphPosition: aPosition.! !


!classDefinition: #TokenO category: #'TerniLapilli - Ejercicio'!
Token subclass: #TokenO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli - Ejercicio'!

!TokenO methodsFor: 'as yet unclassified' stamp: 'FE 6/14/2020 14:33:11'!
initialize

	displayToken := TerniLapilliDisplayToken new initializeWith: Color red.
! !

!TokenO methodsFor: 'as yet unclassified' stamp: 'SC 6/13/2020 20:32:01'!
kind

	^'O'! !


!classDefinition: #TokenX category: #'TerniLapilli - Ejercicio'!
Token subclass: #TokenX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli - Ejercicio'!

!TokenX methodsFor: 'as yet unclassified' stamp: 'FE 6/14/2020 14:33:11'!
initialize

	displayToken := TerniLapilliDisplayToken new initializeWith: Color blue.! !

!TokenX methodsFor: 'as yet unclassified' stamp: 'SC 6/13/2020 20:32:08'!
kind 

	^'X'! !
