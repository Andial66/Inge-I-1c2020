!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: 'aCustomerBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'initialization' stamp: 'FE 5/6/2020 17:38:45'!
setUp

	super setUp.
	aCustomerBook := CustomerBook new. 
! !


!CustomerBookTest methodsFor: 'testing' stamp: 'FE 5/5/2020 21:08:25'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	self assert: (self executionTime: [ aCustomerBook addCustomerNamed: 'John Lennon' ] isLessThan: 50).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FE 5/5/2020 21:11:50'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	
	| paulMcCartney |
	paulMcCartney := 'Paul McCartney'.
  
	aCustomerBook addCustomerNamed: paulMcCartney.
	
	self assert: (self executionTime: [ aCustomerBook removeCustomerNamed: paulMcCartney. ] isLessThan: 100).
		
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FE 5/5/2020 23:52:52'!
test03CanNotAddACustomerWithEmptyName 
      
	aCustomerBook := CustomerBook new.

  	self executeABlock: [aCustomerBook addCustomerNamed: ''] 
		catchError: Error 
		andDo: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
      	self assert: aCustomerBook isEmpty].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FE 5/5/2020 23:53:48'!
test04CanNotRemoveAnInvalidCustomer
  
	| johnLennon |
      
	johnLennon := 'John Lennon'.
	aCustomerBook addCustomerNamed: johnLennon.

	self executeABlock: [aCustomerBook removeCustomerNamed: 'Paul McCartney']  
		catchError: NotFound 
		andDo: [ :anError | 
      		self assert: aCustomerBook numberOfCustomers = 1.
      		self assert: (aCustomerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FE 5/5/2020 21:27:57'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| paulMcCartney|
  
	paulMcCartney := 'Paul McCartney'.
  
	aCustomerBook addCustomerNamed: paulMcCartney.
	aCustomerBook suspendCustomerNamed: paulMcCartney.
	
	self assertSizeOfActives: 0 Suspended: 1 andTotal: 1 From: aCustomerBook. 
 	self assert: (aCustomerBook includesCustomerNamed: paulMcCartney).
  

  
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FE 5/5/2020 21:27:52'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| paulMcCartney|
  
	paulMcCartney := 'Paul McCartney'.
  
	aCustomerBook addCustomerNamed: paulMcCartney.
	aCustomerBook suspendCustomerNamed: paulMcCartney.
	aCustomerBook removeCustomerNamed: paulMcCartney.
  
	self assertSizeOfActives: 0 Suspended: 0 andTotal: 0 From: aCustomerBook. 
	self deny: (aCustomerBook includesCustomerNamed: paulMcCartney).


  
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FE 5/5/2020 23:54:59'!
test07CanNotSuspendAnInvalidCustomer
  
	| johnLennon |
      
	johnLennon := 'John Lennon'.
	aCustomerBook addCustomerNamed: johnLennon.

	self executeABlock: [aCustomerBook suspendCustomerNamed: 'Ringo Starr']  
	catchError: CantSuspend 
	andDo: [ :anError | 
      	self assert: aCustomerBook numberOfCustomers = 1.
      	self assert: (aCustomerBook includesCustomerNamed: johnLennon) ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FE 5/5/2020 23:56:25'!
test08CanNotSuspendAnAlreadySuspendedCustomer
  
	| johnLennon |
      
	johnLennon := 'John Lennon'.
	aCustomerBook addCustomerNamed: johnLennon.
	aCustomerBook suspendCustomerNamed: johnLennon.
 
  	self executeABlock: [aCustomerBook suspendCustomerNamed: johnLennon] 
		catchError: CantSuspend  
		andDo: [ :anError | 
      	self assert: aCustomerBook numberOfCustomers = 1.
      	self assert: (aCustomerBook includesCustomerNamed: johnLennon) ]
! !


!CustomerBookTest methodsFor: 'auxiliar of test' stamp: 'FE 5/5/2020 21:25:27'!
assertSizeOfActives: sizeActive Suspended: sizeSuspended andTotal: sizeTotal From: customerBook
	self assert: sizeActive equals: customerBook numberOfActiveCustomers.
	self assert: sizeSuspended equals: customerBook numberOfSuspendedCustomers.
	self assert: sizeTotal  equals: customerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'auxiliar of test' stamp: 'FE 5/5/2020 23:51:18'!
executeABlock: aBlock catchError: anError andDo: aHandlerBlock
	[aBlock value . self fail] 
		on: anError 
		do: aHandlerBlock.
	! !

!CustomerBookTest methodsFor: 'auxiliar of test' stamp: 'FE 5/5/2020 20:47:37'!
executionTime: aBlock isLessThan: aTimeInMilliseconds
	
	^ (Time millisecondsToRun: aBlock) < (aTimeInMilliseconds * millisecond). 
! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'FE 5/5/2020 20:41:10'!
includesCustomerNamed: aName

	^ (active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'FE 5/5/2020 20:41:07'!
isEmpty
  
	^ active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'FE 5/5/2020 20:40:53'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'FE 5/5/2020 20:38:55'!
addCustomerNamed: aName
	
	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
  	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
  
  	active add: aName! !

!CustomerBook methodsFor: 'customer management' stamp: 'FE 5/5/2020 20:39:02'!
numberOfActiveCustomers
  
	^ active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'FE 5/5/2020 20:39:10'!
numberOfCustomers

	^ self numberOfActiveCustomers + self numberOfSuspendedCustomers 
! !

!CustomerBook methodsFor: 'customer management' stamp: 'FE 5/5/2020 20:39:16'!
numberOfSuspendedCustomers
  
	^ suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'FE 5/5/2020 20:40:18'!
removeCustomerNamed: aName
	
	^ active remove: aName ifAbsent: [ suspended remove: aName ifAbsent: [ NotFound signal ] ] ! !

!CustomerBook methodsFor: 'customer management' stamp: 'FE 5/5/2020 20:40:27'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'FE 5/5/2020 20:40:32'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'FE 5/5/2020 20:40:40'!
suspendCustomerNamed: aName 
  
	(active includes: aName) ifFalse: [^CantSuspend signal].
  
	active remove: aName.
  
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

  ^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

  ^'Customer Name Cannot Be Empty'! !
