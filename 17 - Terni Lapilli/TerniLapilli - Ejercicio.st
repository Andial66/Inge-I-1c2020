!classDefinition: #TerniLapilliTest category: #'TerniLapilli - Ejercicio'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli - Ejercicio'!

!TerniLapilliTest methodsFor: 'auxiliares' stamp: 'SC 6/15/2020 20:04:41'!
doPuts: aListOfPositions In: aTerniLapilli

	1 to: aListOfPositions size do: [ :i |
		(i odd) 
			ifTrue: [aTerniLapilli putXAt: (aListOfPositions at: i)]
			ifFalse: [aTerniLapilli putOAt: (aListOfPositions at: i)] 
			].! !


!TerniLapilliTest methodsFor: 'test' stamp: 'FE 6/11/2020 21:06:56'!
test01ElJugadorInicialEsX
	
	game := TerniLapilli new.
	
	self assert: game isPlayingX.! !

!TerniLapilliTest methodsFor: 'test' stamp: 'SC 6/15/2020 18:47:20'!
test02SiJugoElJugadorXElTurnoEsDelJugadorO

	game := TerniLapilli new.
	
	game putXAt: 1@1.
	
	self assert: game isPlayingO.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'SC 6/15/2020 18:48:40'!
test03SiJugoElJugadorOElTurnoEsDelJugadorX

	game := TerniLapilli new.
	
	game putXAt: 2@2.
	game putOAt: 1@1.
	
	self assert: game isPlayingX.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'SC 6/15/2020 18:48:51'!
test04SiEsElTurnoDeXNoPuedeJugarO.

	game := TerniLapilli new.
	
	self
		should: [ game putOAt: 1@1]
		raise: Error
		withMessageText: TerniLapilli incorrectTurnError.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'SC 6/15/2020 18:50:28'!
test05SiEsElTurnoDeONoPuedeJugarX.

	game := TerniLapilli new.
	
	game putXAt: 1@1.
	
	self
		should: [ game putXAt: 2@2]
		raise: Error
		withMessageText: TerniLapilli incorrectTurnError.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'SC 6/15/2020 18:50:43'!
test06NoSePuedePonerUnaFichaEnUnaPosicionOcupada

	game := TerniLapilli new.
	
	game putXAt: 1@1.
	
	self
		should: [ game putOAt: 1@1]
		raise: Error
		withMessageText: TerniLapilliBoard busyPositionError.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'SC 6/15/2020 20:06:32'!
test07NoSePuedenPonerMasDe6Fichas

	game := TerniLapilli new.
	
	self doPuts: { 1@1 . 1@2 . 1@3 . 2@1 . 2@2 . 2@3 } In: game. 
	
	self
		should: [ game putXAt: 3@2]
		raise: Error
		withMessageText: TerniLapilliBoard tokensLimitError.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'SC 6/15/2020 19:08:23'!
