!classDefinition: #MarsRoverTest category: #MarsRoverEj!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEj'!

!MarsRoverTest methodsFor: 'aux' stamp: 'SC 6/6/2020 17:21:30'!
assert: aMarsRover hasPosition: aPosition andDirection: aDirection

	self assert: aMarsRover position = aPosition. 
	self assert: aMarsRover direction  = aDirection. ! !


!MarsRoverTest methodsFor: 'tests' stamp: 'SC 6/6/2020 17:14:15'!
test01MarsRoverInitializePosition

	marsRover := MarsRover at: 2@2 heading: $N.
	
	self assert: marsRover position = (2@2).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'SC 6/6/2020 17:13:59'!
test02MarsRoverInitializeDirection

	marsRover := MarsRover at: 2@2 heading: $N.
	
	self assert: marsRover direction = $N.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'SC 6/6/2020 17:22:22'!
test03MarsRoverAdvancesNorth

	marsRover := MarsRover at: 2@2 heading: $N.
	
	marsRover receive: 'f'.
	
	self assert: marsRover 
		           hasPosition: 2@1 
				andDirection: $N.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'SC 6/6/2020 17:22:48'!
test04MarsRoverRespondsEmptyMessage

	marsRover := MarsRover at: 2@2 heading: $N.
	
	marsRover receive: ''.
	
	self assert: marsRover 
		           hasPosition: 2@2 
				andDirection: $N.
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'SC 6/6/2020 17:22:59'!
test05MarsRoverAdvancesManyTimesNorth

	marsRover := MarsRover at: 2@4 heading: $N.
	
	marsRover receive: 'fff'.
	
	self assert: marsRover 
		           hasPosition: 2@1 
				andDirection: $N.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'SC 6/6/2020 17:23:08'!
test06MarsRoverGoesBackHeadingNorth

	marsRover := MarsRover at: 2@2 heading: $N.
	
	marsRover receive: 'b'.
	
	self assert: marsRover 
		           hasPosition: 2@3
				andDirection: $N.
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'SC 6/6/2020 17:23:21'!
test07MarsRoverTurnsLeftHeadingNorth

	marsRover := MarsRover at: 2@2 heading: $N.
	
	marsRover receive: 'l'.
	
	self assert: marsRover 
		           hasPosition: 2@2
				andDirection: $O.
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'SC 6/6/2020 17:23:31'!
test08MarsRoverTurnsRightHeadingNorth

	marsRover := MarsRover at: 2@2 heading: $N.
	
	marsRover receive: 'r'.
	
	self assert: marsRover 
		           hasPosition: 2@2
				andDirection: $E.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'SC 6/6/2020 17:23:47'!
test09MarsRoverAdvancesHeadingSouth

	marsRover := MarsRover at: 2@2 heading: $S.
	
	marsRover receive: 'f'.
	
	self assert: marsRover 
		           hasPosition: 2@3 
				andDirection: $S.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'SC 6/6/2020 17:23:57'!
test10MarsRoverGoesBackHeadingSouth

	marsRover := MarsRover at: 2@2 heading: $S.
	
	marsRover receive: 'b'.
	
	self assert: marsRover 
		           hasPosition: 2@1 
				andDirection: $S.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'SC 6/6/2020 17:24:13'!
test11MarsRoverStopsWhenReceivingWrongCommand

	marsRover := MarsRover at: 2@2 heading: $E.
	
	marsRover receive: 'fef'.
	
	self assert: marsRover 
		           hasPosition: 3@2 
				andDirection: $E.
! !


!classDefinition: #CardinalPoint category: #MarsRoverEj!
Object subclass: #CardinalPoint
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEj'!

!CardinalPoint methodsFor: 'turning' stamp: 'SC 6/6/2020 16:30:43'!
turnLeft

	self subclassResponsibility.! !

!CardinalPoint methodsFor: 'turning' stamp: 'SC 6/6/2020 16:30:48'!
turnRight

	self subclassResponsibility.! !


!CardinalPoint methodsFor: 'accessing' stamp: 'SC 6/6/2020 16:34:40'!
name

	self subclassResponsibility ! !


!CardinalPoint methodsFor: 'moving' stamp: 'SC 6/6/2020 16:41:06'!
backward

	self subclassResponsibility ! !

!CardinalPoint methodsFor: 'moving' stamp: 'SC 6/6/2020 16:41:02'!
forward

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalPoint class' category: #MarsRoverEj!
CardinalPoint class
	instanceVariableNames: ''!

!CardinalPoint class methodsFor: 'initialize' stamp: 'SC 6/6/2020 16:29:07'!
with: aDirection

	(aDirection = $N)
		ifTrue: [^North new].
		
	(aDirection = $S)
		ifTrue: [^South new].
		
	(aDirection = $E)
		ifTrue: [^East new].
		
	(aDirection = $O)
		ifTrue: [^West new].! !


!classDefinition: #East category: #MarsRoverEj!
CardinalPoint subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEj'!

!East methodsFor: 'accessing' stamp: 'SC 6/6/2020 16:34:32'!
name

	^$E! !


!East methodsFor: 'turning' stamp: 'SC 6/6/2020 16:31:33'!
turnLeft

	^North new.! !