test08LasFichasNoPuedenPonerseFueraDelTabler

	game := TerniLapilli new.
	
	self
		should: [ game putXAt: 69@420]
		raise: Error
		withMessageText: TerniLapilliBoard boardLimitError.
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'SC 6/15/2020 20:06:25'!
test09ElJuegoTerminaCon3EnLineaHorizontal

	game := TerniLapilli new.
	
	self doPuts: {1@1 . 1@2 . 2@1 . 2@2 . 3@1} In: game.
	
	self assert: game isOver
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'SC 6/15/2020 20:06:20'!
test10ElJuegoTerminaCon3EnLineaVertical

	game := TerniLapilli new.
	
	self doPuts: {1@1 . 2@3 . 1@2 . 3@3 . 1@3} In: game.
	
	self assert: game isOver
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'SC 6/15/2020 20:07:00'!
test11ElJuegoTerminaCon3EnLineaEnDiagonal

	game := TerniLapilli new.
	
	self doPuts: {2@2 . 2@3 . 1@1 . 3@1 . 3@3 } In: game. 
	
	self assert: game isOver
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'SC 6/15/2020 20:07:27'!
test12NoSePuedePonerUnaFichaSiTerminoElJuego

	game := TerniLapilli new.
	
	self doPuts: {2@2 . 2@3 . 1@1 . 3@1 . 3@3} In: game .
	
	self
		should: [ game putOAt: 2@1]
		raise: Error
		withMessageText: TerniLapilli gameOverError.
	
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'SC 6/15/2020 20:08:03'!
test13SePuedeMoverUnaFichaTrasColocarLasPrimeras6

	game := TerniLapilli new.
	
	self doPuts: {2@2 . 2@3 . 1@1 . 3@1 . 1@3 . 3@2} In: game.
	
	game moveXFrom: 2@2 To: 2@1.
	
	self assert: (game hasTokenXInPosition: 2@1).
	self deny: (game hasTokenXInPosition: 2@2).
	
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'SC 6/15/2020 20:08:41'!
test14NoSePuedeMoverUnaFichaAUnaPosicionOcupada

	game := TerniLapilli new.
	
	self doPuts: {2@2 . 2@3 . 1@1 . 3@1 . 1@3 . 3@2} In: game .
	
	self should: [game moveXFrom: 2@2 To: 2@2.]
		 raise: Error
		 withMessageText: TerniLapilliBoard busyPositionError.
	
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'SC 6/15/2020 20:09:16'!
test15NoSePuedeMoverUnaFichaAfueraDelTablero

	game := TerniLapilli new.
	
	self doPuts: {2@2 . 2@3 . 1@1 . 3@1 . 1@3 . 3@2} In: game . 
	
	self should: [game moveXFrom: 1@1 To: 4@4.]
		 raise: Error
		 withMessageText: TerniLapilliBoard boardLimitError.
	
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'SC 6/15/2020 20:09:43'!
test16NoSePuedeMoverSiTerminoLaPartida

	game := TerniLapilli new.
	
	self doPuts: {1@1 . 2@1 . 1@2 . 2@2 . 3@1 . 2@3} In: game .
	
	self should: [game moveXFrom: 3@1 To: 3@3.]
		 raise: Error
		 withMessageText: TerniLapilli gameOverError.
	
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'SC 6/15/2020 20:10:15'!
test17NoSePuedeMoverOEnTurnoDeX

	game := TerniLapilli new.
	
	self doPuts: {1@1 . 2@1 . 1@2 . 2@2 . 3@1 . 3@2} In: game.
	
	self should: [game moveOFrom: 3@2 To: 3@3.]
		 raise: Error
		 withMessageText: TerniLapilli incorrectTurnError .
	
	! !

!TerniLapilliTest methodsFor: 'test' stamp: 'SC 6/15/2020 20:10:49'!
test18NoSePuedeMoverAPosicionesNoVecinas

	game := TerniLapilli new.
	
	self doPuts: {1@1 . 2@1 . 1@2 . 2@2 . 3@1 . 3@2} In: game . 
	
	self should: [game moveXFrom: 1@2 To: 2@3.]
		 raise: Error
		 withMessageText: TerniLapilliBoard invalidPlayError .
	
	! !


!classDefinition: #TerniLapilli category: #'TerniLapilli - Ejercicio'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'board state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli - Ejercicio'!

!TerniLapilli methodsFor: 'access' stamp: 'FE 6/14/2020 14:33:58'!
board

	^board 
		
	! !

!TerniLapilli methodsFor: 'access' stamp: 'SC 6/15/2020 19:46:34'!
hasTokenOInPosition: aPosition

	^board hasTokenOInPosition: aPosition ! !

!TerniLapilli methodsFor: 'access' stamp: 'SC 6/15/2020 19:46:29'!
hasTokenXInPosition: aPosition

	^board hasTokenXInPosition: aPosition ! !

!TerniLapilli methodsFor: 'access' stamp: 'SC 6/15/2020 19:20:01'!
isOver

	^board existsThreeInLine! !

!TerniLapilli methodsFor: 'access' stamp: 'SC 6/15/2020 18:47:51'!
isPlayingO

	^state isPlayingO ! !

!TerniLapilli methodsFor: 'access' stamp: 'SC 6/15/2020 18:46:05'!
isPlayingX

	^state isPlayingX.! !

!TerniLapilli methodsFor: 'access' stamp: 'SC 6/13/2020 20:51:19'!
isTied

	^self isOver not! !


!TerniLapilli methodsFor: 'operations' stamp: 'SC 6/15/2020 19:31:40'!
moveOFrom: anOriginPosition To: aDestinyPosition

	state moveOFrom: anOriginPosition To: aDestinyPosition from: self.
	
! !

!TerniLapilli methodsFor: 'operations' stamp: 'SC 6/15/2020 19:34:18'!
moveOOnStateOFrom: anOriginPosition To: aDestinyPosition

	board moveOFrom: anOriginPosition To: aDestinyPosition .
	
! !

!TerniLapilli methodsFor: 'operations' stamp: 'SC 6/15/2020 19:31:23'!
moveXFrom: anOriginPosition To: aDestinyPosition

	state moveXFrom: anOriginPosition To: aDestinyPosition from: self.
	
! !

!TerniLapilli methodsFor: 'operations' stamp: 'SC 6/15/2020 19:34:24'!
moveXOnStateXFrom: anOriginPosition To: aDestinyPosition

	board moveXFrom: anOriginPosition To: aDestinyPosition .
	
! !

!TerniLapilli methodsFor: 'operations' stamp: 'SC 6/15/2020 19:21:00'!
putOAt: aPosition

	state putOAt: aPosition from: self.
	
	(self isOver)
		ifTrue: [state _ TerniLapilliStateGameOver new.]
		ifFalse: [state _ TerniLapilliStatePlayingX new].! !

!TerniLapilli methodsFor: 'operations' stamp: 'SC 6/15/2020 18:41:22'!
putOOnStateOAt: aPosition

	board addOAt: aPosition.! !

!TerniLapilli methodsFor: 'operations' stamp: 'SC 6/15/2020 19:16:29'!
putXAt: aPosition

	state putXAt: aPosition from: self.
	
	(self isOver)
		ifTrue: [state _ TerniLapilliStateGameOver new.]
		ifFalse: [state _ TerniLapilliStatePlayingO new].! !

!TerniLapilli methodsFor: 'operations' stamp: 'SC 6/15/2020 18:40:12'!
putXOnStateXAt: aPosition

	board addXAt: aPosition.! !


!TerniLapilli methodsFor: 'initialize' stamp: 'SC 6/15/2020 18:47:30'!
initialize

	super initialize.
	board := TerniLapilliBoard new.
	state := TerniLapilliStatePlayingX new.
	
	
	! !


!TerniLapilli methodsFor: 'exceptions' stamp: 'SC 6/15/2020 18:49:36'!
throwErrorWrongTurn

	^self error: self class incorrectTurnError.! !

!TerniLapilli methodsFor: 'exceptions' stamp: 'SC 6/15/2020 19:25:53'!
throwGameOverError

	^self error: self class gameOverError .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'TerniLapilli - Ejercicio'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'SC 6/15/2020 17:39:10'!
cantMoveWithoutSixTokensError

	^'You have to play 6 tokens before moving'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'SC 6/13/2020 19:47:58'!
gameOverError
	
	^'The game is over :('.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'FE 6/11/2020 21:11:05'!
incorrectTurnError
	
	^'Not is your Turn.'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'SC 6/15/2020 17:36:50'!
tokensLimitError

	^'6 tokens already in board'! !


!classDefinition: #TerniLapilliBoard category: #'TerniLapilli - Ejercicio'!
Object subclass: #TerniLapilliBoard
	instanceVariableNames: 'xTokens oTokens displayBoard xTokensDisplay oTokensDisplay'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli - Ejercicio'!