!East methodsFor: 'turning' stamp: 'SC 6/6/2020 16:31:29'!
turnRight

	^South new.! !


!East methodsFor: 'moving' stamp: 'SC 6/6/2020 16:40:48'!
backward

	^-1@0! !

!East methodsFor: 'moving' stamp: 'SC 6/6/2020 16:37:32'!
forward

	^1@0! !


!classDefinition: #North category: #MarsRoverEj!
CardinalPoint subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEj'!

!North methodsFor: 'accessing' stamp: 'SC 6/6/2020 16:34:28'!
name

	^$N! !


!North methodsFor: 'turning' stamp: 'SC 6/6/2020 16:30:10'!
turnLeft

	^West new.! !

!North methodsFor: 'turning' stamp: 'SC 6/6/2020 16:31:49'!
turnRight

	^East new.! !


!North methodsFor: 'moving' stamp: 'SC 6/6/2020 16:40:41'!
backward

	^0@1! !

!North methodsFor: 'moving' stamp: 'SC 6/6/2020 16:37:46'!
forward

	^0@-1! !


!classDefinition: #South category: #MarsRoverEj!
CardinalPoint subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEj'!

!South methodsFor: 'accessing' stamp: 'SC 6/6/2020 16:34:20'!
name

	^$S! !


!South methodsFor: 'turning' stamp: 'SC 6/6/2020 16:30:23'!
turnLeft

	^East new.! !

!South methodsFor: 'turning' stamp: 'SC 6/6/2020 16:31:57'!
turnRight

	^West new.! !


!South methodsFor: 'moving' stamp: 'SC 6/6/2020 16:40:34'!
backward

	^0@-1! !

!South methodsFor: 'moving' stamp: 'SC 6/6/2020 16:37:56'!
forward

	^0@1! !


!classDefinition: #West category: #MarsRoverEj!
CardinalPoint subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEj'!

!West methodsFor: 'moving' stamp: 'SC 6/6/2020 16:40:27'!
backward

	^1@0! !

!West methodsFor: 'moving' stamp: 'SC 6/6/2020 16:38:04'!
forward

	^-1@0! !


!West methodsFor: 'turning' stamp: 'SC 6/6/2020 16:30:34'!
turnLeft

	^South new.! !

!West methodsFor: 'turning' stamp: 'SC 6/6/2020 16:32:06'!
turnRight

	^North new.! !


!West methodsFor: 'accessing' stamp: 'SC 6/6/2020 16:34:10'!
name

	^$O! !


!classDefinition: #MarsRover category: #MarsRoverEj!
Object subclass: #MarsRover
	instanceVariableNames: 'direction position commandRules'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEj'!

!MarsRover methodsFor: 'initialization' stamp: 'SC 6/6/2020 16:58:53'!
defineRules

	commandRules at: $f put: [self goForward].
	commandRules at: $b put: [self goBack].
	commandRules at: $r put: [self turnRight].
	commandRules at: $l put: [self  turnLeft].! !

!MarsRover methodsFor: 'initialization' stamp: 'SC 6/6/2020 17:11:04'!
initializeAtRandom
	
	| directions rng |
	
	directions := {$N.$S.$E.$O}.
	rng := Random new.
	
	position := (rng nextInteger: 100)@(rng nextInteger: 100).
	direction := CardinalPoint with: (directions at: (rng nextInteger: 4)).
	
	self initializeRules ! !

!MarsRover methodsFor: 'initialization' stamp: 'SC 6/6/2020 17:10:51'!
initializeRules

	commandRules := Dictionary new.
	self defineRules.! !

!MarsRover methodsFor: 'initialization' stamp: 'SC 6/6/2020 17:11:13'!
initializeWithPosition: aPosition andDirection: aDirection 
	
	position := aPosition.
	direction := CardinalPoint with: aDirection.
	
	self initializeRules ! !


!MarsRover methodsFor: 'moving' stamp: 'SC 6/6/2020 16:40:09'!
goBack

	position _ position + direction backward ! !

!MarsRover methodsFor: 'moving' stamp: 'SC 6/6/2020 16:39:39'!
goForward

	position _ position + direction forward ! !


!MarsRover methodsFor: 'accessing' stamp: 'SC 6/6/2020 16:33:59'!
direction

	^direction name! !

!MarsRover methodsFor: 'accessing' stamp: 'SC 6/4/2020 21:05:53'!
position

	^position! !


!MarsRover methodsFor: 'turning' stamp: 'SC 6/6/2020 16:32:44'!
turnLeft

	direction _ direction turnLeft.

	! !

!MarsRover methodsFor: 'turning' stamp: 'SC 6/6/2020 16:32:55'!
turnRight

	direction _ direction turnRight.
	! !


!MarsRover methodsFor: 'receive' stamp: 'SC 6/7/2020 23:36:00'!
receive: anArrayOfCommands 

	anArrayOfCommands do: [ :command |
		
		(commandRules at: command
						  ifAbsent: [^self]) value
						
	].
				! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRoverEj!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'initialize' stamp: 'SC 6/4/2020 21:05:23'!
at: aPosition heading: aDirection
 
	^self new initializeWithPosition: aPosition andDirection: aDirection! !