!TerniLapilliBoard methodsFor: 'access' stamp: 'SC 6/13/2020 19:55:59'!
allEqual: aListOfNumbers

	^(aListOfNumbers size = 3) and: [(aListOfNumbers max = aListOfNumbers min) ]
	! !

!TerniLapilliBoard methodsFor: 'access' stamp: 'SC 6/13/2020 20:40:44'!
existsThreeInLine

	^(self hasThreeInLine: xTokens) or: [self hasThreeInLine: oTokens].
	
	! !

!TerniLapilliBoard methodsFor: 'access' stamp: 'SC 6/15/2020 19:11:07'!
hasDiagonal: aListOfPositions
	
	^(aListOfPositions = {(1@1) . (2@2) . (3@3)} asSortedCollection) 
			or: [aListOfPositions = {(1@3) . (2@2) . (3@1)} asSortedCollection].! !

!TerniLapilliBoard methodsFor: 'access' stamp: 'SC 6/15/2020 19:10:34'!
hasThreeInLine: aListOfPositions

	| xCoordinates yCoordinates |
	
	xCoordinates := aListOfPositions collect: [ :aPosition | aPosition x].
				
	yCoordinates := aListOfPositions collect: [ :aPosition | aPosition y].

	^(self allEqual: xCoordinates) | (self allEqual: yCoordinates) | (self hasDiagonal: aListOfPositions) ! !

!TerniLapilliBoard methodsFor: 'access' stamp: 'SC 6/13/2020 20:40:44'!
hasTokenIn: aPosition

	^(xTokens includes: aPosition) or: [oTokens includes: aPosition].! !

!TerniLapilliBoard methodsFor: 'access' stamp: 'SC 6/15/2020 19:45:47'!
hasTokenOInPosition: aPosition

	^oTokens includes: aPosition .! !

!TerniLapilliBoard methodsFor: 'access' stamp: 'SC 6/15/2020 19:45:37'!
hasTokenXInPosition: aPosition

	^xTokens includes: aPosition .! !

!TerniLapilliBoard methodsFor: 'access' stamp: 'SC 6/13/2020 20:40:44'!
numberOfTokens

	^xTokens size + oTokens size! !

!TerniLapilliBoard methodsFor: 'access' stamp: 'SC 6/15/2020 19:06:52'!
validateAdd: aPosition

	self validatePosition: aPosition.

	(self numberOfTokens = 6)
		ifTrue: [self error: self class tokensLimitError].! !

!TerniLapilliBoard methodsFor: 'access' stamp: 'SC 6/15/2020 19:42:56'!
validateOMoveFrom: anOriginPosition To: aDestinyPosition

	self validatePosition: aDestinyPosition .
	
	(oTokens includes: anOriginPosition)  & (anOriginPosition fourNeighbors includes: aDestinyPosition )
		ifFalse: [self error: self class invalidPlayError ].
		
	! !

!TerniLapilliBoard methodsFor: 'access' stamp: 'SC 6/15/2020 19:37:56'!
validatePosition: aPosition

	(aPosition x between: 1 and: 3) & (aPosition y between: 1 and: 3)
		ifFalse: [self error: self class boardLimitError.].

	(self hasTokenIn: aPosition)
		ifTrue: [self error: self class busyPositionError.].! !

!TerniLapilliBoard methodsFor: 'access' stamp: 'SC 6/15/2020 19:43:06'!
validateXMoveFrom: anOriginPosition To: aDestinyPosition

	self validatePosition: aDestinyPosition .
	
	(xTokens includes: anOriginPosition ) & (anOriginPosition fourNeighbors includes: aDestinyPosition )
		ifFalse: [self error: self class invalidPlayError ].! !


!TerniLapilliBoard methodsFor: 'operations' stamp: 'FE 6/15/2020 22:27:47'!
addOAt: aPosition
	
	self validateAdd: aPosition.
	
	oTokens add: aPosition.
	
	" Codigo Parte Grafica "
	self refreshDisplay.! !

!TerniLapilliBoard methodsFor: 'operations' stamp: 'FE 6/15/2020 22:28:00'!
addXAt: aPosition
		
	self validateAdd: aPosition.
	
	xTokens add: aPosition.
	
	self refreshDisplay.! !

!TerniLapilliBoard methodsFor: 'operations' stamp: 'FE 6/15/2020 22:49:28'!
moveOFrom: anOriginPosition To: aDestinyPosition

	self validateOMoveFrom: anOriginPosition To: aDestinyPosition.
	
	oTokens remove: anOriginPosition .
	oTokens add: aDestinyPosition .
	
	" Codigo Parte Grafica "
	self refreshDisplay.! !

!TerniLapilliBoard methodsFor: 'operations' stamp: 'FE 6/15/2020 22:49:37'!
moveXFrom: anOriginPosition To: aDestinyPosition

	
	self validateXMoveFrom: anOriginPosition To: aDestinyPosition.
	
	xTokens remove: anOriginPosition .
	xTokens add: aDestinyPosition .
	
	" Codigo Parte Grafica "
	self refreshDisplay.	
	! !


!TerniLapilliBoard methodsFor: 'display' stamp: 'FE 6/15/2020 22:48:35'!
refreshDisplay

	| tokenODisplay tokenXDisplay |
	
	" Codigo Parte Grafica "
	
	oTokensDisplay do: [:aTokenDisplay | displayBoard removeMorph: aTokenDisplay].
	oTokensDisplay removeAll.
	oTokens do: [:aToken | 
				tokenODisplay _ TerniLapilliDisplayToken new initializeWith: Color blue.
				oTokensDisplay add: tokenODisplay.
				displayBoard addMorph: tokenODisplay position: aToken + 24 +  ((aToken-1)*100).  ].
			
	xTokensDisplay do: [:aTokenDisplay | displayBoard removeMorph: aTokenDisplay].
	xTokensDisplay removeAll.
	xTokens do: [:aToken | 
				tokenXDisplay _ TerniLapilliDisplayToken new initializeWith: Color red.
				xTokensDisplay add: tokenXDisplay .
				displayBoard addMorph: tokenXDisplay position: aToken + 24 +  ((aToken-1)*100).  ].! !


!TerniLapilliBoard methodsFor: 'initialize' stamp: 'FE 6/15/2020 22:47:19'!
initialize

	super initialize.
	xTokens := SortedCollection new.
	oTokens := SortedCollection new.
	displayBoard := TerniLapilliDisplay new initializeWith: 300@300.
	xTokensDisplay := OrderedCollection new.
	oTokensDisplay := OrderedCollection new.
	! !

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

!TerniLapilliBoard class methodsFor: 'as yet unclassified' stamp: 'SC 6/15/2020 18:58:31'!
invalidPlayError

	^'Invalid play'! !

!TerniLapilliBoard class methodsFor: 'as yet unclassified' stamp: 'SC 6/15/2020 19:07:53'!
tokensLimitError

	^'6 tokens already in board'! !


!classDefinition: #TerniLapilliDisplay category: #'TerniLapilli - Ejercicio'!
Object subclass: #TerniLapilliDisplay
	instanceVariableNames: 'displayBoard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli - Ejercicio'!

!TerniLapilliDisplay methodsFor: 'as yet unclassified' stamp: 'FE 6/15/2020 20:38:13'!
drawHorizontalLineWidth: aWidth AndHeight: aHeight AndColor: aColor AtPosition: aPosition
	
	| line |
	
	line := RectangleLikeMorph new.
	line morphHeight: aHeight.
	line morphWidth: aWidth.
	line color: Color black.
	
	displayBoard addMorph: line position: aPosition.
	
	
	
	
		
	! !

!TerniLapilliDisplay methodsFor: 'as yet unclassified' stamp: 'FE 6/15/2020 20:38:57'!
drawVerticalLineWidth: aWidth AndHeight: aHeight AndColor: aColor AtPosition: aPosition
	
	| line |
	
	line := RectangleLikeMorph new.
	line morphHeight: aHeight.
	line morphWidth: aWidth.
	line color: Color black.
	
	displayBoard addMorph: line position: aPosition.
	
	
	
	
		
	! !

!TerniLapilliDisplay methodsFor: 'as yet unclassified' stamp: 'FE 6/15/2020 22:51:22'!
initializeWith: aSize

	| testMode |
	
	testMode := 'On'.

	displayBoard := RectangleLikeMorph new.
	displayBoard morphHeight: aSize y.
	displayBoard morphWidth: aSize x.
	displayBoard color: Color white.
	
	self drawHorizontalLineWidth: (aSize x - 98) AndHeight: 2 AndColor: Color black AtPosition: 47@45. 
	self drawHorizontalLineWidth: (aSize x - 98) AndHeight: 2 AndColor: Color black AtPosition: 47@145. 
	self drawHorizontalLineWidth: (aSize x - 98) AndHeight: 2 AndColor: Color black AtPosition: 47@245. 
	
	self drawHorizontalLineWidth: 2 AndHeight: (aSize y - 98) AndColor: Color black AtPosition: 47@45. 
	self drawHorizontalLineWidth: 2 AndHeight: (aSize y - 98) AndColor: Color black AtPosition: 149@45. 
	self drawHorizontalLineWidth: 2 AndHeight: (aSize y - 98) AndColor: Color black AtPosition: 249@45.
		
	testMode = 'Off'
		ifTrue: [ displayBoard openInWorld ].
	
	^displayBoard. 
		
	! !


!classDefinition: #TerniLapilliDisplayToken category: #'TerniLapilli - Ejercicio'!
TerniLapilliDisplay subclass: #TerniLapilliDisplayToken
	instanceVariableNames: 'displayToken'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli - Ejercicio'!

!TerniLapilliDisplayToken methodsFor: 'as yet unclassified' stamp: 'FE 6/15/2020 21:38:37'!
initializeWith: aColor

	displayToken := EllipseMorph new color: aColor.	
	
	^displayToken.
	
	! !


!classDefinition: #TerniLapilliState category: #'TerniLapilli - Ejercicio'!
Object subclass: #TerniLapilliState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli - Ejercicio'!

!TerniLapilliState methodsFor: 'access' stamp: 'SC 6/15/2020 20:11:57'!
isPlayingO

	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'access' stamp: 'SC 6/15/2020 20:11:53'!
isPlayingX

	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'access' stamp: 'SC 6/15/2020 20:12:29'!
moveOFrom: anOriginPosition To: aDestinyPosition from: TerniLapilli

	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'access' stamp: 'SC 6/15/2020 20:12:32'!
moveXFrom: anOriginPosition To: aDestinyPosition from: TerniLapilli

	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'access' stamp: 'SC 6/15/2020 20:12:51'!
putOAt: aPosition From: TerniLapilli

	self subclassResponsibility ! !

!TerniLapilliState methodsFor: 'access' stamp: 'SC 6/15/2020 20:12:54'!
putXAt: aPosition From: TerniLapilli

	self subclassResponsibility ! !


!classDefinition: #TerniLapilliStateGameOver category: #'TerniLapilli - Ejercicio'!
TerniLapilliState subclass: #TerniLapilliStateGameOver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli - Ejercicio'!

!TerniLapilliStateGameOver methodsFor: 'access' stamp: 'SC 6/15/2020 19:21:32'!
isPlayingO

	^TerniLapilli gameOverError .! !

!TerniLapilliStateGameOver methodsFor: 'access' stamp: 'SC 6/15/2020 19:25:30'!
isPlayingX

	^TerniLapilli gameOverError .! !

!TerniLapilliStateGameOver methodsFor: 'access' stamp: 'SC 6/15/2020 19:33:49'!
moveOFrom: anOriginPosition To: aDestinyPosition from: TerniLapilli.

	TerniLapilli throwGameOverError .! !

!TerniLapilliStateGameOver methodsFor: 'access' stamp: 'SC 6/15/2020 19:33:46'!
moveXFrom: anOriginPosition To: aDestinyPosition from: TerniLapilli.

	TerniLapilli throwGameOverError .! !

!TerniLapilliStateGameOver methodsFor: 'access' stamp: 'SC 6/15/2020 19:25:17'!
putOAt: aPositions from: TerniLapilli

	^TerniLapilli throwGameOverError .! !

!TerniLapilliStateGameOver methodsFor: 'access' stamp: 'SC 6/15/2020 19:25:05'!
putXAt: aPositions from: TerniLapilli

	^TerniLapilli throwGameOverError .! !


!classDefinition: #TerniLapilliStatePlayingO category: #'TerniLapilli - Ejercicio'!
TerniLapilliState subclass: #TerniLapilliStatePlayingO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli - Ejercicio'!

!TerniLapilliStatePlayingO methodsFor: 'access' stamp: 'SC 6/15/2020 18:46:40'!
isPlayingO

	^true.
	! !

!TerniLapilliStatePlayingO methodsFor: 'access' stamp: 'SC 6/15/2020 18:46:31'!
isPlayingX

	^false.
	! !

!TerniLapilliStatePlayingO methodsFor: 'access' stamp: 'SC 6/15/2020 19:33:05'!
moveOFrom: anOriginPosition To: aDestinyPosition from: TerniLapilli.

	TerniLapilli moveOOnStateOFrom: anOriginPosition To: aDestinyPosition .! !

!TerniLapilliStatePlayingO methodsFor: 'access' stamp: 'SC 6/15/2020 19:32:48'!
moveXFrom: anOriginPosition To: aDestinyPosition from: TerniLapilli.

	TerniLapilli throwErrorWrongTurn .! !

!TerniLapilliStatePlayingO methodsFor: 'access' stamp: 'SC 6/15/2020 18:36:42'!
putOAt: aPosition from: TerniLapilli

	TerniLapilli putOOnStateOAt: aPosition.

	! !

!TerniLapilliStatePlayingO methodsFor: 'access' stamp: 'SC 6/15/2020 18:36:25'!
putXAt: aPosition from: TerniLapilli

	TerniLapilli throwErrorWrongTurn.

	! !


!classDefinition: #TerniLapilliStatePlayingX category: #'TerniLapilli - Ejercicio'!
TerniLapilliState subclass: #TerniLapilliStatePlayingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli - Ejercicio'!

!TerniLapilliStatePlayingX methodsFor: 'access' stamp: 'SC 6/15/2020 18:46:21'!
isPlayingO

	^false.! !

!TerniLapilliStatePlayingX methodsFor: 'access' stamp: 'SC 6/15/2020 18:46:14'!
isPlayingX

	^true.! !

!TerniLapilliStatePlayingX methodsFor: 'access' stamp: 'SC 6/15/2020 19:33:20'!
moveOFrom: anOriginPosition To: aDestinyPosition from: TerniLapilli.

	TerniLapilli throwErrorWrongTurn .! !

!TerniLapilliStatePlayingX methodsFor: 'access' stamp: 'SC 6/15/2020 19:33:12'!
moveXFrom: anOriginPosition To: aDestinyPosition from: TerniLapilli.

	TerniLapilli moveXOnStateXFrom: anOriginPosition To: aDestinyPosition .! !

!TerniLapilliStatePlayingX methodsFor: 'access' stamp: 'SC 6/15/2020 18:36:04'!
putOAt: aPositon from: TerniLapilli

	TerniLapilli throwErrorWrongTurn.! !

!TerniLapilliStatePlayingX methodsFor: 'access' stamp: 'SC 6/15/2020 18:37:23'!
putXAt: aPosition from: TerniLapilli

	TerniLapilli putXOnStateXAt: aPosition.! !
